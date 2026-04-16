
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../../Reusability/utils/app_colors.dart';
import '../../../../Reusability/utils/app_images.dart';
import '../../../../Reusability/utils/app_textstyle.dart';
import '../../../../Reusability/utils/util.dart';
import '../../../../Reusability/widgets/common_widget.dart';
import '../../../routes/app_pages.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  DashboardView({super.key});

  @override
  final controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 5,
        shadowColor:AppColors.textBlackColor.withOpacity(0.4),
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(22),
          ),
        ),
        title: Row(
          children: [
            WBox(Get.width*0.02),
            Text("QuickLift",style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor,fontWeight: FontWeight.w600,fontSize: 16)),
            const Spacer(),
            Image.asset(AppImage.quickLiftLogoImage,width: Get.height*0.15),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width*0.04,vertical: Get.height*0.012),
        child: SizedBox(
          width: Get.width,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              HBox(Get.height*0.01),

              GestureDetector(
                onTap: () {
                  launchUrlString('https://quickliftdelivery.com',mode: LaunchMode.externalApplication);
                },
                child: Row(
                  children: [
                    Text(" Welcome To QuickLift",textAlign: TextAlign.start,style: AppTextStyle.regularTextStyle.copyWith(fontWeight: FontWeight.w600,fontSize: 15.5,color: AppColors.secondaryColor)),
                    Image.asset(AppImage.visitIcon,height: Get.height*0.035,width: Get.height*0.035,)
                  ],
                ),
              ),
              // HBox(Get.height*0.005),
              // Text(" Shree Azad Group",textAlign: TextAlign.start,style: AppTextStyle.regularTextStyle.copyWith(fontWeight: FontWeight.w500,fontSize: 16,color: AppColors.textBlackColor)),
              HBox(Get.height*0.015),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      HBox(Get.height*0.01),

                      Center(child: Image.asset(AppImage.quickLift,fit: BoxFit.contain,height: Get.height*0.27)),

                      HBox(Get.height*0.025),

                      /*Obx(() => controller.isLoaded.value ?
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: Get.height*0.18),
                        child: Utils.loader(),
                      ) :
                      controller.organizationList.isEmpty ?
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: Get.height*0.16),
                        child: NoData(),
                      ) :
                      ListView.separated(
                        itemCount: controller.organizationList.length,
                        shrinkWrap: true,
                        reverse: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              print("controller.organizationList[index] ${controller.organizationList[index].organizationId}");
                              Get.toNamed(Routes.DOCKETSEARCH,arguments: [controller.organizationList[index]]);
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [

                                Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.whiteColor,
                                        boxShadow: [
                                          BoxShadow(
                                              color: AppColors.whiteColor,
                                              blurRadius: 20,
                                              blurStyle: BlurStyle.inner
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(12)
                                    ),
                                    child: Image.asset(AppImage.dashOrgImage)),

                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    WBox(Get.width*0.02),

                                    Image.memory(
                                      Utils.convertBase64Image(controller.organizationList[index].mobileAppLogo ?? ''),
                                      gaplessPlayback: true,
                                      width: Get.width*0.25,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.error_outline_outlined,color: AppColors.primaryColor,),
                                    ),

                                    WBox(Get.width*0.02),

                                    Expanded(
                                        child: Text("${controller.organizationList[index].organizationName ?? ''}",maxLines: 3,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor,fontSize: 14))
                                    ),

                                    WBox(Get.width*0.01),

                                    Image.asset(AppImage.dashArrowImage,fit: BoxFit.cover,height: Get.height*0.035,width: Get.height*0.035,),

                                    WBox(Get.width*0.03),

                                  ],
                                ),


                                // Container(
                                //   padding: EdgeInsets.all(Get.height*0.01),
                                //   margin: EdgeInsets.symmetric(horizontal: Get.width*0.02,vertical: Get.height*0.01),
                                //   decoration: BoxDecoration(
                                //       color: AppColors.whiteColor,
                                //       boxShadow: [
                                //         BoxShadow(
                                //           color: AppColors.greyColor.withOpacity(0.5),
                                //           blurRadius: 5.0,
                                //         )
                                //       ],
                                //       borderRadius: BorderRadius.circular(8)
                                //   ),
                                //   child:
                                // ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return HBox(Get.height*0.02);
                        },
                      )),*/

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
                      HBox(Get.height*0.04),
                      CommonButton(
                        onPressed: controller.validate,
                        textVal: "Track",
                        bgColor: AppColors.primaryColor,
                        bColor: AppColors.primaryColor,
                      ),
                      HBox(Get.height*0.025),
                      // Align(
                      //     alignment: Alignment.centerRight,
                      //     child: Text("Learn More About QuickLift",textAlign: TextAlign.end,style: AppTextStyle.regularTextStyle.copyWith(fontWeight: FontWeight.w500,fontSize: 12,color: AppColors.textBlackColor))),
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