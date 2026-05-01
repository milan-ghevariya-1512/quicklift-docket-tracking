import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Reusability/utils/app_colors.dart';
import '../../../../Reusability/utils/app_textstyle.dart';
import '../../../../Reusability/widgets/common_widget.dart';

class ExitAppPopup extends StatelessWidget {
  const ExitAppPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          HBox(Get.height * 0.02),
          Container(
            padding: EdgeInsets.all(Get.width * 0.06),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.exit_to_app_rounded, size: Get.height * 0.08, color: AppColors.primaryColor),
          ),
          HBox(Get.height * 0.028),
          Text(
            'Do you want to close the app?'.tr,
            textAlign: TextAlign.center,
            style: AppTextStyle.regularTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600, height: 1.45),
          ),
          HBox(Get.height * 0.028),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => Get.back(result: false),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: Get.height * 0.016, horizontal: Get.width * 0.04),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceElevated,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: AppColors.borderColor),
                    ),
                    child: Center(
                      child: Text('No'.tr, style: AppTextStyle.regularTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: 0.5, color: AppColors.primaryColor)),
                    ),
                  ),
                ),
              ),
              WBox(Get.width * 0.03),
              Expanded(
                child: GestureDetector(
                  onTap: () => Get.back(result: true),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: Get.height * 0.016, horizontal: Get.width * 0.04),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryColor.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text('Yes'.tr, style: AppTextStyle.regularTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: 0.5, color: AppColors.whiteColor)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}