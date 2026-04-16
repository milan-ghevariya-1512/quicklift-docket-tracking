import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Reusability/utils/app_colors.dart';
import '../../../../Reusability/utils/app_images.dart';
import '../../../../Reusability/utils/app_textstyle.dart';
import '../../../../Reusability/widgets/common_widget.dart';
import '../controllers/docket_search_controller.dart';

class DocketSearchView extends GetView<DocketSearchController> {
  DocketSearchView({super.key});

  @override
  final controller = Get.put(DocketSearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          foregroundColor: AppColors.textBlackColor,
          backgroundColor: AppColors.whiteColor,
          elevation: 5,
          shadowColor:AppColors.textBlackColor.withOpacity(0.4),
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(22),
            ),
          ),
          title: Text("QuickLift",style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor,fontWeight: FontWeight.w600,fontSize: 16)),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width*0.04,vertical: Get.height*0.012),
          child: SizedBox(
            width: Get.width,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                HBox(Get.height*0.01),

                Text("${controller.organizationModel.organizationName}",textAlign: TextAlign.start,style: AppTextStyle.regularTextStyle.copyWith(fontWeight: FontWeight.w600,fontSize: 18,color: AppColors.secondaryColor)),

                HBox(Get.height*0.01),

                Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          HBox(Get.height*0.015),

                          Center(child: Image.asset(AppImage.docketSearchImage,height: Get.height*0.25)),

                          HBox(Get.height*0.035),

                          Text(" Docket Code",textAlign: TextAlign.start,style: AppTextStyle.regularTextStyle.copyWith(fontWeight: FontWeight.w500,fontSize: 14,color: AppColors.textBlackColor)),
                          HBox(Get.height*0.012),
                          Form(
                            key: controller.formKey,
                            autovalidateMode: controller.autoValidateMode.value,
                            child: TextFField(
                              focusNode: controller.fd,
                              controller: controller.docketController,
                              validator: (p0) {
                                if((p0 ?? '').isEmpty){
                                  return "Please Enter Docket Code...";
                                }
                                return null;
                              },
                              hintText: "Enter Docket Code",
                            ),
                          ),
                          HBox(Get.height*0.02),
                          CommonButton(
                            onPressed: controller.validate,
                            textVal: "Track",
                            bgColor: AppColors.primaryColor,
                            bColor: AppColors.primaryColor,
                          ),
                          HBox(Get.height*0.01),
                        ],
                      ),
                    )
                ),


                HBox(Get.height*0.01),

                Center(
                  child: RichText(text: TextSpan(
                      children: [
                        TextSpan(text: 'Develop By: ',style: AppTextStyle.regularTextStyle.copyWith(fontWeight: FontWeight.w500,fontSize: 13,color: AppColors.textBlackColor)),
                        TextSpan(text: 'Logibrisk',style: AppTextStyle.regularTextStyle.copyWith(fontWeight: FontWeight.w500,fontSize: 13,color: AppColors.primaryColor)),
                      ]
                  )),
                )

              ],
            ),
          ),
        )
    );
  }
}