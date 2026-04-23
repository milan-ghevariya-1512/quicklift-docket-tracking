import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:quicklift_docket_tracking/app/data/model/getAutoCompleteServiceModeModel.dart';

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
import '../../../data/model/getAutoCompleteVehicleFtlTypeModel.dart';
import '../../../data/model/getAutoCompleteVehicleModel.dart';
import '../../../data/model/getGeneralMasterModel.dart';
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
                          buildStageFourth(context),
                          buildStageFifth(context),
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
              if (c.getFieldData("VR_ISBIDDING") != null || (c.getFieldData("VR_ISBIDDING")?.isInUse ?? false))HBox(Get.height * 0.02),

              if ((c.getFieldData("VR_ISBIDDING") != null || (c.getFieldData("VR_ISBIDDING")?.isInUse ?? false)) && c.isBiddingRequired.value)Obx(() => TextFField(
                readOnly: true,
                controller: TextEditingController(
                  text: Utils().formatDateTime(c.biddingStartDateTime.value),
                ),
                onTap: () {
                  Get.dialog(
                    CommonDateTimePicker(
                      minDate: DateTime.now().subtract(const Duration(days: 5)),
                      maxDate: DateTime(5050),
                      initialDateTime: c.biddingStartDateTime.value,
                      onDateTimeSelected: (dateTime) {
                        c.biddingStartDateTime.value = dateTime;
                      },
                    ),
                  );
                },
                hintText: "Bidding Start Date",
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
                  final start = c.biddingStartDateTime.value;
                  final request = c.requestDateTime.value;

                  if (start == null) {
                    return "Required";
                  }

                  if (request != null) {
                    final s = DateTime(start.year, start.month, start.day, start.hour, start.minute);
                    final r = DateTime(request.year, request.month, request.day, request.hour, request.minute);

                    if (s.isBefore(r)) {
                      return "Bid Start Date should be same or after Request Date";
                    }
                  }

                  return null;
                },
              )),
              if ((c.getFieldData("VR_ISBIDDING") != null || (c.getFieldData("VR_ISBIDDING")?.isInUse ?? false)) && c.isBiddingRequired.value)HBox(Get.height * 0.015),
              if ((c.getFieldData("VR_ISBIDDING") != null || (c.getFieldData("VR_ISBIDDING")?.isInUse ?? false)) && c.isBiddingRequired.value)Obx(() => TextFField(
                readOnly: true,
                controller: TextEditingController(
                  text: Utils().formatDateTime(c.biddingEndDateTime.value),
                ),
                onTap: () {
                  Get.dialog(
                    CommonDateTimePicker(
                      minDate: DateTime.now().subtract(const Duration(days: 5)),
                      maxDate: DateTime(5050),
                      initialDateTime: c.biddingEndDateTime.value,
                      onDateTimeSelected: (dateTime) {
                        c.biddingEndDateTime.value = dateTime;
                      },
                    ),
                  );
                },
                hintText: "Bidding End Date",
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
                  final end = c.biddingEndDateTime.value;
                  final start = c.biddingStartDateTime.value;
                  if (end == null) {
                    return "Required";
                  }
                  if (start != null && !end.isAfter(start)) {
                    return "Bid End Date should be after Bid Start Date";
                  }
                  return null;
                },
              )),
              if ((c.getFieldData("VR_ISBIDDING") != null || (c.getFieldData("VR_ISBIDDING")?.isInUse ?? false)) && c.isBiddingRequired.value)HBox(Get.height * 0.01),

              if ((c.getFieldData("VR_ISBIDDING") != null || (c.getFieldData("VR_ISBIDDING")?.isInUse ?? false)) && c.isBiddingRequired.value)Obx(() => buildDynamicField("VR_ISCAPRATE",
                customInput: Row(
                  children: [
                    InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          c.isMaxAmount.value = !c.isMaxAmount.value;
                          c.update();
                        },
                        child: Image.asset(c.isMaxAmount.value ? AppImage.radioSelectIcon : AppImage.radioIcon, color: AppColors.primaryColor, height: Get.height * 0.025, width: Get.height * 0.025, fit: BoxFit.contain)),
                    WBox(Get.width * 0.02),
                    Expanded(child: TextFField(
                      controller: c.maxAmountController,
                      hintText: c.getFieldData("VR_ISCAPRATE")?.fieldCaption ?? '',
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      enabled: c.isMaxAmount.value,
                      readOnly: !c.isMaxAmount.value,
                      fillColor: c.isMaxAmount.value ? AppColors.whiteColor : AppColors.borderColor.withOpacity(0.5),
                      validator: (value) {
                        if(c.getFieldData("VR_ISCAPRATE")?.isRequired==true){
                          if(value == null || value.trim().isEmpty){
                            return "Required";
                          }
                        }
                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'),),
                      ],
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: Get.width * 0.05),
                        child: Icon(Icons.currency_rupee),
                      ),
                    ))
                  ],
                ),
              )),

              if ((c.getFieldData("VR_ISBIDDING") != null || (c.getFieldData("VR_ISBIDDING")?.isInUse ?? false)) && c.isBiddingRequired.value)buildDynamicField("VR_BIDDINGNOTE", controller: c.biddingNoteController),
              if ((c.getFieldData("VR_ISBIDDING") != null || (c.getFieldData("VR_ISBIDDING")?.isInUse ?? false)) && c.isBiddingRequired.value)buildDynamicField("VR_ACCEPTBIDFROM", customInput: Obx(() => Padding(
                padding: EdgeInsets.only(top: Get.height * 0.01),
                child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  c.acceptBidFrom.value = 'AOO';
                                  c.update();
                                },
                                child: Image.asset(c.acceptBidFrom.value == 'AOO' ? AppImage.radioSelectIcon : AppImage.radioIcon, color: AppColors.primaryColor, height: Get.height * 0.025, width: Get.height * 0.025, fit: BoxFit.contain)),
                            WBox(Get.width * 0.02),
                            Expanded(child: Text(
                              'Lane Wise',
                              style: AppTextStyle.regularTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textBlackColor,
                              ),
                            ))
                          ],
                        ),
                      ),
                      WBox(Get.width * 0.02),
                      Expanded(
                        child: Row(
                          children: [
                            InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  c.acceptBidFrom.value = 'AOP';
                                  c.update();
                                },
                                child: Image.asset(c.acceptBidFrom.value == "AOP" ? AppImage.radioSelectIcon : AppImage.radioIcon, color: AppColors.primaryColor, height: Get.height * 0.025, width: Get.height * 0.025, fit: BoxFit.contain)),
                            WBox(Get.width * 0.02),
                            Expanded(child: Text(
                              'Specific Vendor',
                              style: AppTextStyle.regularTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textBlackColor,
                              ),
                            ))
                          ],
                        ),
                      ),
                    ],
                  ),
              ))),

              if ((c.getFieldData("VR_ISBIDDING") != null || (c.getFieldData("VR_ISBIDDING")?.isInUse ?? false)) && c.isBiddingRequired.value)buildDynamicField("VR_BIDVENDOR", controller: c.vendorController),

              HBox(MediaQuery.of(context).padding.bottom + Get.height * 0.035)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStageFourth(context){
    return Form(
      key: controller.formKey4,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
          child: Column(
            children: [

              buildDynamicField("VR_REQUIRED_VEH",
                controller: c.noOfVehicleController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                suffixIcon: Text("Unit", style: AppTextStyle.regularTextStyle.copyWith(fontSize: 10, fontWeight: FontWeight.w600))
              ),

              buildDynamicField("VR_SERVICEMODE",
                customInput: DropdownButtonFormField<ServiceModeList>(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (c.getFieldData("VR_SERVICEMODE")?.isRequired ?? true) {
                      if (value == null) {
                        return 'Required';
                      }
                    }
                    return null;
                  },
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(20),
                  menuMaxHeight: Get.height * 0.5,
                  value: c.selectedServiceMode == null ? null : c.selectedServiceMode,
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.textBlackColor,
                  ),
                  style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.hintTextColor, fontSize: 14),
                  hint: Text(
                    c.getFieldData("VR_SERVICEMODE")?.fieldCaption ?? '',
                    style: AppTextStyle.regularTextStyle.copyWith(
                      color: c.serviceModeList.isEmpty ? AppColors.borderColor : AppColors.hintTextColor,
                      fontSize: 14,
                    ),
                  ),
                  decoration: InputDecoration(
                    counterText: "",
                    filled: true,
                    fillColor: AppColors.whiteColor,
                    contentPadding: EdgeInsets.symmetric(vertical: Get.height * 0.018, horizontal: Get.width * 0.04),
                    hintText: c.getFieldData("VR_SERVICEMODE")?.fieldCaption ?? '',
                    hintStyle: AppTextStyle.regularTextStyle.copyWith(color: AppColors.hintTextColor, fontSize: 14),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: AppColors.hintTextColor)),
                    disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: AppColors.borderColor)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: AppColors.borderColor)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: AppColors.borderColor)),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(width: 1, color: AppColors.redColor),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(width: 1, color: AppColors.redColor),
                    ),
                    errorStyle: AppTextStyle.regularTextStyle.copyWith(color: AppColors.redColor, fontSize: 12),
                  ),
                  onChanged: (value) {
                    c.selectedServiceMode = value;
                    c.update();
                  },
                  items: c.serviceModeList.map((option) {
                    return DropdownMenuItem<ServiceModeList>(
                      value: option,
                      child: Text(
                        maxLines: 1,
                        option.codeDesc ?? '',
                        style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor, fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    );
                  }).toList(),
                ),
              ),

              buildDynamicField("VR_FTLTYPE",
                customInput: DropdownButtonFormField<GetAutoCompleteVehicleFtlTypeList>(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (c.getFieldData("VR_FTLTYPE")?.isRequired ?? true) {
                      if (value == null) {
                        return 'Required';
                      }
                    }
                    return null;
                  },
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(20),
                  menuMaxHeight: Get.height * 0.5,
                  value: c.selectedVehicleFtlType == null ? null : c.selectedVehicleFtlType,
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.textBlackColor,
                  ),
                  style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.hintTextColor, fontSize: 14),
                  hint: Text(
                    c.getFieldData("VR_FTLTYPE")?.fieldCaption ?? '',
                    style: AppTextStyle.regularTextStyle.copyWith(
                      color: c.vehicleFtlTypeList.isEmpty ? AppColors.borderColor : AppColors.hintTextColor,
                      fontSize: 14,
                    ),
                  ),
                  decoration: InputDecoration(
                    counterText: "",
                    filled: true,
                    fillColor: AppColors.whiteColor,
                    contentPadding: EdgeInsets.symmetric(vertical: Get.height * 0.018, horizontal: Get.width * 0.04),
                    hintText: c.getFieldData("VR_FTLTYPE")?.fieldCaption ?? '',
                    hintStyle: AppTextStyle.regularTextStyle.copyWith(color: AppColors.hintTextColor, fontSize: 14),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: AppColors.hintTextColor)),
                    disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: AppColors.borderColor)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: AppColors.borderColor)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: AppColors.borderColor)),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(width: 1, color: AppColors.redColor),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(width: 1, color: AppColors.redColor),
                    ),
                    errorStyle: AppTextStyle.regularTextStyle.copyWith(color: AppColors.redColor, fontSize: 12),
                  ),
                  onChanged: (value) {
                    c.selectedVehicleFtlType = value;
                    c.selectedVehicleType = null;
                    c.getAutoCompleteVehicleType("%", c.selectedVehicleFtlType?.codeId ?? '');
                    c.update();
                  },
                  items: c.vehicleFtlTypeList.map((option) {
                    return DropdownMenuItem<GetAutoCompleteVehicleFtlTypeList>(
                      value: option,
                      child: Text(
                        maxLines: 1,
                        option.codeDesc ?? '',
                        style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor, fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    );
                  }).toList(),
                ),
              ),

              buildDynamicField("VR_VEHICLETYPE",
                customInput: DropdownButtonFormField<GetAutoCompleteVehicleModel>(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (c.getFieldData("VR_VEHICLETYPE")?.isRequired ?? true) {
                      if (value == null) {
                        return 'Required';
                      }
                    }
                    return null;
                  },
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(20),
                  menuMaxHeight: Get.height * 0.5,
                  value: c.selectedVehicleType == null ? null : c.selectedVehicleType,
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.textBlackColor,
                  ),
                  style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.hintTextColor, fontSize: 14),
                  hint: Text(
                    c.getFieldData("VR_VEHICLETYPE")?.fieldCaption ?? '',
                    style: AppTextStyle.regularTextStyle.copyWith(
                      color: c.vehicleFtlTypeList.isEmpty ? AppColors.borderColor : AppColors.hintTextColor,
                      fontSize: 14,
                    ),
                  ),
                  decoration: InputDecoration(
                    counterText: "",
                    filled: true,
                    fillColor: AppColors.whiteColor,
                    contentPadding: EdgeInsets.symmetric(vertical: Get.height * 0.018, horizontal: Get.width * 0.04),
                    hintText: c.getFieldData("VR_VEHICLETYPE")?.fieldCaption ?? '',
                    hintStyle: AppTextStyle.regularTextStyle.copyWith(color: AppColors.hintTextColor, fontSize: 14),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: AppColors.hintTextColor)),
                    disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: AppColors.borderColor)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: AppColors.borderColor)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: AppColors.borderColor)),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(width: 1, color: AppColors.redColor),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(width: 1, color: AppColors.redColor),
                    ),
                    errorStyle: AppTextStyle.regularTextStyle.copyWith(color: AppColors.redColor, fontSize: 12),
                  ),
                  onChanged: (value) {
                    c.selectedVehicleType = value;
                    c.update();
                  },
                  items: c.vehicleTypeList.map((option) {
                    return DropdownMenuItem<GetAutoCompleteVehicleModel>(
                      value: option,
                      child: Text(
                        maxLines: 1,
                        option.codeDesc ?? '',
                        style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor, fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    );
                  }).toList(),
                ),
              ),

              HBox(MediaQuery.of(context).padding.bottom + Get.height * 0.035)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStageFifth(context){
    return Form(
      key: controller.formKey5,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
          child: Column(
            children: [

              buildDynamicField("VR_MATERIALTYPE",
                customInput: DropdownButtonFormField<GetGeneralMasterModel>(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (c.getFieldData("VR_MATERIALTYPE")?.isRequired ?? true) {
                      if (value == null) {
                        return 'Required';
                      }
                    }
                    return null;
                  },
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(20),
                  menuMaxHeight: Get.height * 0.5,
                  value: c.selectedMaterialType == null ? null : c.selectedMaterialType,
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.textBlackColor,
                  ),
                  style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.hintTextColor, fontSize: 14),
                  hint: Text(
                    c.getFieldData("VR_MATERIALTYPE")?.fieldCaption ?? '',
                    style: AppTextStyle.regularTextStyle.copyWith(
                      color: c.materialTypeList.isEmpty ? AppColors.borderColor : AppColors.hintTextColor,
                      fontSize: 14,
                    ),
                  ),
                  decoration: InputDecoration(
                    counterText: "",
                    filled: true,
                    fillColor: AppColors.whiteColor,
                    contentPadding: EdgeInsets.symmetric(vertical: Get.height * 0.018, horizontal: Get.width * 0.04),
                    hintText: c.getFieldData("VR_MATERIALTYPE")?.fieldCaption ?? '',
                    hintStyle: AppTextStyle.regularTextStyle.copyWith(color: AppColors.hintTextColor, fontSize: 14),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: AppColors.hintTextColor)),
                    disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: AppColors.borderColor)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: AppColors.borderColor)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: AppColors.borderColor)),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(width: 1, color: AppColors.redColor),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(width: 1, color: AppColors.redColor),
                    ),
                    errorStyle: AppTextStyle.regularTextStyle.copyWith(color: AppColors.redColor, fontSize: 12),
                  ),
                  onChanged: (GetGeneralMasterModel? newValue) {
                    c.selectedMaterialType = newValue!;
                    c.update();
                  },
                  items: c.materialTypeList.map((option) {
                    return DropdownMenuItem<GetGeneralMasterModel>(
                      value: option,
                      child: Text(
                        maxLines: 1,
                        option.codeDetail ?? '',
                        style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor, fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    );
                  }).toList(),
                ),
              ),

              buildDynamicField("VR_PACKAGINTYPE",
                customInput: DropdownButtonFormField<GetGeneralMasterModel>(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (c.getFieldData("VR_PACKAGINTYPE")?.isRequired ?? true) {
                      if (value == null) {
                        return 'Required';
                      }
                    }
                    return null;
                  },
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(20),
                  menuMaxHeight: Get.height * 0.5,
                  value: c.selectedPackagingType == null ? null : c.selectedPackagingType,
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.textBlackColor,
                  ),
                  style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.hintTextColor, fontSize: 14),
                  hint: Text(
                    c.getFieldData("VR_PACKAGINTYPE")?.fieldCaption ?? '',
                    style: AppTextStyle.regularTextStyle.copyWith(
                      color: c.packagingTypeList.isEmpty ? AppColors.borderColor : AppColors.hintTextColor,
                      fontSize: 14,
                    ),
                  ),
                  decoration: InputDecoration(
                    counterText: "",
                    filled: true,
                    fillColor: AppColors.whiteColor,
                    contentPadding: EdgeInsets.symmetric(vertical: Get.height * 0.018, horizontal: Get.width * 0.04),
                    hintText: c.getFieldData("VR_PACKAGINTYPE")?.fieldCaption ?? '',
                    hintStyle: AppTextStyle.regularTextStyle.copyWith(color: AppColors.hintTextColor, fontSize: 14),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: AppColors.hintTextColor)),
                    disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: AppColors.borderColor)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: AppColors.borderColor)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: AppColors.borderColor)),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(width: 1, color: AppColors.redColor),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(width: 1, color: AppColors.redColor),
                    ),
                    errorStyle: AppTextStyle.regularTextStyle.copyWith(color: AppColors.redColor, fontSize: 12),
                  ),
                  onChanged: (GetGeneralMasterModel? newValue) {
                    c.selectedPackagingType = newValue!;
                    c.update();
                  },
                  items: c.packagingTypeList.map((option) {
                    return DropdownMenuItem<GetGeneralMasterModel>(
                      value: option,
                      child: Text(
                        maxLines: 1,
                        option.codeDetail ?? '',
                        style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor, fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    );
                  }).toList(),
                ),
              ),

              buildDynamicField("VR_WEIGHT",
                controller: c.wightController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  TextInputFormatter.withFunction((oldValue, newValue) {
                    final text = newValue.text;
                    if (text.isEmpty) return newValue;
                    final regex = RegExp(r'^\d+(\.\d{0,3})?$');
                    if (regex.hasMatch(text)) {
                      return newValue;
                    }
                    return oldValue;
                  }),
                ],
                suffixIcon: Text("TON", style: AppTextStyle.regularTextStyle.copyWith(fontSize: 10, fontWeight: FontWeight.w600))
              ),

              buildDynamicField("VR_RATEAMOUNT",
                customInput: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 4,
                      child: TextFField(
                        controller: c.freightChargeRateController,
                        keyboardType: TextInputType.number,
                        hintText: c.getFieldData("VR_RATEAMOUNT")?.fieldCaption ?? '',
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                          TextInputFormatter.withFunction((oldValue, newValue) {
                            final text = newValue.text;
                            if (text.isEmpty) return newValue;
                            final regex = RegExp(r'^\d+(\.\d{0,2})?$');
                            if (regex.hasMatch(text)) {
                              return newValue;
                            }
                            return oldValue;
                          }),
                        ],
                      )
                    ),
                    WBox(Get.width * 0.02),
                    Expanded(
                      flex: 3,
                      child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        borderRadius: BorderRadius.circular(30),
                        menuMaxHeight: Get.height * 0.5,
                        value: VehicleRequestController.freightChargeModes.contains(c.selectedFreightChargeMode) ? c.selectedFreightChargeMode : VehicleRequestController.freightChargeModes.first,
                        icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textBlackColor, size: 20),
                        style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor, fontSize: 11, fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                          counterText: "",
                          filled: true,
                          fillColor: AppColors.whiteColor,
                          contentPadding: EdgeInsets.symmetric(vertical: Get.height * 0.018, horizontal: Get.width * 0.04),
                          hintText: c.getFieldData("VR_RATEAMOUNT")?.fieldCaption ?? '',
                          hintStyle: AppTextStyle.regularTextStyle.copyWith(color: AppColors.hintTextColor, fontSize: 14),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: AppColors.hintTextColor)),
                          disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: AppColors.borderColor)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: AppColors.borderColor)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: AppColors.borderColor)),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(width: 1, color: AppColors.redColor),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(width: 1, color: AppColors.redColor),
                          ),
                          errorStyle: AppTextStyle.regularTextStyle.copyWith(color: AppColors.redColor, fontSize: 12),
                        ),
                        items: VehicleRequestController.freightChargeModes.map((m) {
                          return DropdownMenuItem<String>(
                            value: m,
                            child: Text(m, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor, fontSize: 14, fontWeight: FontWeight.w500),),
                          );
                        }).toList(),
                        onChanged: c.onFreightChargeModeChanged,
                      ),
                    ),
                  ],
                ),
              ),

              buildDynamicField("VR_FREIGHTCHARGE",
                customInput: TextFField(
                  controller: c.freightChargeTotalController,
                  keyboardType: TextInputType.number,
                  hintText: c.getFieldData("VR_FREIGHTCHARGE")?.fieldCaption ?? '',
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      final text = newValue.text;
                      if (text.isEmpty) return newValue;
                      final regex = RegExp(r'^\d+(\.\d{0,2})?$');
                      if (regex.hasMatch(text)) {
                        return newValue;
                      }
                      return oldValue;
                    }),
                  ],
                  validator: (value) {
                    final config = c.getFieldData("VR_FREIGHTCHARGE");
                    if (config?.isRequired ?? false) {
                      if (c.freightChargeRateController.text.trim().isEmpty &&
                          (value == null || value.trim().isEmpty)) {
                        return 'Required';
                      }
                    }
                    return null;
                  },
                ),
              ),

              buildDynamicField("VR_INSTRUCT_DRIVER", controller: c.driverInstructionController),

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
