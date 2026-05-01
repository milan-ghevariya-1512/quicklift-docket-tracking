import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../../Reusability/utils/app_colors.dart';
import '../../../../Reusability/utils/app_images.dart';
import '../../../../Reusability/utils/app_textstyle.dart';
import '../../../../Reusability/widgets/common_widget.dart';
import '../../../routes/app_pages.dart';
import '../../vehicleRequest/widgets/exit_app_popup.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  DashboardView({super.key});

  @override
  final controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool shouldClose = await Get.defaultDialog(
          content: ExitAppPopup(),
          titlePadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          backgroundColor: AppColors.whiteColor,
          titleStyle: const TextStyle(fontSize: 0),
          title: '',
        );
        return shouldClose;
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.surfaceColor,
          elevation: 0,
          scrolledUnderElevation: 1,
          shadowColor: AppColors.textBlackColor.withOpacity(0.06),
          surfaceTintColor: Colors.transparent,
          toolbarHeight: Get.height * 0.065,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          title: Row(
            children: [
              WBox(Get.width * 0.02),
              Text(
                'QuickLift',
                style: AppTextStyle.regularTextStyle.copyWith(
                  color: AppColors.textBlackColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  letterSpacing: -0.4,
                ),
              ),
              const Spacer(),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  AppImage.quickLiftLogoImage,
                  height: Get.height * 0.044,
                  fit: BoxFit.contain,
                ),
              ),
              WBox(Get.width * 0.015),
            ],
          ),
        ),
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
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    Get.width * 0.05,
                    Get.height * 0.018,
                    Get.width * 0.05,
                    Get.height * 0.01,
                  ),
                  child: Material(
                    color: AppColors.surfaceColor,
                    borderRadius: BorderRadius.circular(12),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () {
                        launchUrlString(
                          'https://quickliftdelivery.com',
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.035,
                          vertical: Get.height * 0.014,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.open_in_new_rounded,
                              size: 18,
                              color: AppColors.primaryColor,
                            ),
                            WBox(Get.width * 0.025),
                            Expanded(
                              child: Text(
                                'Visit quickliftdelivery.com',
                                style: AppTextStyle.regularTextStyle.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: AppColors.primaryColor,
                                  height: 1.25,
                                ),
                              ),
                            ),
                            Image.asset(
                              AppImage.visitIcon,
                              height: Get.height * 0.028,
                              width: Get.height * 0.028,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.surfaceColor,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.borderColor),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.textBlackColor.withOpacity(0.04),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              AppImage.quickLift,
                              fit: BoxFit.contain,
                              height: Get.height * 0.22,
                            ),
                          ),
                        ),
                        HBox(Get.height * 0.01),
                        Container(
                          padding: EdgeInsets.all(Get.width * 0.035),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceColor,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.borderColor.withOpacity(0.6)),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.textBlackColor.withOpacity(0.04),
                                blurRadius: 24,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Track shipment',
                                style: AppTextStyle.regularTextStyle.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: AppColors.textBlackColor,
                                  letterSpacing: -0.35,
                                ),
                              ),
                              HBox(Get.height * 0.006),
                              Text(
                                'Enter your docket code to see delivery status.',
                                style: AppTextStyle.regularTextStyle.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  color: AppColors.textSecondary,
                                  height: 1.4,
                                ),
                              ),
                              HBox(Get.height * 0.022),
                              Text(
                                'Docket code',
                                style: AppTextStyle.regularTextStyle.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: AppColors.textBlackColor,
                                  letterSpacing: 0.15,
                                ),
                              ),
                              HBox(Get.height * 0.01),
                              Form(
                                key: controller.formKey,
                                autovalidateMode: controller.autoValidateMode.value,
                                child: TextFField(
                                  focusNode: controller.fd,
                                  controller: controller.docketController,
                                  fillColor: AppColors.surfaceElevated,
                                  radius: 14,
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(left: Get.width * 0.02),
                                    child: Icon(
                                      Icons.local_shipping_outlined,
                                      color: AppColors.textSecondary.withOpacity(0.9),
                                      size: 22,
                                    ),
                                  ),
                                  validator: (p0) {
                                    if ((p0 ?? '').isEmpty) {
                                      return 'Please Enter Docket Code...';
                                    }
                                    return null;
                                  },
                                  hintText: 'Enter docket code',
                                ),
                              ),
                              HBox(Get.height * 0.028),
                              CommonButton(
                                onPressed: controller.validate,
                                textVal: 'Track',
                                bgColor: AppColors.primaryColor,
                                btnRadius: 14,
                              ),
                              HBox(Get.height * 0.012),
                              CommonButton(
                                onPressed: () => Get.toNamed(Routes.BIDDING_DASHBOARD),
                                textVal: 'Enquiry',
                                bgColor: AppColors.primaryColor.withOpacity(0.12),
                                btnRadius: 14,
                                style: AppTextStyle.regularTextStyle.copyWith(
                                  fontSize: 16,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        HBox(Get.height * 0.02),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: Get.width * 0.05,
                    right: Get.width * 0.05,
                    bottom: MediaQuery.paddingOf(context).bottom + Get.height * 0.014,
                    top: Get.height * 0.006,
                  ),
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Developed by ',
                            style: AppTextStyle.regularTextStyle.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          TextSpan(
                            text: 'Logibrisk',
                            style: AppTextStyle.regularTextStyle.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
