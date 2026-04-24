import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Reusability/utils/app_colors.dart';
import '../../../../Reusability/utils/app_images.dart';
import '../../../../Reusability/utils/app_textstyle.dart';
import '../../../../Reusability/widgets/common_widget.dart';
import '../controllers/vehicle_request_controller.dart';

class LaneListBottomSheet extends StatelessWidget {
  LaneListBottomSheet({super.key, required this.c});
  final VehicleRequestController c;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        width: Get.width,
        height: Get.height * 0.65,
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
                  Expanded(
                    child: Text(
                      c.getFieldData("VR_BIDLANE")?.fieldCaption ?? 'Lane',
                      style: AppTextStyle.regularTextStyle.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 19,
                        color: AppColors.textBlackColor,
                      ),
                    ),
                  ),
                  WBox(Get.width * 0.02),
                  InkWell(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      Get.back();
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: const Icon(Icons.close),
                  ),
                ],
              ),
              HBox(Get.height * 0.018),
              Divider(height: 1, thickness: 1, color: AppColors.borderColor),
              HBox(Get.height * 0.01),
              Expanded(
                child: GetBuilder<VehicleRequestController>(
                  builder: (ctrl) {
                    if (ctrl.laneList.isEmpty) {
                      return Center(
                        child: Text(
                          'No lanes found',
                          style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.hintTextColor, fontSize: 14),
                        ),
                      );
                    }
                    return ListView.separated(
                      itemCount: ctrl.laneList.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      separatorBuilder: (_, __) => Divider(height: 1, color: AppColors.borderColor),
                      itemBuilder: (_, i) {
                        final lane = ctrl.laneList[i];
                        final checked = ctrl.isLaneSelected(lane);
                        return InkWell(
                          onTap: () => ctrl.toggleLaneSelection(lane),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: Get.height * 0.015),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  checked ? AppImage.radioSelectIcon : AppImage.radioIcon,
                                  color: AppColors.primaryColor,
                                  height: Get.height * 0.025,
                                  width: Get.height * 0.025,
                                  fit: BoxFit.contain,
                                ),
                                WBox(Get.width * 0.02),
                                Expanded(
                                  child: Text(
                                    lane.codeDetail ?? '',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyle.regularTextStyle.copyWith(
                                      color: AppColors.textBlackColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              HBox(Get.height * 0.005),
              CommonButton(textVal: "Done", onPressed: () => Get.back()),
              HBox(MediaQuery.of(context).padding.bottom + Get.height * 0.015),
            ],
          ),
        ),
      ),
    );
  }
}
