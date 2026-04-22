import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Reusability/utils/app_colors.dart';
import '../../../../Reusability/utils/app_images.dart';
import '../../../../Reusability/utils/app_textstyle.dart';
import '../../../../Reusability/widgets/common_widget.dart';
import '../controllers/internet_check_controller.dart';

class InternetCheckView extends GetView<InternetCheckController> {
  InternetCheckView({super.key});

  final c = Get.put(InternetCheckController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.backgroundColor,
        body: Stack(
          children: [
            Image.asset(
              AppImage.background,
              fit: BoxFit.fill,
              height: Get.height,
              width: Get.width,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HBox(MediaQuery.of(context).padding.top + Get.height*0.015),
                  AppPageHeader(
                    title: "Internet Connection",
                  ),
                  HBox(Get.height * 0.02),
                  Expanded(
                    child: Obx(() => c.isLoading.value
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                ),
                                HBox(Get.height * 0.02),
                                Text(
                                  "Checking connection...",
                                  style: AppTextStyle.regularTextStyle.copyWith(
                                    fontSize: 14,
                                    color: AppColors.hintTextColor,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                connectionStatusCard(),
                                if (!c.isConnected.value) ...[
                                  HBox(Get.height * 0.015),
                                  noConnectionMessage(),
                                ],
                                HBox(Get.height * 0.015),
                                connectionInfoCard(),
                                HBox(Get.height * 0.03),
                                continueButton(),
                                HBox(MediaQuery.of(context).padding.bottom + Get.height * 0.02),
                              ],
                            ),
                          )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget connectionStatusCard() {
    return Obx(() => Container(
          width: double.infinity,
          padding: EdgeInsets.all(Get.width * 0.06),
          decoration: BoxDecoration(
            color: AppColors.surfaceColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: c.isConnected.value
                  ? AppColors.greenColor.withOpacity(0.3)
                  : AppColors.redColor.withOpacity(0.3),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.textBlackColor.withOpacity(0.06),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                height: Get.height * 0.12,
                width: Get.height * 0.12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: c.isConnected.value
                      ? AppColors.greenColor.withOpacity(0.1)
                      : AppColors.redColor.withOpacity(0.1),
                  border: Border.all(
                    color: c.isConnected.value
                        ? AppColors.greenColor
                        : AppColors.redColor,
                    width: 2.5,
                  ),
                ),
                child: Icon(
                  c.isConnected.value
                      ? Icons.wifi_rounded
                      : Icons.wifi_off_rounded,
                  size: Get.height * 0.06,
                  color: c.isConnected.value
                      ? AppColors.greenColor
                      : AppColors.redColor,
                ),
              ),
              HBox(Get.height * 0.025),
              Text(
                c.isConnected.value ? "Connected" : "Not Connected",
                style: AppTextStyle.regularTextStyle.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: c.isConnected.value
                      ? AppColors.greenColor
                      : AppColors.redColor,
                ),
              ),
              HBox(Get.height * 0.01),
              Text(
                c.connectionType.value,
                style: AppTextStyle.regularTextStyle.copyWith(
                  fontSize: 14,
                  color: AppColors.hintTextColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ));
  }

  Widget connectionInfoCard() {
    return Obx(() => Container(
          width: double.infinity,
          padding: EdgeInsets.all(Get.width * 0.048),
          decoration: BoxDecoration(
            color: AppColors.surfaceColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.borderColor, width: 1),
            boxShadow: [
              BoxShadow(
                color: AppColors.textBlackColor.withOpacity(0.04),
                blurRadius: 12,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: 20,
                    color: AppColors.primaryColor,
                  ),
                  WBox(Get.width * 0.02),
                  Text(
                    "Connection Details",
                    style: AppTextStyle.regularTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textBlackColor,
                    ),
                  ),
                ],
              ),
              HBox(Get.height * 0.02),
              Divider(height: 1, thickness: 1, color: AppColors.borderColor),
              HBox(Get.height * 0.02),
              buildInfoRow(
                "Status",
                c.isConnected.value ? "Active" : "Inactive",
                c.isConnected.value ? AppColors.greenColor : AppColors.redColor,
              ),
              HBox(Get.height * 0.015),
              buildInfoRow(
                "Type",
                c.connectionType.value,
                AppColors.textSecondary,
              ),
            ],
          ),
        ));
  }

  Widget buildInfoRow(String label, String value, Color valueColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyle.regularTextStyle.copyWith(
            fontSize: 14,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: AppTextStyle.regularTextStyle.copyWith(
            fontSize: 14,
            color: valueColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget noConnectionMessage() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04, vertical: Get.height * 0.01),
      decoration: BoxDecoration(
        color: AppColors.redColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.redColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline_rounded, color: AppColors.redColor, size: 22),
          WBox(Get.width * 0.03),
          Expanded(
            child: Text(
              "No internet connection. Tap Continue below to check again. When connected, tap API to continue.",
              style: AppTextStyle.regularTextStyle.copyWith(
                fontSize: 13,
                color: AppColors.textBlackColor,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget continueButton() {
    return Obx(() => c.isConnected.value ? CommonButton(
          textVal: "CONTINUE",
          onPressed: () => c.onContinueTap(),
        ) : SizedBox.shrink());
  }
}
