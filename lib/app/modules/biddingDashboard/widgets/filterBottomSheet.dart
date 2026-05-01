import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quicklift_docket_tracking/app/modules/biddingDashboard/controllers/bidding_dashboard_controller.dart';
import '../../../../Reusability/utils/app_colors.dart';
import '../../../../Reusability/utils/app_textstyle.dart';
import '../../../../Reusability/widgets/common_date_picker.dart';
import '../../../../Reusability/widgets/common_widget.dart';

class FilterBottomSheet extends StatelessWidget {
  BiddingDashboardController biddingDashboardController;
  bool isDashboard;
  FilterBottomSheet({super.key, required this.biddingDashboardController, this.isDashboard = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        width: Get.width,
        height: Get.height * 0.55,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          color: AppColors.surfaceColor,
          boxShadow: [
            BoxShadow(
              color: AppColors.textBlackColor.withValues(alpha: 0.08),
              blurRadius: 24,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: Get.height * 0.022, horizontal: Get.width * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              HBox(Get.height * 0.008),
              Row(
                children: [
                  Expanded(child: Text("Filter", style: AppTextStyle.regularTextStyle.copyWith(fontWeight: FontWeight.w700, fontSize: 19, color: AppColors.textBlackColor))),
                  WBox(Get.width * 0.02),
                  InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        Get.back();
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Icon(Icons.close)
                  )
                ],
              ),
              HBox(Get.height * 0.018),
              Divider(height: 1, thickness: 1, color: AppColors.borderColor),
              HBox(Get.height * 0.02),
              Expanded(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.dialog(
                          CommonRangeDatePicker(
                            initialStartDate: biddingDashboardController.startDate,
                            initialEndDate: biddingDashboardController.endDate,
                            onSelectionChanged: (start, end) {
                              if (start != null) biddingDashboardController.startDate = start;
                              if (end != null) {
                                biddingDashboardController.endDate = end;
                              }
                              biddingDashboardController.update();
                            },
                          ),
                        );
                      },
                      child: Container(
                        width: Get.width,
                        padding: EdgeInsets.symmetric(vertical: Get.height * 0.018, horizontal: Get.width * 0.04),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: AppColors.borderColor),
                        ),
                        child: GetBuilder<BiddingDashboardController>(
                            builder: (context) {
                              return Text(
                                "${DateFormat('dd-MM-yyyy').format(biddingDashboardController.startDate)}  to  ${DateFormat('dd-MM-yyyy').format(biddingDashboardController.endDate)}",
                                style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor, fontSize: 14, fontWeight: FontWeight.w500),
                              );
                            }
                        ),
                      ),
                    ),
                    if(!isDashboard)HBox(Get.height * 0.015),
                    if(!isDashboard)FieldScrollWrapper(
                      child: TextFField(
                        controller: biddingDashboardController.vrController,
                        hintText: 'V. Request No',
                      ),
                    )
                  ],
                ),
              ),
              HBox(Get.height * 0.028),
              Row(
                children: [
                  Expanded(child: CommonButton(textVal: 'Reset', bgColor: AppColors.primaryColor.withOpacity(0.2),style: AppTextStyle.regularTextStyle.copyWith(fontSize: 15, fontWeight: FontWeight.w700, letterSpacing: 0.5, color: AppColors.primaryColor),
                      onPressed: () {
                        Get.back();
                        biddingDashboardController.vrController.clear();
                        biddingDashboardController.startDate = DateTime.now().subtract(Duration(days: 60));
                        biddingDashboardController.endDate = DateTime.now();
                        biddingDashboardController.getBiddingList();
                      })),
                  WBox(Get.width * 0.025),
                  Expanded(child: CommonButton(textVal: 'Apply', onPressed: () {
                    Get.back();
                    biddingDashboardController.getBiddingList();
                  })),
                ],
              ),
              HBox(MediaQuery.of(context).padding.bottom + Get.height * 0.015),
            ],
          ),
        ),
      ),
    );
  }
}
