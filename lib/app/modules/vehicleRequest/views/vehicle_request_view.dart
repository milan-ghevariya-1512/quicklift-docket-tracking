import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../../../../Reusability/utils/app_colors.dart';
import '../../../../Reusability/utils/app_images.dart';
import '../../../../Reusability/utils/app_textstyle.dart';
import '../../../../Reusability/utils/util.dart';
import '../../../../Reusability/widgets/common_date_picker.dart';
import '../../../../Reusability/widgets/common_shimmer.dart';
import '../../../../Reusability/widgets/common_widget.dart';
import '../../../data/model/fieldSetupModel.dart';
import '../../../data/model/getAutoCompleteCustomerModel.dart';
import '../../../data/model/getAutoCompleteLocationModel.dart';
import '../controllers/vehicle_request_controller.dart';

class VehicleRequestView extends GetView<VehicleRequestController> {
  VehicleRequestView({super.key});

  var c = Get.put(VehicleRequestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          Image.asset(
            AppImage.background,
            fit: BoxFit.fill,
            height: Get.height,
            width: Get.width,
          ),
          Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HBox(MediaQuery.of(context).padding.top + Get.height * 0.015),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                child: AppPageHeader(
                  title: "Vehicle Request",
                  onBack: () => Get.back(),
                ),
              ),
              buildStepIndicator(c.currentStage.value),
              Expanded(
                child: c.isLoaded.value
                    ? const FormShimmer()
                    : GetBuilder<VehicleRequestController>(
                    builder: (cn) {
                      return IndexedStack(
                        index: c.currentStage.value,
                        children: [
                          buildStageFirst(context),
                          buildStageSecond(context),
                          buildStageThird(context),
                          Container(),
                          Container(),
                        ],
                      );
                    }
                ),
              ),
              HBox(Get.height * 0.01),
              Container(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (controller.currentStage.value > 0)
                      InkWell(
                        onTap: () => controller.previousStage(),
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          height: Get.height * 0.06,
                          width: Get.height * 0.06,
                          margin: EdgeInsets.only(right: Get.width * 0.02),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.textBlackColor.withOpacity(0.5)),
                              color: Colors.transparent
                          ),
                          child: const Icon(Icons.chevron_left, color: AppColors.textBlackColor),
                        ),
                      ),
                    Expanded(
                      child: CommonButton(
                        btnHeight: Get.height * 0.06,
                        textVal: controller.currentStage.value == 4 ? "SUBMIT" : "NEXT",
                        onPressed: () {
                          if (controller.currentStage.value == 4) {
                            controller.submitOrder(context);
                          } else {
                            controller.nextStage();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              HBox(MediaQuery.of(context).padding.bottom + Get.height * 0.015)
            ],
          ))
        ],
      ),
    );
  }

  Widget buildStageFirst(context){
    return Form(
      key: controller.formKey1,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
          child: Column(
            children: [

              if (c.getFieldData("VR_CUSTOMERID") != null || (c.getFieldData("VR_CUSTOMERID")?.isInUse ?? false))HBox(Get.height * 0.01),
              if (c.getFieldData("VR_CUSTOMERID") != null || (c.getFieldData("VR_CUSTOMERID")?.isInUse ?? false))Row(
                children: [
                  Text(
                    c.getFieldData("VR_CUSTOMERID")?.fieldCaption ?? '',
                    style: AppTextStyle.regularTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textBlackColor,
                    ),
                  ),
                  if (c.getFieldData("VR_CUSTOMERID")?.isRequired ?? false)
                    Text(
                      " *",
                      style: AppTextStyle.regularTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.redColor,
                      ),
                    ),
                ],
              ),
              if (c.getFieldData("VR_CUSTOMERID") != null || (c.getFieldData("VR_CUSTOMERID")?.isInUse ?? false))HBox(Get.height * 0.01),
              if (c.getFieldData("VR_CUSTOMERID") != null || (c.getFieldData("VR_CUSTOMERID")?.isInUse ?? false))Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        c.isCustomerDropdown.value = !c.isCustomerDropdown.value;
                        c.selectedCustomer = null;
                        c.customerController.clear();
                        c.update();
                      },
                      child: Image.asset(c.isCustomerDropdown.value ? AppImage.radioSelectIcon : AppImage.radioIcon, color: AppColors.primaryColor, height: Get.height * 0.025, width: Get.height * 0.025, fit: BoxFit.contain)),
                  WBox(Get.width * 0.02),
                  Expanded(child: c.isCustomerDropdown.value ?
                  FieldScrollWrapper(
                    child: CustomDropdown<GetAutoCompleteCustomerModel>.searchRequest(
                      futureRequest: (term) => c.getAutoCompleteCustomerList(term),
                      hintText: c.getFieldData("VR_CUSTOMERID")?.fieldCaption ?? '',
                      initialItem: c.selectedCustomer,
                      searchHintText: c.getFieldData("VR_CUSTOMERID")?.fieldCaption ?? '',
                      validator: (value) {
                        if ((c.getFieldData("VR_CUSTOMERID")?.isRequired ?? false) && (value == null)) {
                          return "Required";
                        }
                        return null;
                      },
                      enabled: (c.getFieldData("VR_CUSTOMERID")?.isEnable ?? false),
                      decoration: CustomDropdownDecoration(
                        closedFillColor: AppColors.whiteColor,
                        expandedFillColor: AppColors.whiteColor,
                        closedBorderRadius: BorderRadius.circular(30),
                        expandedBorderRadius: BorderRadius.circular(30),
                        searchFieldDecoration: SearchFieldDecoration(
                          fillColor: (c.getFieldData("VR_CUSTOMERID")?.isEnable ?? false) ? AppColors.whiteColor : AppColors.borderColor.withOpacity(0.5),
                          contentPadding: EdgeInsets.symmetric(vertical: Get.height * 0.01, horizontal: Get.width * 0.02),
                          hintStyle: AppTextStyle.regularTextStyle.copyWith(color: AppColors.hintTextColor, fontSize: 14),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: AppColors.hintTextColor)),
                          textStyle: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor, fontSize: 14, fontWeight: FontWeight.w500),
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(top: Get.height * 0.013, bottom: Get.height * 0.013, left: Get.height * 0.01),
                            child: Image.asset(AppImage.searchIcon, height: Get.height * 0.01, width: Get.height * 0.01, fit: BoxFit.contain,),
                          ),
                          constraints: BoxConstraints(),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: AppColors.borderColor)),
                        ),
                        closedBorder: Border.all(color: AppColors.borderColor),
                        expandedBorder: Border.all(color: AppColors.borderColor),
                        hintStyle: AppTextStyle.regularTextStyle.copyWith(
                          color: AppColors.hintTextColor,
                          fontSize: 14,
                        ),
                      ),
                      listItemPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                      listItemBuilder: (context, item, isSelected, onItemSelect) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${item.customerCode ?? ''} : ${item.codeDesc ?? ''}",
                              style: AppTextStyle.regularTextStyle.copyWith(fontSize: 14),
                            ),
                            Divider(color: AppColors.borderColor,height: Get.height * 0.03)
                          ],
                        );
                      },
                      headerBuilder: (context, selectedItem, enabled) {
                        return Text(
                          "${selectedItem.customerCode ?? ''} : ${selectedItem.codeDesc ?? ''}",
                          style:  AppTextStyle.regularTextStyle.copyWith( fontSize: 14, fontWeight: FontWeight.w500),
                        );
                      },
                      onChanged: (value) {
                        c.selectedCustomer = value;
                        c.update();
                      },
                    ),
                  ) :
                  FieldScrollWrapper(
                    child: TextFField(
                      hintText: c.getFieldData("VR_CUSTOMERID")?.fieldCaption ?? '',
                      controller: c.customerController,
                      fillColor: (c.getFieldData("VR_CUSTOMERID")?.isEnable ?? false) ? AppColors.whiteColor : AppColors.borderColor.withOpacity(0.5),
                      enabled: (c.getFieldData("VR_CUSTOMERID")?.isEnable ?? false),
                      readOnly: !(c.getFieldData("VR_CUSTOMERID")?.isEnable ?? false),
                      validator: (value) {
                        if ((c.getFieldData("VR_CUSTOMERID")?.isRequired ?? false) && ((value ?? '').isEmpty)) {
                          return "Required";
                        }
                        return null;
                      },
                    ),
                  ))
                ],
              ),

              buildDynamicField("VR_MANUALNO", controller: c.manualNoController),

              buildDynamicField("VR_REQUESTDATE",
                customInput: Obx(() => TextFField(
                    readOnly: true,
                    controller: TextEditingController(
                      text: Utils().formatDateTime(c.requestDateTime.value),
                    ),
                    onTap: () {
                      Get.dialog(
                        CommonDateTimePicker(
                          minDate: DateTime.now().subtract(const Duration(days: 5)),
                          initialDateTime: c.requestDateTime.value,
                          onDateTimeSelected: (dateTime) {
                            c.requestDateTime.value = dateTime;
                          },
                        ),
                      );
                    },
                    hintText: c.getFieldData("VR_REQUESTDATE")?.fieldCaption,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: Get.width * 0.04),
                      child: Image.asset(
                        AppImage.calendarIcon,
                        height: Get.height * 0.045,
                        width: Get.height * 0.045,
                        fit: BoxFit.contain,
                      ),
                    ),
                    validator: (v) {
                      if (c.getFieldData("VR_REQUESTDATE")?.isRequired == true) {
                        if (c.requestDateTime.value == null) {
                          return "Required";
                        }
                      }
                      return null;
                    },
                  ))
              ),

              buildDynamicField("VR_REMARKS", controller: c.remarksController),

              buildDynamicField("VR_FROMLOCATION",
                customInput: CustomDropdown<GetAutoCompleteLocationModel>.searchRequest(
                  futureRequest: (term) => c.getAutoCompleteLocation(term),
                  hintText: c.getFieldData("VR_FROMLOCATION")?.fieldCaption ?? '',
                  initialItem: c.selectedFromLocation,
                  validator: (value) {
                    if (c.getFieldData("VR_FROMLOCATION")?.isRequired == true) {
                      if (value == null) {
                        return "     Required";
                      }
                    }
                    return null;
                  },
                  searchHintText: c.getFieldData("VR_FROMLOCATION")?.fieldCaption ?? '',
                  decoration: CustomDropdownDecoration(
                    closedFillColor: AppColors.whiteColor,
                    expandedFillColor: AppColors.whiteColor,
                    closedBorderRadius: BorderRadius.circular(30),
                    expandedBorderRadius: BorderRadius.circular(30),
                    searchFieldDecoration: SearchFieldDecoration(
                      fillColor: AppColors.whiteColor,
                      contentPadding: EdgeInsets.symmetric(vertical: Get.height * 0.01, horizontal: Get.width * 0.02),
                      hintStyle: AppTextStyle.regularTextStyle.copyWith(color: AppColors.hintTextColor, fontSize: 14),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: AppColors.hintTextColor)),
                      textStyle: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor, fontSize: 14, fontWeight: FontWeight.w500),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.013, bottom: Get.height * 0.013, left: Get.height * 0.01),
                        child: Image.asset(
                          AppImage.searchIcon,
                          height: Get.height * 0.01,
                          width: Get.height * 0.01,
                          fit: BoxFit.contain,
                        ),
                      ),
                      constraints: BoxConstraints(),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: AppColors.borderColor)),
                    ),
                    closedErrorBorderRadius: BorderRadius.circular(30),
                    closedErrorBorder: Border.all(color: AppColors.redColor),
                    errorStyle: AppTextStyle.regularTextStyle.copyWith(color: AppColors.redColor, fontSize: 12),
                    closedBorder: Border.all(color: AppColors.borderColor),
                    expandedBorder: Border.all(color: AppColors.borderColor),
                    hintStyle: AppTextStyle.regularTextStyle.copyWith(
                      color: AppColors.hintTextColor,
                      fontSize: 14,
                    ),
                  ),
                  listItemPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                  listItemBuilder: (context, item, isSelected, onItemSelect) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${item.locationCode ?? ''} : ${item.codeDesc ?? ''}",
                          style: AppTextStyle.regularTextStyle.copyWith(fontSize: 14),
                        ),
                        Divider(color: AppColors.borderColor, height: Get.height * 0.03)
                      ],
                    );
                  },
                  headerBuilder: (context, selectedItem, enabled) {
                    return Text(
                      "${selectedItem.locationCode ?? ''} : ${selectedItem.codeDesc ?? ''}",
                      style: AppTextStyle.regularTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                    );
                  },
                  onChanged: (value) {
                    c.selectedFromLocation = value;
                    c.update();
                  },
                ),
              ),

              buildDynamicField("VR_TOLOCATION",
                customInput: CustomDropdown<GetAutoCompleteLocationModel>.searchRequest(
                  futureRequest: (term) => c.getAutoCompleteLocation(term),
                  hintText: c.getFieldData("VR_TOLOCATION")?.fieldCaption ?? '',
                  initialItem: c.selectedToLocation,
                  validator: (value) {
                    if (c.getFieldData("VR_TOLOCATION")?.isRequired == true) {
                      if (value == null) {
                        return "     Required";
                      }
                    }
                    return null;
                  },
                  searchHintText: c.getFieldData("VR_TOLOCATION")?.fieldCaption ?? '',
                  decoration: CustomDropdownDecoration(
                    closedFillColor: AppColors.whiteColor,
                    expandedFillColor: AppColors.whiteColor,
                    closedBorderRadius: BorderRadius.circular(30),
                    expandedBorderRadius: BorderRadius.circular(30),
                    searchFieldDecoration: SearchFieldDecoration(
                      fillColor: AppColors.whiteColor,
                      contentPadding: EdgeInsets.symmetric(vertical: Get.height * 0.01, horizontal: Get.width * 0.02),
                      hintStyle: AppTextStyle.regularTextStyle.copyWith(color: AppColors.hintTextColor, fontSize: 14),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: AppColors.hintTextColor)),
                      textStyle: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor, fontSize: 14, fontWeight: FontWeight.w500),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.013, bottom: Get.height * 0.013, left: Get.height * 0.01),
                        child: Image.asset(
                          AppImage.searchIcon,
                          height: Get.height * 0.01,
                          width: Get.height * 0.01,
                          fit: BoxFit.contain,
                        ),
                      ),
                      constraints: BoxConstraints(),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: AppColors.borderColor)),
                    ),
                    closedErrorBorderRadius: BorderRadius.circular(30),
                    closedErrorBorder: Border.all(color: AppColors.redColor),
                    errorStyle: AppTextStyle.regularTextStyle.copyWith(color: AppColors.redColor, fontSize: 12),
                    closedBorder: Border.all(color: AppColors.borderColor),
                    expandedBorder: Border.all(color: AppColors.borderColor),
                    hintStyle: AppTextStyle.regularTextStyle.copyWith(
                      color: AppColors.hintTextColor,
                      fontSize: 14,
                    ),
                  ),
                  listItemPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                  listItemBuilder: (context, item, isSelected, onItemSelect) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${item.locationCode ?? ''} : ${item.codeDesc ?? ''}",
                          style: AppTextStyle.regularTextStyle.copyWith(fontSize: 14),
                        ),
                        Divider(color: AppColors.borderColor, height: Get.height * 0.03)
                      ],
                    );
                  },
                  headerBuilder: (context, selectedItem, enabled) {
                    return Text(
                      "${selectedItem.locationCode ?? ''} : ${selectedItem.codeDesc ?? ''}",
                      style: AppTextStyle.regularTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                    );
                  },
                  onChanged: (value) {
                    c.selectedToLocation = value;
                    c.update();
                  },
                ),
              ),

              buildDynamicField("VR_EXPLOADINGDATE",
                  customInput: Obx(() => TextFField(
                    readOnly: true,
                    controller: TextEditingController(
                      text: Utils().formatDateTime(c.expLoadingDateTime.value),
                    ),
                    onTap: () {
                      Get.dialog(
                        CommonDateTimePicker(
                          minDate: DateTime.now().subtract(const Duration(days: 5)),
                          initialDateTime: c.expLoadingDateTime.value,
                          onDateTimeSelected: (dateTime) {
                            c.expLoadingDateTime.value = dateTime;
                          },
                        ),
                      );
                    },
                    hintText: c.getFieldData("VR_EXPLOADINGDATE")?.fieldCaption,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: Get.width * 0.04),
                      child: Image.asset(
                        AppImage.calendarIcon,
                        height: Get.height * 0.045,
                        width: Get.height * 0.045,
                        fit: BoxFit.contain,
                      ),
                    ),
                    validator: (v) {
                      if (c.getFieldData("VR_EXPLOADINGDATE")?.isRequired == true) {
                        if (c.expLoadingDateTime.value == null) {
                          return "Required";
                        }
                      }
                      return null;
                    },
                  ))
              ),

              buildDynamicField("VR_EXPTRNSIDAY",
                controller: c.expectedTransitionDaysController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
              ),

              buildDynamicField("VR_EXPDELIVERYTIME",
                customInput: Obx(() => TextFField(
                    readOnly: true,
                    controller: TextEditingController(
                      text: Utils().formatDateTime(c.expDeliveryDateTime.value),
                    ),
                    onTap: () {
                      Get.dialog(
                        CommonDateTimePicker(
                          minDate: DateTime.now().subtract(const Duration(days: 5)),
                          initialDateTime: c.expDeliveryDateTime.value,
                          onDateTimeSelected: (dateTime) {
                            c.expDeliveryDateTime.value = dateTime;
                          },
                        ),
                      );
                    },
                    hintText: c.getFieldData("VR_EXPDELIVERYTIME")?.fieldCaption,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: Get.width * 0.04),
                      child: Image.asset(
                        AppImage.calendarIcon,
                        height: Get.height * 0.045,
                        width: Get.height * 0.045,
                        fit: BoxFit.contain,
                      ),
                    ),
                    validator: (v) {
                      if (c.getFieldData("VR_EXPDELIVERYTIME")?.isRequired == true) {
                        if (c.expDeliveryDateTime.value == null) {
                          return "Required";
                        }
                      }
                      return null;
                    },
                  ))
              ),

              buildDynamicField("VR_EXP_VEHICLE_DATE",
                customInput: Obx(() => TextFField(
                    readOnly: true,
                    controller: TextEditingController(
                      text: Utils().formatDateTime(c.vehicleExpReportingDateTime.value),
                    ),
                    onTap: () {
                      Get.dialog(
                        CommonDateTimePicker(
                          minDate: DateTime.now().subtract(const Duration(days: 5)),
                          initialDateTime: c.vehicleExpReportingDateTime.value,
                          onDateTimeSelected: (dateTime) {
                            c.vehicleExpReportingDateTime.value = dateTime;
                          },
                        ),
                      );
                    },
                    hintText: c.getFieldData("VR_EXP_VEHICLE_DATE")?.fieldCaption,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: Get.width * 0.04),
                      child: Image.asset(
                        AppImage.calendarIcon,
                        height: Get.height * 0.045,
                        width: Get.height * 0.045,
                        fit: BoxFit.contain,
                      ),
                    ),
                    validator: (v) {
                      if (c.getFieldData("VR_EXP_VEHICLE_DATE")?.isRequired == true) {
                        if (c.vehicleExpReportingDateTime.value == null) {
                          return "Required";
                        }
                      }
                      return null;
                    },
                  ))
              ),

              HBox(MediaQuery.of(context).padding.bottom + Get.height * 0.035)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStageSecond(context){
    return Form(
      key: controller.formKey2,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
          child: Column(
            children: [

              HBox(MediaQuery.of(context).padding.bottom + Get.height * 0.035)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStageThird(context){
    return Form(
      key: controller.formKey3,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
          child: Column(
            children: [

              if (c.getFieldData("VR_ISBIDDING") != null || (c.getFieldData("VR_ISBIDDING")?.isInUse ?? false))HBox(Get.height * 0.01),
              if (c.getFieldData("VR_ISBIDDING") != null || (c.getFieldData("VR_ISBIDDING")?.isInUse ?? false))Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        c.isBiddingRequired.value = !c.isBiddingRequired.value;
                        c.update();
                      },
                      child: Image.asset(c.isBiddingRequired.value ? AppImage.radioSelectIcon : AppImage.radioIcon, color: AppColors.primaryColor, height: Get.height * 0.025, width: Get.height * 0.025, fit: BoxFit.contain)),
                  WBox(Get.width * 0.02),
                  Expanded(child: Text(
                    c.getFieldData("VR_ISBIDDING")?.fieldCaption ?? '',
                    style: AppTextStyle.regularTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textBlackColor,
                    ),
                  ))
                ],
              ),
              if (c.getFieldData("VR_ISBIDDING") != null || (c.getFieldData("VR_ISBIDDING")?.isInUse ?? false))HBox(Get.height * 0.01),

              if ((c.getFieldData("VR_ISBIDDING") != null || (c.getFieldData("VR_ISBIDDING")?.isInUse ?? false)) && c.isBiddingRequired.value)Obx(() => TextFField(
                readOnly: true,
                controller: TextEditingController(
                  text: Utils().formatDateTime(c.requestDateTime.value),
                ),
                onTap: () {
                  Get.dialog(
                    CommonDateTimePicker(
                      minDate: DateTime.now().subtract(const Duration(days: 5)),
                      initialDateTime: c.requestDateTime.value,
                      onDateTimeSelected: (dateTime) {
                        c.requestDateTime.value = dateTime;
                      },
                    ),
                  );
                },
                hintText: c.getFieldData("VR_REQUESTDATE")?.fieldCaption,
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: Get.width * 0.04),
                  child: Image.asset(
                    AppImage.calendarIcon,
                    height: Get.height * 0.045,
                    width: Get.height * 0.045,
                    fit: BoxFit.contain,
                  ),
                ),
                validator: (v) {
                  if (c.getFieldData("VR_REQUESTDATE")?.isRequired == true) {
                    if (c.requestDateTime.value == null) {
                      return "Required";
                    }
                  }
                  return null;
                },
              )),

              HBox(MediaQuery.of(context).padding.bottom + Get.height * 0.035)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDynamicField(String fieldId, {Widget? customInput, List<TextInputFormatter>? inputFormatters,bool? enabled, TextInputType? keyboardType,Widget? suffixIcon,TextEditingController? controller, String? Function(String?)? customValidator}) {
    return GetBuilder<VehicleRequestController>(
      builder: (c) {
        FieldSetupModel? config = c.getFieldData(fieldId);

        if (config == null || !config.isInUse) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HBox(Get.height * 0.01),
            Row(
              children: [
                Text(
                  config.fieldCaption.tr,
                  style: AppTextStyle.regularTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textBlackColor,
                  ),
                ),
                if (config.isRequired)
                  Text(
                    " *",
                    style: AppTextStyle.regularTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.redColor,
                    ),
                  ),
              ],
            ),
            HBox(Get.height * 0.01),
            FieldScrollWrapper(
              child: customInput ?? TextFField(
                controller: controller,
                keyboardType: keyboardType,
                inputFormatters: inputFormatters,
                hintText: config.fieldCaption,
                enabled: enabled ?? config.isEnable,
                readOnly: enabled ?? !config.isEnable,
                fillColor: (enabled ?? true) ? AppColors.whiteColor : AppColors.borderColor.withOpacity(0.5),
                validator: customValidator ?? (value) {
                  if (config.isRequired && (value == null || value.trim().isEmpty)) {
                    return "Required";
                  }
                  return null;
                },
                suffixIcon: suffixIcon,
              ),
            ),
            HBox(Get.height * 0.01),
          ],
        );
      },
    );
  }

  Widget buildStepIndicator(int currentStage) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HBox(Get.height * 0.02),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                (currentStage + 1).toString().padLeft(2, '0'),
                style: AppTextStyle.regularTextStyle.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textBlackColor,
                  height: 1.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: Text(
                  "/05",
                  style: AppTextStyle.regularTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.hintTextColor,
                  ),
                ),
              ),
            ],
          ),
          HBox(Get.height * 0.01),
          Text(
            c.stageTitles[currentStage],
            style: AppTextStyle.regularTextStyle.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              color: AppColors.textBlackColor.withOpacity(0.8),
            ),
          ),
          HBox(Get.height * 0.01),
        ],
      ),
    );
  }
}
