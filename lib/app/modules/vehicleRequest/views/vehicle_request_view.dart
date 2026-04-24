import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:quicklift_docket_tracking/app/data/model/getAutoCompleteCityModel.dart';
import 'package:quicklift_docket_tracking/app/data/model/getAutoCompleteLegLocationModel.dart';
import 'package:quicklift_docket_tracking/app/data/model/getAutoCompleteServiceModeModel.dart';
import 'package:quicklift_docket_tracking/app/data/model/legLocationModel.dart';

import '../../../../Reusability/utils/app_colors.dart';
import '../../../../Reusability/utils/app_images.dart';
import '../../../../Reusability/utils/app_textstyle.dart';
import '../../../../Reusability/utils/util.dart';
import '../../../../Reusability/widgets/common_date_picker.dart';
import '../../../../Reusability/widgets/common_shimmer.dart';
import '../../../../Reusability/widgets/common_widget.dart';
import '../../../../Reusability/widgets/google_place_auto_complete_field.dart';
import '../../../data/model/fieldSetupModel.dart';
import '../../../data/model/getAutoCompleteCustomerModel.dart';
import '../../../data/model/getAutoCompleteLocationModel.dart';
import '../../../data/model/getAutoCompleteRateModel.dart';
import '../../../data/model/getAutoCompleteVehicleFtlTypeModel.dart';
import '../../../data/model/getAutoCompleteVehicleModel.dart';
import '../../../data/model/getAutoCompleteVendorModel.dart';
import '../../../data/model/getGeneralMasterModel.dart';
import '../../../data/service/api_url_list.dart';
import '../controllers/vehicle_request_controller.dart';

String legLocationDropdownCaption(LegLocationList e) {
  final d = (e.codeDesc ?? '').trim();
  if (d.isNotEmpty) return d;
  return (e.address ?? '').trim();
}

String legCityDropdownCaption(GetAutoCompleteCityModel e) {
  final d = (e.codeDesc ?? '').trim();
  if (d.isNotEmpty) return d;
  return (e.cityAbrv ?? '').trim();
}

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              if(!(c.vehicleRequestData?.isLegEnable ?? false) && (c.vehicleRequestData?.isCustomerAddress ?? false))Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HBox(Get.height * 0.015),
                  Text(
                    "PreferenceType",
                    style: AppTextStyle.regularTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textBlackColor,
                    ),
                  ),
                  HBox(Get.height * 0.01),
                  Obx(() => Padding(
                    padding: EdgeInsets.only(top: Get.height * 0.01),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  c.selectPreferenceType.value = 'custom';
                                  c.update();
                                },
                                child: Image.asset(c.selectPreferenceType.value == 'custom' ? AppImage.radioSelectIcon : AppImage.radioIcon, color: AppColors.primaryColor, height: Get.height * 0.025, width: Get.height * 0.025, fit: BoxFit.contain)),
                            WBox(Get.width * 0.02),
                            Expanded(child: Text(
                              'Customer Address Wise ',
                              style: AppTextStyle.regularTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textBlackColor,
                              ),
                            ))
                          ],
                        ),
                        HBox(Get.height * 0.015),
                        Row(
                          children: [
                            InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  c.selectPreferenceType.value = 'google';
                                  c.update();
                                },
                                child: Image.asset(c.selectPreferenceType.value == "google" ? AppImage.radioSelectIcon : AppImage.radioIcon, color: AppColors.primaryColor, height: Get.height * 0.025, width: Get.height * 0.025, fit: BoxFit.contain)),
                            WBox(Get.width * 0.02),
                            Expanded(child: Text(
                              'Google Wise',
                              style: AppTextStyle.regularTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textBlackColor,
                              ),
                            ))
                          ],
                        ),
                      ],
                    ),
                  )),
                ],
              ),

              if(!(c.vehicleRequestData?.isLegEnable ?? false) && (c.vehicleRequestData?.isCustomerAddress ?? false))HBox(Get.height * 0.015),

              if(c.selectPreferenceType.value == 'google' &&
                  (c.getFieldData("VR_STARTPOINT") != null && (c.getFieldData("VR_STARTPOINT")?.isInUse ?? false)) &&
                  (c.getFieldData("VR_ENDPOINT") != null && (c.getFieldData("VR_ENDPOINT")?.isInUse ?? false)))Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildDynamicField("VR_STARTPOINT",
                    customInput: FormField<int>(
                      key: c.googleStartLegFormFieldKey,
                      initialValue: 0,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (_) => c.validateGoogleLegGroup(
                        'VR_STARTPOINT',
                        c.startPointController,
                        c.startPointList,
                      ),
                      builder: (field) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.separated(
                            itemCount: c.startPointController.length,
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: CustomGooglePlaceAutoCompleteField(
                                      focusNode: c.startPointFocusNodes[index],
                                      textEditingController: c.startPointController[index],
                                      googleAPIKey: ApiUrlList.googleMapKey,
                                      inputDecoration: InputDecoration(
                                        border: InputBorder.none,
                                        fillColor: AppColors.whiteColor,
                                        contentPadding: EdgeInsets.symmetric(vertical: Get.height * 0.018, horizontal: Get.width * 0.04),
                                        hintText: "Enter a location",
                                        hintStyle: AppTextStyle.regularTextStyle.copyWith(color:AppColors.hintTextColor,fontSize: 14),
                                      ),
                                      textStyle: AppTextStyle.regularTextStyle.copyWith(
                                        color: AppColors.textBlackColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      boxDecoration: BoxDecoration(
                                        color: AppColors.whiteColor,
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(color: AppColors.borderColor),
                                      ),
                                      isLatLngRequired: true,
                                      seperatedBuilder: Divider(color: AppColors.greyColor.withOpacity(0.2)),
                                      isCrossBtnShown: false,
                                      onPlaceSelected: (lat, lng, address, city, state, country, pincode, area) {
                                        c.upsertStartPointLeg(
                                          index,
                                          LegLocationModel(
                                            pointAddress: address,
                                            pointAreaName: area,
                                            pointCity: city,
                                            pointCountry: country,
                                            pointPincode: pincode,
                                            pointState: state,
                                          ),
                                        );
                                        FocusScope.of(context).unfocus();
                                      },
                                    ),
                                  ),
                                  WBox(Get.width * 0.015),
                                  if (c.startPointController.length > 1)
                                    InkWell(
                                      onTap: () {
                                        c.removeStartPointRow(index);
                                      },
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      child: Icon(Icons.close, color: AppColors.redColor, size: 25),
                                    ),
                                  if (c.startPointController.length > 1) WBox(Get.width * 0.015),
                                  if (index == c.startPointController.length - 1)
                                    InkWell(
                                      onTap: () {
                                        c.addStartPointRow();
                                      },
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      child: Icon(Icons.add, color: AppColors.primaryColor, size: 30),
                                    )
                                ],
                              );
                            },
                            separatorBuilder: (context, index) => HBox(Get.height * 0.01),
                          ),
                          if (field.hasError)
                            Padding(
                              padding: EdgeInsets.only(top: Get.height * 0.008),
                              child: Text(
                                field.errorText ?? '',
                                style: AppTextStyle.regularTextStyle.copyWith(
                                  color: AppColors.redColor,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  buildDynamicField("VR_ENDPOINT",
                    customInput: FormField<int>(
                      key: c.googleEndLegFormFieldKey,
                      initialValue: 0,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (_) => c.validateGoogleLegGroup(
                        'VR_ENDPOINT',
                        c.endPointController,
                        c.endPointList,
                      ),
                      builder: (field) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.separated(
                            itemCount: c.endPointController.length,
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: CustomGooglePlaceAutoCompleteField(
                                      focusNode: c.endPointFocusNodes[index],
                                      textEditingController: c.endPointController[index],
                                      googleAPIKey: ApiUrlList.googleMapKey,
                                      inputDecoration: InputDecoration(
                                        border: InputBorder.none,
                                        fillColor: AppColors.whiteColor,
                                        contentPadding: EdgeInsets.symmetric(vertical: Get.height * 0.018, horizontal: Get.width * 0.04),
                                        hintText: "Enter a location",
                                        hintStyle: AppTextStyle.regularTextStyle.copyWith(color:AppColors.hintTextColor,fontSize: 14),
                                      ),
                                      textStyle: AppTextStyle.regularTextStyle.copyWith(
                                        color: AppColors.textBlackColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      boxDecoration: BoxDecoration(
                                        color: AppColors.whiteColor,
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(color: AppColors.borderColor),
                                      ),
                                      isLatLngRequired: true,
                                      seperatedBuilder: Divider(color: AppColors.greyColor.withOpacity(0.2)),
                                      isCrossBtnShown: false,
                                      onPlaceSelected: (lat, lng, address, city, state, country, pincode, area) {
                                        c.upsertEndPointLeg(
                                          index,
                                          LegLocationModel(
                                            pointAddress: address,
                                            pointAreaName: area,
                                            pointCity: city,
                                            pointCountry: country,
                                            pointPincode: pincode,
                                            pointState: state,
                                          ),
                                        );
                                        FocusScope.of(context).unfocus();
                                      },
                                    ),
                                  ),
                                  WBox(Get.width * 0.015),
                                  if (c.endPointController.length > 1)
                                    InkWell(
                                      onTap: () {
                                        c.removeEndPointRow(index);
                                      },
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      child: Icon(Icons.close, color: AppColors.redColor, size: 25),
                                    ),
                                  if (c.endPointController.length > 1) WBox(Get.width * 0.015),
                                  if (index == c.endPointController.length - 1)
                                    InkWell(
                                      onTap: () {
                                        c.addEndPointRow();
                                      },
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      child: Icon(Icons.add, color: AppColors.primaryColor, size: 30),
                                    )
                                ],
                              );
                            },
                            separatorBuilder: (context, index) => HBox(Get.height * 0.01),
                          ),
                          if (field.hasError)
                            Padding(
                              padding: EdgeInsets.only(top: Get.height * 0.008),
                              child: Text(
                                field.errorText ?? '',
                                style: AppTextStyle.regularTextStyle.copyWith(
                                  color: AppColors.redColor,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              if(c.selectPreferenceType.value == 'custom' &&
                  (c.getFieldData("VR_STARTPOINT") != null && (c.getFieldData("VR_STARTPOINT")?.isInUse ?? false)) &&
                  (c.getFieldData("VR_ENDPOINT") != null && (c.getFieldData("VR_ENDPOINT")?.isInUse ?? false)))Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildDynamicField("VR_STARTPOINT",
                    customInput: FormField<int>(
                      key: c.googleStartLegFormFieldKey,
                      initialValue: 0,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (_) => c.validateGoogleLegGroup(
                        'VR_STARTPOINT',
                        c.startPointController,
                        c.startPointList,
                      ),
                      builder: (field) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.separated(
                            itemCount: c.startPointController.length,
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final startCfg = c.getFieldData("VR_STARTPOINT");
                              final selectedStart = index < c.selectedStartCustomAddress.length
                                  ? c.selectedStartCustomAddress[index]
                                  : null;
                              return Row(
                                children: [
                                  Expanded(
                                    child: DropdownTextField<LegLocationList>(
                                      value: c.matchingLegLocationInOptions(selectedStart),
                                      items: c.customLocationList,
                                      itemLabel: legLocationDropdownCaption,
                                      hintText: startCfg?.fieldCaption ?? '',
                                      enabled: startCfg?.isEnable ?? false,
                                      onChanged: (value) {
                                        c.applyStartCustomLegLocation(index, value);
                                      },
                                    ),
                                  ),
                                  WBox(Get.width * 0.015),
                                  if (c.startPointController.length > 1)
                                    InkWell(
                                      onTap: () {
                                        c.removeStartPointRow(index);
                                      },
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      child: Icon(Icons.close, color: AppColors.redColor, size: 25),
                                    ),
                                  if (c.startPointController.length > 1) WBox(Get.width * 0.015),
                                  if (index == c.startPointController.length - 1)
                                    InkWell(
                                      onTap: () {
                                        c.addStartPointRow();
                                      },
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      child: Icon(Icons.add, color: AppColors.primaryColor, size: 30),
                                    )
                                ],
                              );
                            },
                            separatorBuilder: (context, index) => HBox(Get.height * 0.01),
                          ),
                          if (field.hasError)
                            Padding(
                              padding: EdgeInsets.only(top: Get.height * 0.008),
                              child: Text(
                                field.errorText ?? '',
                                style: AppTextStyle.regularTextStyle.copyWith(
                                  color: AppColors.redColor,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  buildDynamicField("VR_ENDPOINT",
                    customInput: FormField<int>(
                      key: c.googleEndLegFormFieldKey,
                      initialValue: 0,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (_) => c.validateGoogleLegGroup(
                        'VR_ENDPOINT',
                        c.endPointController,
                        c.endPointList,
                      ),
                      builder: (field) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.separated(
                            itemCount: c.endPointController.length,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final endCfg = c.getFieldData("VR_ENDPOINT");
                              final selectedEnd = index < c.selectedEndCustomAddress.length
                                  ? c.selectedEndCustomAddress[index]
                                  : null;
                              return Row(
                                children: [
                                  Expanded(
                                    child: DropdownTextField<LegLocationList>(
                                      value: c.matchingLegLocationInOptions(selectedEnd),
                                      items: c.customLocationList,
                                      itemLabel: legLocationDropdownCaption,
                                      hintText: endCfg?.fieldCaption ?? '',
                                      enabled: endCfg?.isEnable ?? false,
                                      onChanged: (value) {
                                        c.applyEndCustomLegLocation(index, value);
                                      },
                                    ),
                                  ),
                                  WBox(Get.width * 0.015),
                                  if (c.endPointController.length > 1)
                                    InkWell(
                                      onTap: () {
                                        c.removeEndPointRow(index);
                                      },
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      child: Icon(Icons.close, color: AppColors.redColor, size: 25),
                                    ),
                                  if (c.endPointController.length > 1) WBox(Get.width * 0.015),
                                  if (index == c.endPointController.length - 1)
                                    InkWell(
                                      onTap: () {
                                        c.addEndPointRow();
                                      },
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      child: Icon(Icons.add, color: AppColors.primaryColor, size: 30),
                                    )
                                ],
                              );
                            },
                            separatorBuilder: (context, index) => HBox(Get.height * 0.01),
                          ),
                          if (field.hasError)
                            Padding(
                              padding: EdgeInsets.only(top: Get.height * 0.008),
                              child: Text(
                                field.errorText ?? '',
                                style: AppTextStyle.regularTextStyle.copyWith(
                                  color: AppColors.redColor,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              if ((c.vehicleRequestData?.isLegEnable ?? false) &&
                  (c.getFieldData("VR_FROMCITY") != null && (c.getFieldData("VR_FROMCITY")?.isInUse ?? false)) &&
                  (c.getFieldData("VR_TOCITY") != null && (c.getFieldData("VR_TOCITY")?.isInUse ?? false)))FieldScrollWrapper(
                    child: ListView.separated(
                      itemCount: c.legFromCitySelected.length,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final fromCfg = c.getFieldData("VR_FROMCITY");
                        final toCfg = c.getFieldData("VR_TOCITY");
                        final legCount = c.legFromCitySelected.length;
                        final isLast = index == legCount - 1;
                        final fromVal = index < c.legFromCitySelected.length ? c.legFromCitySelected[index] : null;
                        final toVal = index < c.legToCitySelected.length ? c.legToCitySelected[index] : null;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HBox(Get.height * 0.015),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Row ${index + 1} : ${c.getFieldData("VR_FROMCITY")?.fieldCaption ?? ''} - ${c.getFieldData("VR_TOCITY")?.fieldCaption ?? ''}",
                                    style: AppTextStyle.regularTextStyle.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textBlackColor,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    if (legCount > 1)WBox(Get.width * 0.015),
                                    if (legCount > 1)
                                      InkWell(
                                        onTap: () {
                                          c.removeLegCityRow(index);
                                        },
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        child: Icon(Icons.close, color: AppColors.redColor, size: 25),
                                      ),
                                    if (isLast) WBox(Get.width * 0.015),
                                    if (isLast)
                                      InkWell(
                                        onTap: () {
                                          c.addLegCityRow();
                                        },
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        child: Icon(Icons.add, color: AppColors.primaryColor, size: 30),
                                      ),
                                  ],
                                )
                              ],
                            ),
                            HBox(Get.height * 0.01),
                            DropdownTextField<GetAutoCompleteCityModel>(
                              value: c.matchingCityInOptions(fromVal),
                              items: c.cityList,
                              itemLabel: legCityDropdownCaption,
                              hintText: fromCfg?.fieldCaption ?? '',
                              enabled: fromCfg?.isEnable ?? false,
                              onChanged: (value) {
                                c.setLegFromCity(index, value);
                              },
                              validator: (p0) {
                                if(p0 == null){
                                  return "Required";
                                }
                                return null;
                              },
                            ),
                            HBox(Get.height * 0.01),
                            DropdownTextField<GetAutoCompleteCityModel>(
                              value: c.matchingCityInOptions(toVal),
                              items: c.cityList,
                              itemLabel: legCityDropdownCaption,
                              hintText: toCfg?.fieldCaption ?? '',
                              enabled: toCfg?.isEnable ?? false,
                              onChanged: (value) {
                                c.setLegToCity(index, value);
                              },
                              validator: (p0) {
                                if(p0 == null){
                                  return "Required";
                                }
                                return null;
                              },
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) => HBox(Get.height * 0.01),
                    ),
                  ),

              buildDynamicField("VR_APPROXDISTANCE",
                controller: c.approxDistanceController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
              ),

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

              if (!(c.vehicleRequestData?.isBiddingEnable ?? false))NoData(),

              if ((c.vehicleRequestData?.isBiddingEnable ?? false) && (c.getFieldData("VR_ISBIDDING") != null || (c.getFieldData("VR_ISBIDDING")?.isInUse ?? false)))HBox(Get.height * 0.01),
              if ((c.vehicleRequestData?.isBiddingEnable ?? false) && (c.getFieldData("VR_ISBIDDING") != null || (c.getFieldData("VR_ISBIDDING")?.isInUse ?? false)))Row(
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
              if ((c.vehicleRequestData?.isBiddingEnable ?? false) && (c.getFieldData("VR_ISBIDDING") != null || (c.getFieldData("VR_ISBIDDING")?.isInUse ?? false)))HBox(Get.height * 0.02),

              if ((c.getFieldData("VR_ISBIDDING") != null && (c.getFieldData("VR_ISBIDDING")?.isInUse ?? false)) && c.isBiddingRequired.value)Obx(() => TextFField(
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
              if ((c.getFieldData("VR_ISBIDDING") != null && (c.getFieldData("VR_ISBIDDING")?.isInUse ?? false)) && c.isBiddingRequired.value)HBox(Get.height * 0.015),
              if ((c.getFieldData("VR_ISBIDDING") != null && (c.getFieldData("VR_ISBIDDING")?.isInUse ?? false)) && c.isBiddingRequired.value)Obx(() => TextFField(
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
              if ((c.getFieldData("VR_ISBIDDING") != null && (c.getFieldData("VR_ISBIDDING")?.isInUse ?? false)) && c.isBiddingRequired.value)HBox(Get.height * 0.01),

              if ((c.getFieldData("VR_ISBIDDING") != null && (c.getFieldData("VR_ISBIDDING")?.isInUse ?? false)) && c.isBiddingRequired.value)Obx(() => buildDynamicField("VR_ISCAPRATE",
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

              if ((c.getFieldData("VR_ISBIDDING") != null && (c.getFieldData("VR_ISBIDDING")?.isInUse ?? false)) && c.isBiddingRequired.value)buildDynamicField("VR_BIDDINGNOTE", controller: c.biddingNoteController),
              if ((c.getFieldData("VR_ISBIDDING") != null && (c.getFieldData("VR_ISBIDDING")?.isInUse ?? false)) && c.isBiddingRequired.value)buildDynamicField("VR_ACCEPTBIDFROM", customInput: Obx(() => Padding(
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

              if ((c.getFieldData("VR_ISBIDDING") != null && (c.getFieldData("VR_ISBIDDING")?.isInUse ?? false)) && c.isBiddingRequired.value &&  c.acceptBidFrom.value == 'AOP')buildDynamicField("VR_BIDVENDOR",
                customInput: DropdownButtonFormField<VendorTypeList>(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (c.getFieldData("VR_BIDVENDOR")?.isRequired ?? true) {
                      if (value == null) {
                        return 'Required';
                      }
                    }
                    return null;
                  },
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(20),
                  menuMaxHeight: Get.height * 0.5,
                  value: c.selectedVendor == null ? null : c.selectedVendor,
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.textBlackColor,
                  ),
                  style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.hintTextColor, fontSize: 14),
                  hint: Text(
                    c.getFieldData("VR_BIDVENDOR")?.fieldCaption ?? '',
                    style: AppTextStyle.regularTextStyle.copyWith(
                      color: c.vendorList.isEmpty ? AppColors.borderColor : AppColors.hintTextColor,
                      fontSize: 14,
                    ),
                  ),
                  decoration: InputDecoration(
                    counterText: "",
                    filled: true,
                    fillColor: AppColors.whiteColor,
                    contentPadding: EdgeInsets.symmetric(vertical: Get.height * 0.018, horizontal: Get.width * 0.04),
                    hintText: c.getFieldData("VR_BIDVENDOR")?.fieldCaption ?? '',
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
                    c.selectedVendor = value;
                    c.update();
                  },
                  items: c.vendorList.map((option) {
                    return DropdownMenuItem<VendorTypeList>(
                      value: option,
                      child: Text(
                        maxLines: 1,
                        "${option.vendorCode ?? ''} : ${option.codeDesc ?? ''}",
                        style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor, fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    );
                  }).toList(),
                ),
              ),

              if ((c.getFieldData("VR_ISBIDDING") != null && (c.getFieldData("VR_ISBIDDING")?.isInUse ?? false)) && c.isBiddingRequired.value &&  c.acceptBidFrom.value == 'AOO')buildDynamicField("VR_BIDLANE",
                customInput: DropdownButtonFormField<GetGeneralMasterModel>(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (c.getFieldData("VR_BIDLANE")?.isRequired ?? true) {
                      if (value == null) {
                        return 'Required';
                      }
                    }
                    return null;
                  },
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(20),
                  menuMaxHeight: Get.height * 0.5,
                  value: c.selectedLane == null ? null : c.selectedLane,
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.textBlackColor,
                  ),
                  style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.hintTextColor, fontSize: 14),
                  hint: Text(
                    c.getFieldData("VR_BIDLANE")?.fieldCaption ?? '',
                    style: AppTextStyle.regularTextStyle.copyWith(
                      color: c.laneList.isEmpty ? AppColors.borderColor : AppColors.hintTextColor,
                      fontSize: 14,
                    ),
                  ),
                  decoration: InputDecoration(
                    counterText: "",
                    filled: true,
                    fillColor: AppColors.whiteColor,
                    contentPadding: EdgeInsets.symmetric(vertical: Get.height * 0.018, horizontal: Get.width * 0.04),
                    hintText: c.getFieldData("VR_BIDLANE")?.fieldCaption ?? '',
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
                    c.selectedLane = value;
                    c.update();
                  },
                  items: c.laneList.map((option) {
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
                      child: DropdownButtonFormField<RateTypeList>(
                        isExpanded: true,
                        borderRadius: BorderRadius.circular(30),
                        menuMaxHeight: Get.height * 0.5,
                        value: c.selectedRateType == null ? null : c.selectedRateType,
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
                        items: c.rateTypeList.map((m) {
                          return DropdownMenuItem<RateTypeList>(
                            value: m,
                            child: Text(m.codeDesc ?? '', maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor, fontSize: 14, fontWeight: FontWeight.w500),),
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
