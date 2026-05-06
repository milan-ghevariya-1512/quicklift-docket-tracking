import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../../Reusability/utils/app_colors.dart';
import '../../../../Reusability/utils/app_images.dart';
import '../../../../Reusability/utils/app_textstyle.dart';
import '../../../../Reusability/widgets/common_widget.dart';
import '../controllers/docket_details_controller.dart';

class DocketDetailsView extends GetView<DocketDetailsController> {
  DocketDetailsView({super.key});

  @override
  final controller = Get.put(DocketDetailsController());

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('Sr. No', Get.width*0.15,1),
      _getTitleItemWidget('Event\nEvent Date', Get.width*0.5,1),
      _getTitleItemWidget('Document No', Get.width*0.4,1),
    ];
  }

  Widget _getTitleItemWidget(String label, double width, int alignment) {
    return Container(
      width: width,
      height: Get.height*0.06,
      color: AppColors.secondaryColor,
      padding: EdgeInsets.symmetric(horizontal: Get.width*0.02),
      alignment: Alignment.center,
      child: Text(label, textAlign: TextAlign.center,style: AppTextStyle.regularTextStyle.copyWith(fontSize: 13,fontWeight: FontWeight.w600,color: AppColors.whiteColor)),
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          height: Get.height*0.07,
          child: Text('Status :',overflow: TextOverflow.ellipsis,maxLines: 3,textAlign: TextAlign.start,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor,fontWeight: FontWeight.bold,fontSize: 11),),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: Get.height*0.008),
          child: Container(
            width: Get.width*0.15,
            height: Get.height*0.06,
            padding: EdgeInsets.symmetric(horizontal: Get.width*0.02),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border(top: BorderSide(color: AppColors.textBlackColor.withOpacity(0.2)),bottom: BorderSide(color: AppColors.textBlackColor.withOpacity(0.2)))
            ),
            child: Text(controller.apiDocketEvents[index].sr_no ?? '',style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor,fontWeight: FontWeight.w600,fontSize: 11),),
          ),
        ),
      ],
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return IntrinsicHeight(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            height: Get.height*0.07,
            padding: EdgeInsets.symmetric(horizontal: Get.width*0.02),
            child: Text(controller.apiDocketEvents[index].status ?? '',overflow: TextOverflow.ellipsis,maxLines: 3,textAlign: TextAlign.start,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor,fontWeight: FontWeight.bold,fontSize: 11),),
          ),
          Row(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.symmetric(vertical: Get.height*0.008),
                  child: Container(
                    width: Get.width*0.5,
                    height: Get.height*0.06,
                    padding: EdgeInsets.symmetric(horizontal: Get.width*0.02),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        border: Border(top: BorderSide(color: AppColors.textBlackColor.withOpacity(0.2)),bottom: BorderSide(color: AppColors.textBlackColor.withOpacity(0.2)))
                    ),
                    child: Text("${controller.apiDocketEvents[index].event_name ?? ''}\n${(controller.apiDocketEvents[index].trans_dtm ?? '').isNotEmpty ? DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.parse(controller.apiDocketEvents[index].trans_dtm ?? '')) : ''}",maxLines: 2,textAlign: TextAlign.start,overflow: TextOverflow.ellipsis,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor,fontWeight: FontWeight.w500,fontSize: 11),),
                  ),
                ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: Get.height*0.008),
                child: Container(
                  width: Get.width*0.4,
                  height: Get.height*0.06,
                  padding: EdgeInsets.symmetric(horizontal: Get.width*0.02),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: AppColors.textBlackColor.withOpacity(0.2)),bottom: BorderSide(color: AppColors.textBlackColor.withOpacity(0.2)))
                  ),
                  child: Text(controller.apiDocketEvents[index].docno ?? '',textAlign: TextAlign.center,maxLines: 3,overflow: TextOverflow.ellipsis,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor,fontWeight: FontWeight.w500,fontSize: 11),),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var goodsList = [];
    var packageTypeList = [];
    var invoiceNoList = [];
    var invoiceDateList = [];
    var ewbNoList = [];
    var ewbDateList = [];
    for(int i=0;i<(controller.docketDetails.apiDocketInvoiceDetails ?? []).length;i++){
      goodsList.add((controller.docketDetails.apiDocketInvoiceDetails ?? [])[i].item_content ?? '');
    }
    for(int i=0;i<(controller.docketDetails.apiDocketInvoiceDetails ?? []).length;i++){
      packageTypeList.add((controller.docketDetails.apiDocketInvoiceDetails ?? [])[i].packaging_type ?? '');
    }
    for(int i=0;i<(controller.docketDetails.apiDocketInvoiceSummary ?? []).length;i++){
      invoiceNoList.add((controller.docketDetails.apiDocketInvoiceSummary ?? [])[i].invoice_no ?? '');
    }
    for(int i=0;i<(controller.docketDetails.apiDocketInvoiceSummary ?? []).length;i++){
      if(((controller.docketDetails.apiDocketInvoiceSummary ?? [])[i].invoice_date ?? '').isNotEmpty)
      invoiceDateList.add(DateFormat('dd/MM/yyyy').format(DateTime.parse((controller.docketDetails.apiDocketInvoiceSummary ?? [])[i].invoice_date ?? '')));
    }
    for(int i=0;i<(controller.docketDetails.apiDocketInvoiceSummary ?? []).length;i++){
      ewbNoList.add((controller.docketDetails.apiDocketInvoiceSummary ?? [])[i].ewb_number ?? '');
    }
    for(int i=0;i<(controller.docketDetails.apiDocketInvoiceSummary ?? []).length;i++){
      if(((controller.docketDetails.apiDocketInvoiceSummary ?? [])[i].ewb_date ?? '').isNotEmpty)
      ewbDateList.add(DateFormat('dd/MM/yyyy').format(DateTime.parse((controller.docketDetails.apiDocketInvoiceSummary ?? [])[i].ewb_date ?? '')));
    }
    log("(controller.docketDetails.apiDocketEvents ?? []).length ${controller.apiDocketEvents.length}");
    goodsList = goodsList.toSet().toList();
    packageTypeList = packageTypeList.toSet().toList();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        surfaceTintColor: AppColors.backgroundColor,
        title: Row(
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                height: Get.height * 0.046,
                width: Get.height * 0.046,
                decoration: BoxDecoration(
                  color: AppColors.surfaceColor,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.borderColor),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.textBlackColor.withOpacity(0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Image.asset(
                  AppImage.backIcon,
                  height: Get.height * 0.024,
                  width: Get.height * 0.024,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            WBox(Get.width * 0.03),
            Obx(() => Text(controller.isType.value == 0 ? "GR Number : ${controller.docketNo.value}" : controller.isType.value == 1 ? "GR Enquiry Details" : "Status",style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor,fontWeight: FontWeight.w600,fontSize: 16))),
          ],
        ),
        leading: Container(),
        leadingWidth: 0,
      ),
      body: Stack(
        children: [
          Image.asset(
            AppImage.background,
            fit: BoxFit.fill,
            height: Get.height,
            width: Get.width,
          ),
          Obx(() => SingleChildScrollView(
            child: Column(
              children: [

                if(controller.isType.value == 0)Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width*0.05,vertical: Get.height*0.012),
                  child: Column(
                    children: [

                      Container(
                        color: AppColors.whiteColor,
                        padding: EdgeInsets.symmetric(vertical: Get.height*0.01,horizontal: Get.width*0.02),
                        child: Row(
                          children: [
                            Expanded(flex: 2,child: Text("GR Type",textAlign: TextAlign.start,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.greyColor,fontSize: 13,fontWeight: FontWeight.w500),)),
                            WBox(Get.width*0.01),
                            Expanded(flex: 3,child: Text(controller.docketDetails.apiDocketBooking?.payment_type_name ?? '',textAlign: TextAlign.end,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor,fontSize: 13,fontWeight: FontWeight.w600),))
                          ],
                        ),
                      ),

                      Divider(color: AppColors.greyColor.withOpacity(0.2),height: 0),

                      Container(
                        color: AppColors.greyColor.withOpacity(0.03),
                        padding: EdgeInsets.symmetric(vertical: Get.height*0.01,horizontal: Get.width*0.02),
                        child: Row(
                          children: [
                            Expanded(flex: 2,child: Text("Origin",textAlign: TextAlign.start,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.greyColor,fontSize: 13,fontWeight: FontWeight.w500),)),
                            WBox(Get.width*0.01),
                            Expanded(flex: 3,child: Text(controller.docketDetails.apiDocket?.originLocationName ?? '',textAlign: TextAlign.end,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor,fontSize: 13,fontWeight: FontWeight.w600),))
                          ],
                        ),
                      ),

                      Divider(color: AppColors.greyColor.withOpacity(0.2),height: 0),

                      Container(
                        color: AppColors.whiteColor,
                        padding: EdgeInsets.symmetric(vertical: Get.height*0.01,horizontal: Get.width*0.02),
                        child: Row(
                          children: [
                            Expanded(flex: 2,child: Text("Consignor",textAlign: TextAlign.start,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.greyColor,fontSize: 13,fontWeight: FontWeight.w500),)),
                            WBox(Get.width*0.01),
                            Expanded(flex: 3,child: Text(controller.docketDetails.apiDocketConsignorDetails?.consignor_name ?? '',textAlign: TextAlign.end,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor,fontSize: 13,fontWeight: FontWeight.w600),))
                          ],
                        ),
                      ),

                      Divider(color: AppColors.greyColor.withOpacity(0.2),height: 0),

                      Container(
                        color: AppColors.greyColor.withOpacity(0.03),
                        padding: EdgeInsets.symmetric(vertical: Get.height*0.01,horizontal: Get.width*0.02),
                        child: Row(
                          children: [
                            Expanded(flex: 2,child: Text("Destination",textAlign: TextAlign.start,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.greyColor,fontSize: 13,fontWeight: FontWeight.w500),)),
                            WBox(Get.width*0.01),
                            Expanded(flex: 3,child: Text(controller.docketDetails.apiDocket?.destinationLocationName ?? '',textAlign: TextAlign.end,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor,fontSize: 13,fontWeight: FontWeight.w600),))
                          ],
                        ),
                      ),

                      Divider(color: AppColors.greyColor.withOpacity(0.2),height: 0),

                      Container(
                        color: AppColors.whiteColor,
                        padding: EdgeInsets.symmetric(vertical: Get.height*0.01,horizontal: Get.width*0.02),
                        child: Row(
                          children: [
                            Expanded(flex: 2,child: Text("Consignee",textAlign: TextAlign.start,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.greyColor,fontSize: 13,fontWeight: FontWeight.w500),)),
                            WBox(Get.width*0.01),
                            Expanded(flex: 3,child: Text(controller.docketDetails.apiDocketConsigneeDetails?.consignee_name ?? '',textAlign: TextAlign.end,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor,fontSize: 13,fontWeight: FontWeight.w600),))
                          ],
                        ),
                      ),

                      Divider(color: AppColors.greyColor.withOpacity(0.2),height: 0),

                      Container(
                        color: AppColors.greyColor.withOpacity(0.03),
                        padding: EdgeInsets.symmetric(vertical: Get.height*0.01,horizontal: Get.width*0.02),
                        child: Row(
                          children: [
                            Expanded(flex: 2,child: Text("Transport Mode",textAlign: TextAlign.start,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.greyColor,fontSize: 13,fontWeight: FontWeight.w500),)),
                            WBox(Get.width*0.01),
                            Expanded(flex: 3,child: Text(controller.docketDetails.apiDocketBooking?.transport_mode_name ?? '',textAlign: TextAlign.end,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor,fontSize: 13,fontWeight: FontWeight.w600),))
                          ],
                        ),
                      ),

                      Divider(color: AppColors.greyColor.withOpacity(0.2),height: 0),

                      Container(
                        color: AppColors.whiteColor,
                        padding: EdgeInsets.symmetric(vertical: Get.height*0.01,horizontal: Get.width*0.02),
                        child: Row(
                          children: [
                            Expanded(flex: 2,child: Text("Service Type",textAlign: TextAlign.start,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.greyColor,fontSize: 13,fontWeight: FontWeight.w500),)),
                            WBox(Get.width*0.01),
                            Expanded(flex: 3,child: Text(controller.docketDetails.apiDocketBooking?.service_mode_name ?? '',textAlign: TextAlign.end,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor,fontSize: 13,fontWeight: FontWeight.w600),))
                          ],
                        ),
                      ),

                      Divider(color: AppColors.greyColor.withOpacity(0.2),height: 0),

                      Container(
                        color: AppColors.greyColor.withOpacity(0.03),
                        padding: EdgeInsets.symmetric(vertical: Get.height*0.01,horizontal: Get.width*0.02),
                        child: Row(
                          children: [
                            Expanded(flex: 2,child: Text("Packages",textAlign: TextAlign.start,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.greyColor,fontSize: 13,fontWeight: FontWeight.w500),)),
                            WBox(Get.width*0.01),
                            Expanded(flex: 3,child: Text(controller.docketDetails.apiDocketBooking?.total_packages_no ??'',textAlign: TextAlign.end,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor,fontSize: 13,fontWeight: FontWeight.w600),))
                          ],
                        ),
                      ),

                      Divider(color: AppColors.greyColor.withOpacity(0.2),height: 0),

                      Container(
                        color: AppColors.whiteColor,
                        padding: EdgeInsets.symmetric(vertical: Get.height*0.01,horizontal: Get.width*0.02),
                        child: Row(
                          children: [
                            Expanded(flex: 2,child: Text("Actual Wt",textAlign: TextAlign.start,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.greyColor,fontSize: 13,fontWeight: FontWeight.w500),)),
                            WBox(Get.width*0.01),
                            Expanded(flex: 3,child: Text(controller.docketDetails.apiDocketBooking?.total_actual_weight ?? '',textAlign: TextAlign.end,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor,fontSize: 13,fontWeight: FontWeight.w600),))
                          ],
                        ),
                      ),

                      Divider(color: AppColors.greyColor.withOpacity(0.2),height: 0),

                      Container(
                        color: AppColors.greyColor.withOpacity(0.03),
                        padding: EdgeInsets.symmetric(vertical: Get.height*0.01,horizontal: Get.width*0.02),
                        child: Row(
                          children: [
                            Expanded(flex: 2,child: Text("Charge Wt",textAlign: TextAlign.start,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.greyColor,fontSize: 13,fontWeight: FontWeight.w500),)),
                            WBox(Get.width*0.01),
                            Expanded(flex: 3,child: Text(controller.docketDetails.apiDocketBooking?.billing_weight ?? '',textAlign: TextAlign.end,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor,fontSize: 13,fontWeight: FontWeight.w600),))
                          ],
                        ),
                      ),

                      Divider(color: AppColors.greyColor.withOpacity(0.2),height: 0),

                      Container(
                        color: AppColors.whiteColor,
                        padding: EdgeInsets.symmetric(vertical: Get.height*0.01,horizontal: Get.width*0.02),
                        child: Row(
                          children: [
                            Expanded(flex: 2,child: Text("Goods",textAlign: TextAlign.start,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.greyColor,fontSize: 13,fontWeight: FontWeight.w500),)),
                            WBox(Get.width*0.01),
                            Expanded(flex: 3,child: Text(goodsList.toString().split("[").last.split("]").first,textAlign: TextAlign.end,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor,fontSize: 13,fontWeight: FontWeight.w600),))
                          ],
                        ),
                      ),

                      Divider(color: AppColors.greyColor.withOpacity(0.2),height: 0),

                      Container(
                        color: AppColors.greyColor.withOpacity(0.03),
                        padding: EdgeInsets.symmetric(vertical: Get.height*0.01,horizontal: Get.width*0.02),
                        child: Row(
                          children: [
                            Expanded(flex: 2,child: Text("Packing",textAlign: TextAlign.start,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.greyColor,fontSize: 13,fontWeight: FontWeight.w500),)),
                            WBox(Get.width*0.01),
                            Expanded(flex: 3,child: Text(packageTypeList.toString().split("[").last.split("]").first,textAlign: TextAlign.end,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor,fontSize: 13,fontWeight: FontWeight.w600),))
                          ],
                        ),
                      ),

                      Divider(color: AppColors.greyColor.withOpacity(0.2),height: 0),

                      Container(
                        color: AppColors.whiteColor,
                        padding: EdgeInsets.symmetric(vertical: Get.height*0.01,horizontal: Get.width*0.02),
                        child: Row(
                          children: [
                            Expanded(flex: 2,child: Text("Private Mark",textAlign: TextAlign.start,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.greyColor,fontSize: 13,fontWeight: FontWeight.w500),)),
                            WBox(Get.width*0.01),
                            Expanded(flex: 3,child: Text(controller.docketDetails.apiDocketBookingExtraDetails?.private_mark ?? '',textAlign: TextAlign.end,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor,fontSize: 13,fontWeight: FontWeight.w600),))
                          ],
                        ),
                      ),

                      Divider(color: AppColors.greyColor.withOpacity(0.2),height: 0),

                      Container(
                        color: AppColors.greyColor.withOpacity(0.03),
                        padding: EdgeInsets.symmetric(vertical: Get.height*0.01,horizontal: Get.width*0.02),
                        child: Row(
                          children: [
                            Expanded(flex: 2,child: Text("Invoice No",textAlign: TextAlign.start,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.greyColor,fontSize: 13,fontWeight: FontWeight.w500),)),
                            WBox(Get.width*0.01),
                            Expanded(flex: 3,child: Text(invoiceNoList.toString().split("[").last.split("]").first,textAlign: TextAlign.end,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor,fontSize: 13,fontWeight: FontWeight.w600),))
                          ],
                        ),
                      ),

                      Divider(color: AppColors.greyColor.withOpacity(0.2),height: 0),

                      Container(
                        color: AppColors.whiteColor,
                        padding: EdgeInsets.symmetric(vertical: Get.height*0.01,horizontal: Get.width*0.02),
                        child: Row(
                          children: [
                            Expanded(flex: 2,child: Text("Invoice Date",textAlign: TextAlign.start,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.greyColor,fontSize: 13,fontWeight: FontWeight.w500),)),
                            WBox(Get.width*0.01),
                            Expanded(flex: 3,child: Text(invoiceDateList.toString().split("[").last.split("]").first,textAlign: TextAlign.end,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor,fontSize: 13,fontWeight: FontWeight.w600),))
                          ],
                        ),
                      ),

                      Divider(color: AppColors.greyColor.withOpacity(0.2),height: 0),

                      Container(
                        color: AppColors.greyColor.withOpacity(0.03),
                        padding: EdgeInsets.symmetric(vertical: Get.height*0.01,horizontal: Get.width*0.02),
                        child: Row(
                          children: [
                            Expanded(flex: 2,child: Text("Invoice Value",textAlign: TextAlign.start,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.greyColor,fontSize: 13,fontWeight: FontWeight.w500),)),
                            WBox(Get.width*0.01),
                            Expanded(flex: 3,child: Text(controller.docketDetails.apiDocketBooking?.total_invoice_value ?? '',textAlign: TextAlign.end,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor,fontSize: 13,fontWeight: FontWeight.w600),))
                          ],
                        ),
                      ),

                      Divider(color: AppColors.greyColor.withOpacity(0.2),height: 0),

                      Container(
                        color: AppColors.whiteColor,
                        padding: EdgeInsets.symmetric(vertical: Get.height*0.01,horizontal: Get.width*0.02),
                        child: Row(
                          children: [
                            Expanded(flex: 2,child: Text("EWB No",textAlign: TextAlign.start,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.greyColor,fontSize: 13,fontWeight: FontWeight.w500),)),
                            WBox(Get.width*0.01),
                            Expanded(flex: 3,child: Text(ewbNoList.toString().split("[").last.split("]").first,textAlign: TextAlign.end,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor,fontSize: 13,fontWeight: FontWeight.w600),))
                          ],
                        ),
                      ),

                      Divider(color: AppColors.greyColor.withOpacity(0.2),height: 0),

                      Container(
                        color: AppColors.greyColor.withOpacity(0.03),
                        padding: EdgeInsets.symmetric(vertical: Get.height*0.01,horizontal: Get.width*0.02),
                        child: Row(
                          children: [
                            Expanded(flex: 2,child: Text("EWB Date",textAlign: TextAlign.start,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.greyColor,fontSize: 13,fontWeight: FontWeight.w500),)),
                            WBox(Get.width*0.01),
                            Expanded(flex: 3,child: Text(ewbDateList.toString().split("[").last.split("]").first.toString().split("[").last.split("]").first,textAlign: TextAlign.end,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor,fontSize: 13,fontWeight: FontWeight.w600),))
                          ],
                        ),
                      ),

                      Divider(color: AppColors.greyColor.withOpacity(0.2),height: 0),

                      Container(
                        color: AppColors.whiteColor,
                        padding: EdgeInsets.symmetric(vertical: Get.height*0.01,horizontal: Get.width*0.02),
                        child: Row(
                          children: [
                            Expanded(flex: 2,child: Text("Pickup Type",textAlign: TextAlign.start,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.greyColor,fontSize: 13,fontWeight: FontWeight.w500),)),
                            WBox(Get.width*0.01),
                            Expanded(flex: 3,child: Text(controller.docketDetails.apiDocketBooking?.pickup_type_name ?? '',textAlign: TextAlign.end,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor,fontSize: 13,fontWeight: FontWeight.w600),))
                          ],
                        ),
                      ),

                      Divider(color: AppColors.greyColor.withOpacity(0.2),height: 0),

                      Container(
                        color: AppColors.greyColor.withOpacity(0.03),
                        padding: EdgeInsets.symmetric(vertical: Get.height*0.01,horizontal: Get.width*0.02),
                        child: Row(
                          children: [
                            Expanded(flex: 2,child: Text("Delivery Type",textAlign: TextAlign.start,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.greyColor,fontSize: 13,fontWeight: FontWeight.w500),)),
                            WBox(Get.width*0.01),
                            Expanded(flex: 3,child: Text(controller.docketDetails.apiDocketBooking?.delivery_process_name ?? '',textAlign: TextAlign.end,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor,fontSize: 13,fontWeight: FontWeight.w600),))
                          ],
                        ),
                      ),

                      Divider(color: AppColors.greyColor.withOpacity(0.2),height: 0),

                      Container(
                        color: AppColors.whiteColor,
                        padding: EdgeInsets.symmetric(vertical: Get.height*0.01,horizontal: Get.width*0.02),
                        child: Row(
                          children: [
                            Expanded(flex: 2,child: Text("Delivery Branch Contact No",textAlign: TextAlign.start,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.greyColor,fontSize: 13,fontWeight: FontWeight.w500),)),
                            WBox(Get.width*0.01),
                            Expanded(flex: 3,child: Text(controller.docketDetails.apiDocket?.destinationMobileNumber ?? '',textAlign: TextAlign.end,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor,fontSize: 13,fontWeight: FontWeight.w600),))
                          ],
                        ),
                      ),

                      Divider(color: AppColors.greyColor.withOpacity(0.2),height: 0),

                    ],
                  ),
                ),

                if(controller.isType.value == 1)Container(
                  height: Get.height * 0.77,
                  child: HorizontalDataTable(
                    leftHandSideColumnWidth: Get.width*0.15,
                    rightHandSideColumnWidth: Get.width*0.5 + Get.width*0.4,
                    isFixedHeader: true,
                    headerWidgets: _getTitleWidget(),
                    leftSideItemBuilder: _generateFirstColumnRow,
                    rightSideItemBuilder: _generateRightHandSideColumnRow,
                    itemCount: controller.apiDocketEvents.length,
                    leftHandSideColBackgroundColor: Colors.transparent,
                    rightHandSideColBackgroundColor: Colors.transparent,
                    scrollPhysics: BouncingScrollPhysics(),
                  ),
                ),

                if(controller.isType.value == 2)Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width*0.05,vertical: Get.height*0.012),
                  child: ListView.separated(
                      itemCount: 5,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: Get.height*0.015,horizontal: Get.width*0.04),
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: controller.subTitle[index].isEmpty ? Colors.transparent : AppColors.primaryColor),
                            boxShadow: [
                                BoxShadow(
                                  color: AppColors.textBlackColor.withOpacity(0.2),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(child: Image.asset(controller.imgList[index],height: Get.height*0.065,width: Get.height*0.065,fit: BoxFit.cover)),
                              WBox(Get.width*0.03),
                              Expanded(
                                child: controller.subTitle[index].isEmpty ?
                                Text(controller.title[index],style: AppTextStyle.regularTextStyle.copyWith(fontSize: 13,fontWeight: FontWeight.w600)) :
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(controller.title[index],style: AppTextStyle.regularTextStyle.copyWith(fontSize: 13,fontWeight: FontWeight.w600)),
                                    HBox(Get.height*0.005),
                                    Text(controller.subTitle[index],style: AppTextStyle.regularTextStyle.copyWith(fontSize: 11)),
                                  ],
                                ),
                              ),
                              if(index == 4 && controller.podUrl.value.isNotEmpty)WBox(Get.width*0.03),
                              if(index == 4 && controller.podUrl.value.isNotEmpty)GestureDetector(
                                onTap: () {
                                  launchUrlString(controller.podUrl.value,mode: LaunchMode.externalApplication);
                                },
                                child: Column(
                                  children: [
                                    Text("POD",style: AppTextStyle.regularTextStyle.copyWith(fontSize: 12,fontWeight: FontWeight.bold),),
                                    Icon(Icons.download)
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: Get.height*0.001),
                          child: Column(
                            children: [

                              Stack(
                                alignment: Alignment.center,
                                children: [

                                  Container(
                                    height: Get.height*0.025,
                                    width: Get.height*0.025,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                              color: AppColors.textBlackColor.withOpacity(0.5),
                                              blurRadius: 5
                                          )
                                        ],
                                        color: AppColors.whiteColor
                                    ),
                                  ),

                                  Container(
                                    height: Get.height*0.016,
                                    width: Get.height*0.016,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.primaryColor
                                    ),
                                  ),
                                ],
                              ),

                              Container(
                                  height: Get.height*0.02,
                                  child: VerticalDivider(color: AppColors.primaryColor)),

                              Stack(
                                alignment: Alignment.center,
                                children: [

                                  Container(
                                    height: Get.height*0.025,
                                    width: Get.height*0.025,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                              color: AppColors.textBlackColor.withOpacity(0.5),
                                              blurRadius: 5
                                          )
                                        ],
                                        color: AppColors.whiteColor
                                    ),
                                  ),

                                  Container(
                                    height: Get.height*0.016,
                                    width: Get.height*0.016,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.primaryColor
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        );
                      },
                  ),
                ),

                HBox(Get.height*0.02),

              ],
            ),
          )),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(top: Get.height*0.015, bottom: MediaQuery.of(context).padding.bottom + (Platform.isIOS ? 0 : Get.height*0.015)),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
              color: AppColors.textBlackColor.withOpacity(0.4),
              blurStyle: BlurStyle.outer,
              blurRadius: 6,
              spreadRadius: 1
            )
          ],
          borderRadius: BorderRadius.only(topRight: Radius.circular(22),topLeft: Radius.circular(22))
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() => Row(
              mainAxisSize: MainAxisSize.min,
              children: [

                WBox(Get.width*0.02),

                Expanded(
                  child: CommonButton(
                    onPressed: () {
                      controller.isType.value = 0;
                      controller.update();
                    },
                    textVal: "GR Details",
                    bgColor: controller.isType.value == 0 ? AppColors.primaryColor : Colors.transparent,
                    style: AppTextStyle.regularTextStyle.copyWith(fontSize: 12,color: controller.isType.value == 0 ? AppColors.whiteColor : AppColors.textBlackColor,fontWeight: FontWeight.w600),
                  ),
                ),

                WBox(Get.width*0.02),

                Expanded(
                  child: CommonButton(
                    onPressed: () {
                      controller.isType.value = 1;
                      controller.update();
                    },
                    textVal: "Movement",
                    bgColor: controller.isType.value == 1 ? AppColors.primaryColor : Colors.transparent,
                    style: AppTextStyle.regularTextStyle.copyWith(fontSize: 12,color: controller.isType.value == 1 ? AppColors.whiteColor : AppColors.textBlackColor,fontWeight: FontWeight.w600),
                  ),
                ),

                WBox(Get.width*0.02),

                Expanded(
                  child: CommonButton(
                    onPressed: () {
                      controller.isType.value = 2;
                      controller.update();
                    },
                    textVal: "Status",
                    bgColor: controller.isType.value == 2 ? AppColors.primaryColor : Colors.transparent,
                    style: AppTextStyle.regularTextStyle.copyWith(fontSize: 12,color: controller.isType.value == 2 ? AppColors.whiteColor : AppColors.textBlackColor,fontWeight: FontWeight.w600),
                  ),
                ),

                WBox(Get.width*0.02),

              ],
            ))
          ],
        ),
      ),
    );
  }
}