import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quicklift_docket_tracking/Reusability/utils/util.dart';

import '../../../../Reusability/utils/app_colors.dart';
import '../../../../Reusability/utils/app_images.dart';
import '../../../../Reusability/utils/app_textstyle.dart';
import '../../../../Reusability/widgets/common_widget.dart';
import '../../../data/model/getBiddingListModel.dart';
import '../../biddingDashboard/widgets/filterBottomSheet.dart';
import '../controllers/biding_list_controller.dart';

class BidingListView extends GetView<BidingListController> {
  BidingListView({super.key});

  final c = Get.put(BidingListController());

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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HBox(MediaQuery.of(context).padding.top + Get.height * 0.015),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                child: AppPageHeader(
                  title: "Bidding List",
                  onBack: () => Get.back(),
                  leading: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => FilterBottomSheet(biddingDashboardController: c.biddingDashboardController),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(Get.width * 0.025),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceColor,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.borderColor),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.textBlackColor.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        AppImage.filterIcon,
                        height: Get.height * 0.025,
                        width: Get.height * 0.025,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              HBox(Get.height * 0.008),
              GetBuilder<BidingListController>(builder: (cm) {
                return Expanded(
                  child: Obx(() => c.isRequestLoaded.value
                      ? Utils.loader()
                      : RefreshIndicator(
                    onRefresh: () => c.getBiddingList(isPullRefresh: true),
                    child: c.vehicleRequestList.isEmpty ? LayoutBuilder(
                      builder: (context, constraints) {
                        return SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(minHeight: constraints.maxHeight),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                              child: const NoData(
                                title: "No Vehicle Request",
                              ),
                            ),
                          ),
                        );
                      },
                    ) : SingleChildScrollView(
                      controller: c.scrollController,
                      child: Column(
                        children: [
                          ListView.separated(
                            itemCount: c.vehicleRequestList.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.05, top: Get.height * 0.008),
                            itemBuilder: (context, index) {
                              return buildVehicleRequestCard(c.vehicleRequestList[index], index);
                            },
                            separatorBuilder: (context, index) => HBox(Get.height * 0.005),
                          ),
                          Obx(() => !c.isRequestLoaded.value && c.isLoadMore.value
                              ? Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: Get.height * 0.01),
                                child: Utils.loader()
                              ))
                              : Container()),
                          HBox(MediaQuery.of(context).padding.bottom + Get.height * 0.015),
                        ],
                      ),
                    ),
                  )),
                );
              }),
            ],
          )
        ],
      ),
    );
  }

  Widget buildVehicleRequestCard(VehicleRequestsList data, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: Get.height * 0.015),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borderColor.withOpacity(0.8), width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.textBlackColor.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: AppColors.textBlackColor.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: EdgeInsets.all(Get.width * 0.035),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.022, vertical: Get.height * 0.004),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.primaryColor.withOpacity(0.2)),
              ),
              child: Text(
                'SR NO: ${index + 1}',
                style: AppTextStyle.regularTextStyle.copyWith(
                  color: AppColors.primaryColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
              ),
            ),
            HBox(Get.height * 0.015),
            const CommonDivider(),
            HBox(Get.height * 0.015),
            biddingDetailRow('VR Number', biddingStr(data.vrNumber), isBold: true),
            biddingDetailRow('Manual No', biddingStr(data.manualNo), isBold: true),
            CommonDivider(),
            HBox(Get.height * 0.01),
            biddingDetailRow('Request Date', biddingDateStr(data.requestDate)),
            biddingDetailRow('Exp Loading Date', biddingDateStr(data.expLoadingDate)),
            biddingDetailRow('Exp Delivery Time', biddingDateStr(data.expDeliveryTime)),
            CommonDivider(),
            HBox(Get.height * 0.01),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02, vertical: Get.height * 0.01),
              decoration: BoxDecoration(
                color: AppColors.blueColor.withOpacity(0.06),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.blueColor.withOpacity(0.15)),
              ),
              child: Row(
                children: [
                  Icon(Icons.location_on_outlined, size: 18, color: AppColors.blueColor),
                  WBox(Get.width * 0.02),
                  Expanded(
                    child: Text(
                      '${biddingStr(data.startPoint)}  →  ${biddingStr(data.endPoint)}',
                      style: AppTextStyle.regularTextStyle.copyWith(
                        color: AppColors.textBlackColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            HBox(Get.height * 0.01),
            biddingDetailRow('From Location', biddingStr(data.fromLocation)),
            biddingDetailRow('To Location', biddingStr(data.toLocation)),
            CommonDivider(),
            HBox(Get.height * 0.01),
            biddingDetailRow('THC No', biddingStr(data.thcNo)),
            biddingDetailRow('Docket Nos', biddingStr(data.docketNos)),
            CommonDivider(),
            HBox(Get.height * 0.01),
            biddingDetailRow('Material Type', biddingStr(data.materialType)),
            biddingDetailRow('Packaging Type', biddingStr(data.packagingType)),
          ],
        ),
      ),
    );
  }

  Widget biddingDetailRow(String label, String value, {bool isBold = false, Color? color}) {
    return Padding(
      padding: EdgeInsets.only(bottom: Get.height * 0.01),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: AppTextStyle.regularTextStyle.copyWith(
                color: AppColors.hintTextColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: AppTextStyle.regularTextStyle.copyWith(
                color: color ?? AppColors.textBlackColor,
                fontSize: 13,
                fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String biddingStr(String? v) {
    final s = v?.trim() ?? '';
    if (s.isEmpty || s == 'null') return '---';
    return s;
  }

  String biddingDateStr(String? v) {
    final s = v?.trim() ?? '';
    if (s.isEmpty || s == 'null') return '---';
    try {
      return DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.parse(s));
    } catch (_) {
      return s;
    }
  }
}
