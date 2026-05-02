import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../../../Reusability/utils/app_colors.dart';
import '../../../../Reusability/utils/app_images.dart';
import '../../../../Reusability/utils/app_textstyle.dart';
import '../../../../Reusability/widgets/common_widget.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  SplashView({super.key});

  static const int stepLogo = 0;
  static const int stepTitle = 560;
  static const int stepSubtitle = 980;

  static const int durLogo = 480;
  static const int durText = 400;

  @override
  final controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primaryColor.withValues(alpha: 0.14),
              AppColors.backgroundColor,
              AppColors.whiteColor,
            ],
            stops: const [0.0, 0.42, 1.0],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -Get.height * 0.12,
              right: -Get.width * 0.15,
              child: Container(
                width: Get.width * 0.55,
                height: Get.width * 0.55,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor.withValues(alpha: 0.06),
                ),
              ),
            ),
            Positioned(
              bottom: Get.height * 0.18,
              left: -Get.width * 0.08,
              child: Container(
                width: Get.width * 0.35,
                height: Get.width * 0.35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.blueColor.withValues(alpha: 0.05),
                ),
              ),
            ),
            Positioned(
              bottom: -Get.height * 0.05,
              right: -Get.width * 0.08,
              child: Container(
                width: Get.width * 0.35,
                height: Get.width * 0.35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.blueColor.withValues(alpha: 0.05),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HBox(MediaQuery.paddingOf(context).top + Get.height * 0.015),
                brandBlock(),
                HBox(MediaQuery.paddingOf(context).bottom + Get.height * 0.1)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget brandBlock() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(Get.width * 0.04),
            decoration: BoxDecoration(
              color: AppColors.surfaceColor,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.borderColor),
              boxShadow: [
                BoxShadow(
                  color: AppColors.textBlackColor.withValues(alpha: 0.06),
                  blurRadius: 28,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Image.asset(
              AppImage.quickLiftLogoImage,
              width: Get.width * 0.58,
              fit: BoxFit.contain,
            ),
          )
              .animate()
              .fadeIn(
                delay: Duration(milliseconds: stepLogo),
                duration: Duration(milliseconds: durLogo),
                curve: Curves.easeOutCubic,
              )
              .slideY(
                delay: Duration(milliseconds: stepLogo),
                begin: 0.06,
                end: 0,
                duration: Duration(milliseconds: durLogo),
                curve: Curves.easeOutCubic,
              )
              .scale(
                delay: Duration(milliseconds: stepLogo),
                begin: const Offset(0.94, 0.94),
                end: const Offset(1, 1),
                duration: Duration(milliseconds: durLogo),
                curve: Curves.easeOutCubic,
              ),
          HBox(Get.height * 0.032),
          Text(
            'QuickLift Delivery Pvt Ltd.',
            textAlign: TextAlign.center,
            style: AppTextStyle.regularTextStyle.copyWith(
              color: AppColors.textBlackColor,
              fontSize: 17,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.35,
              height: 1.25,
            ),
          )
              .animate()
              .fadeIn(
                delay: Duration(milliseconds: stepTitle),
                duration: Duration(milliseconds: durText),
                curve: Curves.easeOutCubic,
              )
              .slideY(
                delay: Duration(milliseconds: stepTitle),
                begin: 0.12,
                end: 0,
                duration: Duration(milliseconds: durText),
                curve: Curves.easeOutCubic,
              )
              .scale(
                delay: Duration(milliseconds: stepTitle),
                begin: const Offset(0.97, 0.97),
                end: const Offset(1, 1),
                duration: Duration(milliseconds: durText),
                curve: Curves.easeOutCubic,
              ),
          HBox(Get.height * 0.01),
          Text(
            'Docket tracking & logistics',
            textAlign: TextAlign.center,
            style: AppTextStyle.regularTextStyle.copyWith(
              color: AppColors.textSecondary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
          )
              .animate()
              .fadeIn(
                delay: Duration(milliseconds: stepSubtitle),
                duration: Duration(milliseconds: durText),
                curve: Curves.easeOutCubic,
              )
              .slideY(
                delay: Duration(milliseconds: stepSubtitle),
                begin: 0.12,
                end: 0,
                duration: Duration(milliseconds: durText),
                curve: Curves.easeOutCubic,
              )
              .scale(
                delay: Duration(milliseconds: stepSubtitle),
                begin: const Offset(0.97, 0.97),
                end: const Offset(1, 1),
                duration: Duration(milliseconds: durText),
                curve: Curves.easeOutCubic,
              ),
        ],
      ),
    );
  }
}