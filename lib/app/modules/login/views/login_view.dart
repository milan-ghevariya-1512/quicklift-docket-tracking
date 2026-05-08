import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
                )
                    .animate()
                    .fadeIn(
                      duration: 520.ms,
                      curve: Curves.easeOutCubic,
                    )
                    .scale(
                      begin: const Offset(0.9, 0.9),
                      end: const Offset(1, 1),
                      duration: 520.ms,
                      curve: Curves.easeOutCubic,
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
                )
                    .animate()
                    .fadeIn(
                      delay: 120.ms,
                      duration: 400.ms,
                      curve: Curves.easeOut,
                    )
                    .slideY(
                      begin: 0.08,
                      end: 0,
                      delay: 120.ms,
                      duration: 400.ms,
                      curve: Curves.easeOutCubic,
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
                      () {
                        final mode = controller.loginEntryMode.value;
                        final isOtp = controller.isPin.value;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            buildLoginModeSwitcher(context, mode),
                            HBox(Get.height * 0.022),
                            if (mode == LoginEntryMode.phoneOtp)
                              KeyedSubtree(
                                key: ValueKey(isOtp),
                                child: (isOtp
                                        ? buildOtpSection(context)
                                        : buildPhoneSection(context))
                                    .animate()
                                    .fadeIn(
                                      duration: 360.ms,
                                      curve: Curves.easeOutCubic,
                                    )
                                    .slideY(
                                      begin: 0.04,
                                      end: 0,
                                      duration: 360.ms,
                                      curve: Curves.easeOutCubic,
                                    ),
                              )
                            else
                              KeyedSubtree(
                                key: const ValueKey('username_login'),
                                child: buildUsernameSection(context)
                                    .animate()
                                    .fadeIn(
                                      duration: 360.ms,
                                      curve: Curves.easeOutCubic,
                                    )
                                    .slideY(
                                      begin: 0.04,
                                      end: 0,
                                      duration: 360.ms,
                                      curve: Curves.easeOutCubic,
                                    ),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            )
                .animate()
                .fadeIn(
                  delay: 90.ms,
                  duration: 480.ms,
                  curve: Curves.easeOutCubic,
                )
                .slideY(
                  begin: 0.1,
                  end: 0,
                  delay: 90.ms,
                  duration: 500.ms,
                  curve: Curves.easeOutCubic,
                ),
          ),
        ],
      ),
    );
  }

  Widget buildLoginModeSwitcher(BuildContext context, LoginEntryMode mode) {
    Widget segment(String label, LoginEntryMode value) {
      final selected = mode == value;
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => controller.setLoginEntryMode(value),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: AnimatedDefaultTextStyle(
              duration: 260.ms,
              curve: Curves.easeOutCubic,
              style: AppTextStyle.regularTextStyle.copyWith(
                color: selected
                    ? AppColors.whiteColor
                    : AppColors.textSecondary,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              child: Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final half = constraints.maxWidth / 2;
          final phoneSelected = mode == LoginEntryMode.phoneOtp;
          return Stack(
            children: [
              AnimatedPositioned(
                duration: 260.ms,
                curve: Curves.easeOutCubic,
                left: phoneSelected ? 0 : half,
                top: 0,
                bottom: 0,
                width: half,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(child: segment('Mobile number', LoginEntryMode.phoneOtp)),
                  Expanded(child: segment('Username', LoginEntryMode.usernamePassword)),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildUsernameSection(BuildContext context) {
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
          'Username',
          style: AppTextStyle.regularTextStyle.copyWith(
            color: AppColors.textBlackColor,
            fontWeight: FontWeight.w600,
            fontSize: 13,
            letterSpacing: 0.2,
          ),
        ),
        HBox(Get.height * 0.012),
        Obx(
          () => Form(
            key: controller.formKeyUsername,
            autovalidateMode: controller.autoValidateModeUsername.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFField(
                  controller: controller.userNameController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  prefixIcon: Icon(
                    Icons.person_outline_rounded,
                    color: AppColors.textSecondary.withValues(alpha: 0.85),
                    size: 22,
                  ),
                  hintText: 'Enter username',
                  validator: (value) {
                    if ((value ?? '').trim().isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                  onEditingComplete: () {
                    FocusScope.of(context).nextFocus();
                  },
                ),
                HBox(Get.height * 0.02),
                Text(
                  'Password',
                  style: AppTextStyle.regularTextStyle.copyWith(
                    color: AppColors.textBlackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    letterSpacing: 0.2,
                  ),
                ),
                HBox(Get.height * 0.012),
                TextFField(
                  controller: controller.passwordController,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  prefixIcon: Icon(
                    Icons.lock_outline_rounded,
                    color: AppColors.textSecondary.withValues(alpha: 0.85),
                    size: 22,
                  ),
                  hintText: 'Enter password',
                  validator: (value) {
                    if ((value ?? '').isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  onEditingComplete: () {
                    FocusScope.of(context).unfocus();
                  },
                ),
              ],
            ),
          ),
        ),
        HBox(Get.height * 0.04),
        CommonButton(
          bgColor: AppColors.primaryColor,
          textVal: 'Sign in',
          onPressed: () => controller.validateUsernameLogin(),
        ),
      ],
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
          child: TextFField(
            controller: controller.noController,
            focusNode: controller.fd,
            maxLength: 10,
            keyboardType: TextInputType.phone,
            prefixIcon: Icon(
              Icons.phone_android_rounded,
              color: AppColors.textSecondary.withValues(alpha: 0.85),
              size: 22,
            ),
            hintText: '10-digit mobile number',
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
          ),
        ),
        HBox(Get.height * 0.04),
        CommonButton(
          bgColor: AppColors.primaryColor,
          textVal: 'Request OTP',
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
          onPressed: () => controller.validate1(context),
        ),
      ],
    );
  }
}