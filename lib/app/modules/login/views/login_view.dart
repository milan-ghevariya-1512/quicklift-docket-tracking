import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      body: Column(
        children: [
          HBox(MediaQuery.paddingOf(context).top + Get.height * 0.02),
          
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
            child: Column(
              children: [
                Image.asset(
                  AppImage.quickLiftLogoImage,
                  width: Get.width * 0.52,
                  fit: BoxFit.contain,
                ),
                HBox(Get.height * 0.01),
                Text(
                  'Sign in to continue',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.regularTextStyle.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
            
          HBox(Get.height*0.03),

          Expanded(
            child: Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: AppColors.surfaceColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.textBlackColor.withValues(alpha: 0.1),
                    blurRadius: 24,
                    offset: const Offset(0, -8),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      Get.width * 0.06,
                      Get.height * 0.03,
                      Get.width * 0.06,
                      MediaQuery.paddingOf(context).bottom + Get.height * 0.04,
                    ),
                    child: Obx(
                          () => controller.isPin.value
                          ? buildOtpSection(context)
                          : buildPhoneSection(context),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPhoneSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome',
          style: AppTextStyle.regularTextStyle.copyWith(
            color: AppColors.textBlackColor,
            fontWeight: FontWeight.w700,
            fontSize: 26,
            letterSpacing: -0.5,
            height: 1.2,
          ),
        ),
        HBox(Get.height * 0.008),
        Text(
          'QuickLift Delivery Pvt Ltd.',
          style: AppTextStyle.regularTextStyle.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
            fontSize: 15,
            height: 1.35,
          ),
        ),
        HBox(Get.height * 0.032),
        Text(
          'Mobile number',
          style: AppTextStyle.regularTextStyle.copyWith(
            color: AppColors.textBlackColor,
            fontWeight: FontWeight.w600,
            fontSize: 13,
            letterSpacing: 0.2,
          ),
        ),
        HBox(Get.height * 0.012),
        Form(
          key: controller.formKey,
          autovalidateMode: controller.autoValidateMode.value,
          child: TextFormField(
            style: AppTextStyle.regularTextStyle.copyWith(
              overflow: TextOverflow.ellipsis,
              color: AppColors.textBlackColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.3,
            ),
            controller: controller.noController,
            focusNode: controller.fd,
            maxLength: 10,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if ((value ?? '').isEmpty) {
                return 'Please enter your mobile number';
              } else if ((value ?? '').length < 10) {
                return 'Please enter valid mobile number';
              }
              return null;
            },
            onEditingComplete: () {
              FocusScope.of(context).unfocus();
            },
            onChanged: (value) {
              if (value.length == 10) {
                FocusScope.of(context).unfocus();
              }
            },
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
            decoration: InputDecoration(
              counterText: '',
              filled: true,
              fillColor: AppColors.surfaceElevated,
              isDense: true,
              prefixIcon: Icon(
                Icons.phone_android_rounded,
                color: AppColors.textSecondary.withValues(alpha: 0.85),
                size: 22,
              ),
              prefixIconConstraints: BoxConstraints(
                minWidth: Get.width * 0.14,
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: Get.height * 0.018,
                horizontal: Get.width * 0.02,
              ),
              hintText: '10-digit mobile number',
              hintStyle: AppTextStyle.regularTextStyle.copyWith(
                color: AppColors.hintTextColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: AppColors.borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: AppColors.borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                  color: AppColors.primaryColor,
                  width: 1.5,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: AppColors.borderColor),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                  width: 1,
                  color: AppColors.redColor,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                  width: 1.5,
                  color: AppColors.redColor,
                ),
              ),
              errorStyle: AppTextStyle.regularTextStyle.copyWith(
                color: AppColors.redColor,
                fontSize: 12,
              ),
            ),
          ),
        ),
        HBox(Get.height * 0.04),
        CommonButton(
          bgColor: AppColors.primaryColor,
          textVal: 'Request OTP',
          btnRadius: 14,
          onPressed: () => controller.validate(),
        ),
      ],
    );
  }

  Widget buildOtpSection(BuildContext context) {
    final pinSize = Get.height * 0.058;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Material(
              color: AppColors.surfaceElevated,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                onTap: () {
                  controller.isPin.value = false;
                  controller.update();
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Icon(
                    Icons.arrow_back_rounded,
                    color: AppColors.textBlackColor,
                    size: 22,
                  ),
                ),
              ),
            ),
            WBox(Get.width * 0.03),
            Expanded(
              child: Text(
                'Enter verification code',
                style: AppTextStyle.regularTextStyle.copyWith(
                  color: AppColors.textBlackColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.3,
                ),
              ),
            ),
          ],
        ),
        HBox(Get.height * 0.02),
        Container(
          height: 1,
          color: AppColors.borderColor,
        ),
        HBox(Get.height * 0.022),
        RichText(
          text: TextSpan(
            style: AppTextStyle.regularTextStyle.copyWith(
              color: AppColors.textSecondary,
              fontSize: 14,
              height: 1.45,
            ),
            children: [
              const TextSpan(
                text: 'We sent a 6-digit code to your ',
              ),
              TextSpan(
                text: 'WhatsApp',
                style: AppTextStyle.regularTextStyle.copyWith(
                  color: AppColors.greenColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              const TextSpan(
                text: '. Enter it below to sign in.',
              ),
            ],
          ),
        ),
        HBox(Get.height * 0.032),
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
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
            closeKeyboardWhenCompleted: true,
            pinAnimationType: PinAnimationType.scale,
            androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            animationCurve: Curves.easeOutCubic,
            crossAxisAlignment: CrossAxisAlignment.center,
            keyboardType: TextInputType.number,
            defaultPinTheme: PinTheme(
              width: pinSize,
              height: pinSize,
              textStyle: AppTextStyle.regularTextStyle.copyWith(
                color: AppColors.textBlackColor,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
              decoration: BoxDecoration(
                color: AppColors.surfaceElevated,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderColor),
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
              width: pinSize,
              height: pinSize,
              textStyle: AppTextStyle.regularTextStyle.copyWith(
                color: AppColors.textBlackColor,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
              decoration: BoxDecoration(
                color: AppColors.surfaceColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.primaryColor,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
            submittedPinTheme: PinTheme(
              width: pinSize,
              height: pinSize,
              textStyle: AppTextStyle.regularTextStyle.copyWith(
                color: AppColors.textBlackColor,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
              decoration: BoxDecoration(
                color: AppColors.surfaceElevated,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderColor),
              ),
            ),
            errorPinTheme: PinTheme(
              width: pinSize,
              height: pinSize,
              textStyle: AppTextStyle.regularTextStyle.copyWith(
                color: AppColors.redColor,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
              decoration: BoxDecoration(
                color: AppColors.surfaceColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.redColor, width: 1.5),
              ),
            ),
          ),
        ),
        HBox(Get.height * 0.028),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                if (controller.enableResend.value) controller.resendCode();
              },
              child: Text(
                'Resend code',
                style: AppTextStyle.regularTextStyle.copyWith(
                  color: controller.enableResend.value
                      ? AppColors.primaryColor
                      : AppColors.hintTextColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  decoration: controller.enableResend.value
                      ? TextDecoration.underline
                      : TextDecoration.none,
                  decorationColor: AppColors.primaryColor,
                ),
              ),
            ),
            if (controller.secondsRemaining.value != 0) ...[
              WBox(Get.width * 0.025),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.redColor.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '00:${controller.secondsRemaining.value.toString().padLeft(2, '0')}',
                  style: AppTextStyle.regularTextStyle.copyWith(
                    color: AppColors.redColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ),
            ],
          ],
        ),
        HBox(Get.height * 0.036),
        CommonButton(
          bgColor: AppColors.primaryColor,
          textVal: 'Verify',
          btnRadius: 14,
          onPressed: () => controller.validate1(context),
        ),
      ],
    );
  }
}