import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Reusability/utils/app_colors.dart';
import '../../../../Reusability/utils/app_images.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  SplashView({super.key});

  @override
  final controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
        child: Image.asset(
          AppImage.quickLiftLogoImage,
          width: Get.width * 0.8,
        ),
      ),
    );
  }
}