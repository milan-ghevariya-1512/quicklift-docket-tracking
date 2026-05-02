import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../../Reusability/utils/app_colors.dart';
import '../../../../Reusability/utils/app_images.dart';
import '../../../../Reusability/utils/app_textstyle.dart';
import '../../../../Reusability/widgets/common_widget.dart';
import '../../../routes/app_pages.dart';
import '../../vehicleRequest/widgets/exit_app_popup.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  DashboardView({super.key});

  @override
  final controller = Get.put(DashboardController());

  static const Duration step = Duration(milliseconds: 90);

  static const int tVisitStrip = 640;
  static const int tHero = tVisitStrip + 420;
  static const int tTrackBox = tHero + 500;
  static const int tFooter = tTrackBox + 520;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool shouldClose = await Get.defaultDialog(
          content: ExitAppPopup(),
          titlePadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          backgroundColor: AppColors.whiteColor,
          titleStyle: const TextStyle(fontSize: 0),
          title: '',
        );
        return shouldClose;
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Stack(
          children: [
            Image.asset(
              AppImage.background,
              fit: BoxFit.fill,
              height: Get.height,
              width: Get.width,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dashboardTopBar(context),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    Get.width * 0.05,
                    Get.height * 0.018,
                    Get.width * 0.05,
                    Get.height * 0.01,
                  ),
                  child: Material(
                    color: AppColors.surfaceColor,
                    borderRadius: BorderRadius.circular(14),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () {
                        launchUrlString(
                          'https://quickliftdelivery.com',
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.035,
                          vertical: Get.height * 0.014,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.open_in_new_rounded,
                              size: 18,
                              color: AppColors.primaryColor,
                            ),
                            WBox(Get.width * 0.025),
                            Expanded(
                              child: Text(
                                'Visit quickliftdelivery.com',
                                style: AppTextStyle.regularTextStyle.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: AppColors.primaryColor,
                                  height: 1.25,
                                ),
                              ),
                            ),
                            Image.asset(
                              AppImage.visitIcon,
                              height: Get.height * 0.028,
                              width: Get.height * 0.028,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                    .animate()
                    .fadeIn(
                      delay: Duration(milliseconds: tVisitStrip),
                      duration: 400.ms,
                      curve: Curves.easeOutCubic,
                    )
                    .move(
                      delay: Duration(milliseconds: tVisitStrip),
                      begin: const Offset(0, 36),
                      end: Offset.zero,
                      duration: 400.ms,
                      curve: Curves.easeOutCubic,
                    ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                    child: KeyedSubtree(
                      key: const ValueKey('dashboard_home_content'),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          heroCard()
                              .animate()
                              .fadeIn(
                                delay: Duration(milliseconds: tHero),
                                duration: 480.ms,
                                curve: Curves.easeOutCubic,
                              )
                              .move(
                                delay: Duration(milliseconds: tHero),
                                begin: const Offset(0, 48),
                                end: Offset.zero,
                                duration: 480.ms,
                                curve: Curves.easeOutCubic,
                              )
                              .scale(
                                delay: Duration(milliseconds: tHero),
                                begin: const Offset(0.92, 0.92),
                                end: const Offset(1, 1),
                                duration: 480.ms,
                                curve: Curves.easeOutCubic,
                              ),
                          HBox(Get.height * 0.01),
                          trackShipmentCard()
                              .animate()
                              .fadeIn(
                                delay: Duration(milliseconds: tTrackBox),
                                duration: 480.ms,
                                curve: Curves.easeOutCubic,
                              )
                              .move(
                                delay: Duration(milliseconds: tTrackBox),
                                begin: const Offset(0, 44),
                                end: Offset.zero,
                                duration: 480.ms,
                                curve: Curves.easeOutCubic,
                              )
                              .scale(
                                delay: Duration(milliseconds: tTrackBox),
                                begin: const Offset(0.94, 0.94),
                                end: const Offset(1, 1),
                                duration: 480.ms,
                                curve: Curves.easeOutCubic,
                              ),
                          HBox(Get.height * 0.02),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: Get.width * 0.05,
                    right: Get.width * 0.05,
                    bottom: MediaQuery.paddingOf(context).bottom + Get.height * 0.014,
                    top: Get.height * 0.006,
                  ),
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Developed by ',
                            style: AppTextStyle.regularTextStyle.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          TextSpan(
                            text: 'Logibrisk',
                            style: AppTextStyle.regularTextStyle.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                    .animate()
                    .fadeIn(
                      delay: Duration(milliseconds: tFooter),
                      duration: 420.ms,
                      curve: Curves.easeOutCubic,
                    )
                    .move(
                      delay: Duration(milliseconds: tFooter),
                      begin: const Offset(0, 24),
                      end: Offset.zero,
                      duration: 420.ms,
                      curve: Curves.easeOutCubic,
                    ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget dashStep({
    required Duration delay,
    required Widget child,
    Duration duration = const Duration(milliseconds: 360),
    Offset moveBegin = const Offset(20, 0),
  }) {
    return child
        .animate()
        .fadeIn(
      delay: delay,
      duration: duration,
      curve: Curves.easeOutCubic,
    )
        .move(
      delay: delay,
      begin: moveBegin,
      end: Offset.zero,
      duration: duration,
      curve: Curves.easeOutCubic,
    );
  }

  Widget dashboardTopBar(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;
    final barHeight = top + Get.height * 0.074;

    return Container(
      height: barHeight,
      padding: EdgeInsets.only(
        top: top,
        left: Get.width * 0.045,
        right: Get.width * 0.045,
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(24),
        ),
        border: Border(
          bottom: BorderSide(
            color: AppColors.borderColor.withValues(alpha: 0.75),
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, 10),
            spreadRadius: -6,
          ),
          BoxShadow(
            color: AppColors.textBlackColor.withValues(alpha: 0.06),
            blurRadius: 18,
            offset: const Offset(0, 6),
            spreadRadius: -4,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          dashStep(
            delay: Duration.zero,
            moveBegin: const Offset(0, -14),
            child: Container(
              width: 4,
              height: Get.height * 0.04,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.primaryColor,
                    AppColors.primaryColor.withValues(alpha: 0.45),
                  ],
                ),
              ),
            ),
          ),
          WBox(Get.width * 0.028),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dashStep(
                  delay: step,
                  child: Text(
                    'QuickLift',
                    style: AppTextStyle.regularTextStyle.copyWith(
                      color: AppColors.textBlackColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 21,
                      letterSpacing: -0.5,
                      height: 1.05,
                    ),
                  ),
                ),
                HBox(Get.height * 0.003),
                dashStep(
                  delay: Duration(milliseconds: step.inMilliseconds * 2),
                  child: Text(
                    'Docket tracking · Enquiry · Delivery',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.regularTextStyle.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 11.5,
                      color: AppColors.hintTextColor,
                      letterSpacing: 0.15,
                      height: 1.2,
                    ),
                  ),
                ),
              ],
            ),
          ),
          appBarLogoChip()
              .animate()
              .fadeIn(
            delay: Duration(milliseconds: step.inMilliseconds * 3),
            duration: 360.ms,
            curve: Curves.easeOutCubic,
          )
              .move(
            delay: Duration(milliseconds: step.inMilliseconds * 3),
            begin: const Offset(14, 0),
            end: Offset.zero,
            duration: 360.ms,
            curve: Curves.easeOutCubic,
          )
              .scale(
            delay: Duration(milliseconds: step.inMilliseconds * 3),
            begin: const Offset(0.88, 0.88),
            end: const Offset(1, 1),
            duration: 340.ms,
            curve: Curves.easeOutCubic,
          ),
        ],
      ),
    );
  }

  Widget appBarLogoChip() {
    return Container(
      padding: EdgeInsets.all(Get.height * 0.007),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.borderColor.withValues(alpha: 0.9),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.textBlackColor.withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Image.asset(
        AppImage.quickLiftLogoImage,
        height: Get.height * 0.036,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget heroCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderColor),
        boxShadow: [
          BoxShadow(
            color: AppColors.textBlackColor.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          AppImage.quickLift,
          fit: BoxFit.contain,
          height: Get.height * 0.22,
        ),
      ),
    );
  }

  Widget trackShipmentCard() {
    return Container(
      clipBehavior: Clip.antiAlias,
      padding: EdgeInsets.all(Get.width * 0.035),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.borderColor.withValues(alpha: 0.6),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.textBlackColor.withValues(alpha: 0.04),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Track shipment',
            style: AppTextStyle.regularTextStyle.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: AppColors.textBlackColor,
              letterSpacing: -0.35,
            ),
          ),
          HBox(Get.height * 0.006),
          Text(
            'Enter your docket code to see delivery status.',
            style: AppTextStyle.regularTextStyle.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 13,
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
          HBox(Get.height * 0.022),
          Text(
            'Docket code',
            style: AppTextStyle.regularTextStyle.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: AppColors.textBlackColor,
              letterSpacing: 0.15,
            ),
          ),
          HBox(Get.height * 0.01),
          Form(
            key: controller.formKey,
            autovalidateMode: controller.autoValidateMode.value,
            child: TextFField(
              focusNode: controller.fd,
              controller: controller.docketController,
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: Get.width * 0.02),
                child: Icon(
                  Icons.local_shipping_outlined,
                  color: AppColors.textSecondary.withValues(alpha: 0.9),
                  size: 22,
                ),
              ),
              validator: (p0) {
                if ((p0 ?? '').isEmpty) {
                  return 'Please Enter Docket Code...';
                }
                return null;
              },
              hintText: 'Enter docket code',
            ),
          ),
          HBox(Get.height * 0.028),
          CommonButton(
            onPressed: controller.validate,
            textVal: 'Track',
            bgColor: AppColors.primaryColor,
          ),
          HBox(Get.height * 0.012),
          CommonButton(
            onPressed: () => Get.toNamed(Routes.BIDDING_DASHBOARD),
            textVal: 'Enquiry',
            bgColor: AppColors.primaryColor.withValues(alpha: 0.12),
            style: AppTextStyle.regularTextStyle.copyWith(
              fontSize: 16,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

}
