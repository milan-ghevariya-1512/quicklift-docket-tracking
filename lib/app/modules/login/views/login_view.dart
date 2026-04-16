import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pinput/pinput.dart';
import 'package:quicklift_docket_tracking/Reusability/widgets/common_widget.dart';
import '../../../../Reusability/utils/app_colors.dart';
import '../../../../Reusability/utils/app_images.dart';
import '../../../../Reusability/utils/app_textstyle.dart';
import '../controllers/login_controller.dart';

class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {


  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [

            Container(
              color: Colors.white,
              height: Get.height,
              width: Get.width,
            ),

            Column(
              children: [

                HBox(MediaQuery.of(context).padding.top + Get.height*0.015),

                Center(
                  child: Image.asset(
                    AppImage.quickLiftLogoImage,
                    width: Get.width * 0.6,
                  ),
                ),

                HBox(Get.height*0.12),

                Container(
                  width: Get.width,
                  padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.4),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
                  ),
                  child:  Obx(() =>  controller.isPin.value ?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      HBox(Get.height*0.06),

                      Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                controller.isPin.value = false;
                                controller.update();
                              },
                              child: Icon(Icons.arrow_back,color: AppColors.textBlackColor)),
                          SizedBox(width: Get.width*0.04),
                          Text("Enter 6 digit code",style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor,fontSize: 16,fontWeight: FontWeight.w600)),
                        ],
                      ),

                      Divider(color: Colors.grey.withOpacity(0.6),),

                      HBox(Get.height*0.015),

                      RichText(text: TextSpan(
                          children: [
                            TextSpan(text: 'We have sent your 6 digit verification code on your ',style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor.withOpacity(0.8),fontSize: 13)),
                            TextSpan(text: 'WhatsApp',style: AppTextStyle.regularTextStyle.copyWith(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 13.5)),
                            TextSpan(text: ' , use that code for log in ...',style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor.withOpacity(0.8),fontSize: 13)),
                          ]
                      )),

                      HBox(Get.height*0.04),
                      Form(
                        key: controller.formKey1,
                        autovalidateMode: controller.autoValidateMode1.value,
                        child: Pinput(
                          controller: controller.pinController,
                          length: 6,
                          onSubmitted: (value) {
                            FocusScope.of(context).unfocus();
                          },
                          onCompleted: (value) {
                            FocusScope.of(context).unfocus();
                          },
                          closeKeyboardWhenCompleted: true,
                          pinAnimationType: PinAnimationType.scale,
                          androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
                          pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                          animationCurve: Curves.bounceIn,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          keyboardType: TextInputType.number,
                          defaultPinTheme: PinTheme(
                            width: Get.height * 0.065,
                            height: Get.height * 0.065,
                            textStyle: AppTextStyle.regularTextStyle.copyWith(color:AppColors.textBlackColor,fontSize: 16,fontWeight:FontWeight.w500),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.greyColor),
                            ),
                          ),
                          validator: (value) {
                            if (value == "") {
                              return 'Please enter Otp';
                            } else if (value!.length < 6) {
                              return 'Please enter full Otp';
                            }
                            return null;
                          },
                          focusedPinTheme: PinTheme(
                            width: Get.height * 0.065,
                            height: Get.height * 0.065,
                            textStyle: AppTextStyle.regularTextStyle.copyWith(color:AppColors.textBlackColor,fontSize: 16,fontWeight:FontWeight.w500),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.greyColor),
                            ),
                          ),
                          submittedPinTheme: PinTheme(
                            width: Get.height * 0.065,
                            height: Get.height * 0.065,
                            textStyle: AppTextStyle.regularTextStyle.copyWith(color:AppColors.textBlackColor,fontSize: 16,fontWeight:FontWeight.w500),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.greyColor),
                            ),
                          ),
                          errorPinTheme: PinTheme(
                            width: Get.height * 0.065,
                            height: Get.height * 0.065,
                            textStyle: AppTextStyle.regularTextStyle.copyWith(color:Colors.red,fontSize: 16,fontWeight:FontWeight.w500),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.redColor),
                            ),
                          ),),
                      ),
                      HBox(Get.height*0.025),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () {
                                if(controller.enableResend.value)controller.resendCode();
                              },
                              child: Text('Resend Code ? ',style: AppTextStyle.regularTextStyle.copyWith(color:controller.enableResend.value?AppColors.primaryColor:Colors.black45,fontSize: 14,fontWeight:FontWeight.w400),)),
                          controller.secondsRemaining.value != 0 ? Text(
                            '00:${controller.secondsRemaining.value}',
                            style: AppTextStyle.regularTextStyle.copyWith(color:Colors.red,fontSize: 12,fontWeight:FontWeight.w500),
                          ) : Container(),
                        ],
                      ),
                      HBox(Get.height*0.04),
                      CommonButton(bgColor: Color(0xffed1b24),bColor: Color(0xffed1b24),textVal: "Verify",onPressed: () => controller.validate1(context)),

                      HBox(Get.height*0.02),
                      HBox(MediaQuery.of(context).padding.bottom + Get.height*0.04),
                    ],
                  ) :
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      HBox(Get.height*0.06),
                      Center(child: Text("Welcome to QuickLift Delivery Pvt Ltd.",textAlign: TextAlign.center,style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor,fontWeight: FontWeight.w600,fontSize: 18))),
                      HBox(Get.height*0.04),
                      Text("Enter Your Mobile Number",style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor.withOpacity(0.8),fontWeight: FontWeight.w400,fontSize: 11)),
                      HBox(Get.height*0.02),

                      Form(
                          key: controller.formKey,
                          autovalidateMode: controller.autoValidateMode.value,
                          child: TextFormField(
                            style: AppTextStyle.regularTextStyle.copyWith(overflow: TextOverflow.ellipsis,color:AppColors.textBlackColor,fontSize: 14,fontWeight:FontWeight.w500),
                            controller: controller.noController,
                            focusNode: controller.fd,
                            maxLength: 10,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if((value ?? '').isEmpty){
                                return 'Please enter your mobile number';
                              } else if((value ?? '').length < 10){
                                return 'Please enter valid mobile number';
                              }
                            },
                            onEditingComplete: () {
                              FocusScope.of(context).unfocus();
                            },
                            onChanged: (value) {
                              if(value.length==10){
                                FocusScope.of(context).unfocus();
                              }
                            },
                            decoration: InputDecoration(
                              counterText: '',
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: Get.height * 0.01, horizontal: Get.width * 0.05),
                              hintText: "Phone Number",
                              hintStyle: AppTextStyle.regularTextStyle.copyWith(color:AppColors.textBlackColor.withOpacity(0.8),fontSize: 12),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none
                              ),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(width: 1, color: AppColors.redColor),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(width: 1.5, color: AppColors.redColor),
                              ),
                              errorStyle: AppTextStyle.regularTextStyle.copyWith(color: AppColors.redColor,fontSize: 12),
                            ),
                          )),

                      HBox(Get.height*0.05),
                      CommonButton(bgColor: Color(0xffed1b24),bColor: Color(0xffed1b24),textVal: "Request OTP",onPressed: () => controller.validate()),

                      HBox(Get.height*0.02),
                      HBox(MediaQuery.of(context).padding.bottom + Get.height*0.06),
                    ],
                  )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}