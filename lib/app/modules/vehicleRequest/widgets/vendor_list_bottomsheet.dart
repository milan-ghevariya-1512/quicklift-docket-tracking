import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Reusability/utils/app_colors.dart';
import '../../../../Reusability/utils/app_images.dart';
import '../../../../Reusability/utils/app_textstyle.dart';
import '../../../../Reusability/widgets/common_widget.dart';
import '../controllers/vehicle_request_controller.dart';

class VendorListBottomSheet extends StatelessWidget {
  VendorListBottomSheet({super.key, required this.c});
  VehicleRequestController c;

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
                  Expanded(child: Text(c.getFieldData("VR_BIDVENDOR")?.fieldCaption ?? 'Vendor', style: AppTextStyle.regularTextStyle.copyWith(fontWeight: FontWeight.w700, fontSize: 19, color: AppColors.textBlackColor))),
                  WBox(Get.width * 0.02),
                  InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        Get.back();
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Icon(Icons.close)
                  ),
                ],
              ),
              HBox(Get.height * 0.018),
              Divider(height: 1, thickness: 1, color: AppColors.borderColor),
              HBox(Get.height * 0.01),
              Expanded(
                child: GetBuilder<VehicleRequestController>(
                  builder: (ctrl) {
                    if (ctrl.vendorList.isEmpty) {
                      return Center(
                        child: Text(
                          'No vendors found',
                          style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.hintTextColor, fontSize: 14),
                        ),
                      );
                    }
                    return ListView.separated(
                      itemCount: ctrl.vendorList.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      separatorBuilder: (_, __) => Divider(height: 1, color: AppColors.borderColor),
                        itemBuilder: (_, i) {
                          final v = ctrl.vendorList[i];
                          final checked = ctrl.isVendorSelected(v);

                          return InkWell(
                            onTap: () => ctrl.toggleVendorSelection(v),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: Get.height * 0.015),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    checked ? AppImage.radioSelectIcon : AppImage.radioIcon,
                                    color: AppColors.primaryColor,
                                    height: Get.height * 0.025, width: Get.height * 0.025, fit: BoxFit.contain
                                  ),
                                  WBox(Get.width * 0.02),
                                  Expanded(
                                    child: Text(
                                      '${v.vendorCode ?? ''} : ${v.codeDesc ?? ''}',
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
                        }
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
