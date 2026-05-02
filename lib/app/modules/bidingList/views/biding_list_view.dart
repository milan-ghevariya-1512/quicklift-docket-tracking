import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quicklift_docket_tracking/Reusability/utils/util.dart';

import '../../../../Reusability/utils/app_colors.dart';
import '../../../../Reusability/utils/app_images.dart';
import '../../../../Reusability/utils/app_textstyle.dart';
import '../../../../Reusability/widgets/common_shimmer.dart';
import '../../../../Reusability/widgets/common_widget.dart';
import '../../../data/model/getBiddingListModel.dart';
import '../../biddingDashboard/widgets/filterBottomSheet.dart';
import '../controllers/biding_list_controller.dart';

class BidingListView extends GetView<BidingListController> {
  BidingListView({super.key});

  final c = Get.put(BidingListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              HBox(MediaQuery.of(context).padding.top + Get.height * 0.015),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                child: AppPageHeader(
                  title: 'Bidding List',
                  onBack: () => Get.back(),
                  leading: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (ctx) => FilterBottomSheet(
                            biddingDashboardController: c.biddingDashboardController,
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        padding: EdgeInsets.all(Get.width * 0.028),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceColor,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: AppColors.borderColor),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.textBlackColor.withValues(alpha: 0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          AppImage.filterIcon,
                          height: Get.height * 0.024,
                          width: Get.height * 0.024,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                )
                    .animate()
                    .fadeIn(
                      duration: 200.ms,
                      curve: Curves.easeOutCubic,
                    )
                    .slideX(
                      begin: -0.02,
                      end: 0,
                      duration: 200.ms,
                      curve: Curves.easeOutCubic,
                    ),
              ),
              HBox(Get.height * 0.01),
              GetBuilder<BidingListController>(
                builder: (cm) {
                  return Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                          child: filterSummaryStrip(context),
                        ),
                        HBox(Get.height * 0.01),
                        Expanded(
                          child: Obx(
                            () => c.isRequestLoaded.value
                                ? BiddingListShimmer()
                                    .animate()
                                    .fadeIn(
                                      duration: 160.ms,
                                      curve: Curves.easeOut,
                                    )
                                : RefreshIndicator(
                                    color: AppColors.primaryColor,
                                    backgroundColor: AppColors.surfaceColor,
                                    displacement: 44,
                                    edgeOffset: 8,
                                    onRefresh: () => c.getBiddingList(isPullRefresh: true),
                                    child: c.vehicleRequestList.isEmpty
                                        ? emptyState(context)
                                        : SingleChildScrollView(
                                            controller: c.scrollController,
                                            physics: const AlwaysScrollableScrollPhysics(
                                              parent: BouncingScrollPhysics(),
                                            ),
                                            child: KeyedSubtree(
                                              key: const ValueKey('bidding_list_loaded'),
                                              child: Column(
                                                children: [
                                                  ListView.separated(
                                                    itemCount: c.vehicleRequestList.length,
                                                    shrinkWrap: true,
                                                    physics: const NeverScrollableScrollPhysics(),
                                                    padding: EdgeInsets.fromLTRB(Get.width * 0.05, Get.height * 0.004, Get.width * 0.05, 0,),
                                                    itemBuilder: (context, index) {
                                                      return vehicleRequestCard(
                                                        context,
                                                        c.vehicleRequestList[index],
                                                        index,
                                                      );
                                                    },
                                                    separatorBuilder: (_, __) => HBox(Get.height * 0.012),
                                                  ),
                                                  Obx(() => !c.isRequestLoaded.value && c.isLoadMore.value
                                                        ? Padding(
                                                            padding: EdgeInsets.symmetric(vertical: Get.height * 0.02,),
                                                            child: loadMoreFooter(context),
                                                          )
                                                        : const SizedBox.shrink(),
                                                  ),
                                                  HBox( MediaQuery.of(context).padding.bottom + Get.height * 0.02),
                                                ],
                                              )
                                                  .animate()
                                                  .fadeIn(
                                                    duration: 220.ms,
                                                    curve: Curves.easeOutCubic,
                                                  )
                                                  .slideY(
                                                    begin: 0.012,
                                                    end: 0,
                                                    duration: 220.ms,
                                                    curve: Curves.easeOutCubic,
                                                  ),
                                            ),
                                          ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget filterSummaryStrip(BuildContext context) {
    final dash = c.biddingDashboardController;
    final from = DateFormat('dd MMM yyyy').format(dash.startDate);
    final to = DateFormat('dd MMM yyyy').format(dash.endDate);
    final vr = dash.vrController.text.trim();
    final count = c.vehicleRequestList.length;
    final filterKey =
        '${dash.startDate.toIso8601String()}_${dash.endDate.toIso8601String()}_$vr';

    return KeyedSubtree(
      key: ValueKey(filterKey),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.035,
          vertical: Get.height * 0.014,
        ),
        decoration: BoxDecoration(
          color: AppColors.surfaceColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderColor),
          boxShadow: [
            BoxShadow(
              color: AppColors.textBlackColor.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(Get.height * 0.008),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.filter_list_rounded,
                size: 20,
                color: AppColors.primaryColor,
              ),
            ),
            WBox(Get.width * 0.03),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DATE RANGE',
                    style: AppTextStyle.regularTextStyle.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0,
                      color: AppColors.hintTextColor,
                      height: 1.2,
                    ),
                  ),
                  HBox(Get.height * 0.004),
                  Text(
                    '$from  →  $to',
                    style: AppTextStyle.regularTextStyle.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textBlackColor,
                      height: 1.25,
                    ),
                  ),
                  if (vr.isNotEmpty) ...[
                    HBox(Get.height * 0.008),
                    Text(
                      'VR search: $vr',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.regularTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (count > 0)
              Container(
                margin: EdgeInsets.only(left: Get.width * 0.02),
                padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.025,
                  vertical: Get.height * 0.006,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surfaceElevated,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.borderColor),
                ),
                child: Text(
                  '$count',
                  style: AppTextStyle.regularTextStyle.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textBlackColor,
                  ),
                ),
              ),
          ],
        ),
      )
          .animate()
          .fadeIn(
            duration: 180.ms,
            curve: Curves.easeOut,
          ),
    );
  }

  Widget emptyState(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HBox(Get.height * 0.06),
                  Container(
                    padding: EdgeInsets.all(Get.height * 0.028),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: 0.08),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.local_shipping_outlined,
                      size: 48,
                      color: AppColors.primaryColor.withValues(alpha: 0.85),
                    ),
                  ),
                  HBox(Get.height * 0.022),
                  Text(
                    'No vehicle requests',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.regularTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textBlackColor,
                      letterSpacing: -0.2,
                    ),
                  ),
                  HBox(Get.height * 0.01),
                  Text(
                    'Try another date range or clear the VR filter from the filter icon above.',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.regularTextStyle.copyWith(
                      fontSize: 13,
                      height: 1.45,
                      color: AppColors.hintTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  HBox(Get.height * 0.06),
                ],
              )
                  .animate()
                  .fadeIn(
                    duration: 200.ms,
                    curve: Curves.easeOutCubic,
                  )
                  .slideY(
                    begin: 0.014,
                    end: 0,
                    duration: 200.ms,
                    curve: Curves.easeOutCubic,
                  ),
            ),
          ),
        );
      },
    );
  }

  Widget loadMoreFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Utils.loader(),
        WBox(Get.width * 0.03),
        Text(
          'Loading more…',
          style: AppTextStyle.regularTextStyle.copyWith(
            fontSize: 13,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget sectionLabel(BuildContext context, String title, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(top: Get.height * 0.012, bottom: Get.height * 0.008),
      child: Row(
        children: [
          Icon(icon, size: 15, color: AppColors.primaryColor.withValues(alpha: 0.9)),
          WBox(Get.width * 0.02),
          Text(title.toUpperCase(), style: AppTextStyle.regularTextStyle.copyWith(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
            color: AppColors.primaryColor,
            height: 1.2,
          )),
        ],
      ),
    );
  }

  Widget vehicleRequestCard(BuildContext context, VehicleRequestsList data, int index) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.borderColor.withValues(alpha: 0.95),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.textBlackColor.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, 6),
              spreadRadius: -2,
            ),
            BoxShadow(
              color: AppColors.textBlackColor.withValues(alpha: 0.025),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(
                Get.width * 0.04,
                Get.height * 0.016,
                Get.width * 0.04,
                Get.height * 0.014,
              ),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.1),
                border: Border(
                  bottom: BorderSide(color: AppColors.borderColor.withValues(alpha: 0.7)),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('VR NUMBER', style: AppTextStyle.regularTextStyle.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.0,
                          color: AppColors.hintTextColor,
                          height: 1.2,
                        )),
                        HBox(Get.height * 0.006),
                        Text(
                          biddingStr(data.vrNumber),
                          style: AppTextStyle.regularTextStyle.copyWith(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textBlackColor,
                            letterSpacing: -0.3,
                            height: 1.15,
                          ),
                        ),
                        HBox(Get.height * 0.006),
                        Text(
                          'Manual no :- ${biddingStr(data.manualNo)}',
                          style: AppTextStyle.regularTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.028,
                      vertical: Get.height * 0.007,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceColor,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: AppColors.borderColor),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.textBlackColor.withValues(alpha: 0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      '#${index + 1}',
                      style: AppTextStyle.regularTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primaryColor,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                Get.width * 0.04,
                0,
                Get.width * 0.04,
                Get.height * 0.016,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sectionLabel(context, 'Schedule', Icons.event_available_outlined),
                  biddingDetailRow('Request date', biddingDateStr(data.requestDate)),
                  biddingDetailRow('Exp. loading', biddingDateStr(data.expLoadingDate)),
                  biddingDetailRow('Exp. delivery', biddingDateStr(data.expDeliveryTime)),
                  sectionLabel(context, 'Route', Icons.route_rounded),
                  HBox(Get.height * 0.006),
                  fromToLocationsSection(data),
                  sectionLabel(context, 'Documents', Icons.description_outlined),
                  biddingDetailRow('THC no.', biddingStr(data.thcNo)),
                  biddingDetailRow('Docket nos.', biddingStr(data.docketNos)),
                  sectionLabel(context, 'Material', Icons.inventory_2_outlined),
                  biddingDetailRow('Material type', biddingStr(data.materialType)),
                  biddingDetailRow('Packaging', biddingStr(data.packagingType)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget fromToLocationsSection(VehicleRequestsList data) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: Get.height * 0.004),
      padding: EdgeInsets.fromLTRB(
        Get.width * 0.028,
        Get.height * 0.014,
        Get.width * 0.032,
        Get.height * 0.014,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.9)),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TimelinePulseColumn(),
            WBox(Get.width * 0.032),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FROM',
                    style: AppTextStyle.regularTextStyle.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.9,
                      color: AppColors.hintTextColor,
                      height: 1.2,
                    ),
                  ),
                  HBox(Get.height * 0.004),
                  Text(
                    biddingStr(data.startPoint),
                    style: AppTextStyle.regularTextStyle.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textBlackColor,
                      height: 1.35,
                    ),
                  ),
                  HBox(Get.height * 0.014),
                  Text(
                    'TO',
                    style: AppTextStyle.regularTextStyle.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.9,
                      color: AppColors.hintTextColor,
                      height: 1.2,
                    ),
                  ),
                  HBox(Get.height * 0.004),
                  Text(
                    biddingStr(data.endPoint),
                    style: AppTextStyle.regularTextStyle.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textBlackColor,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget routeHighlight(VehicleRequestsList data) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: Get.height * 0.004),
      padding: EdgeInsets.symmetric(
        horizontal: Get.width * 0.032,
        vertical: Get.height * 0.014,
      ),
      decoration: BoxDecoration(
        color: AppColors.blueColor.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.blueColor.withValues(alpha: 0.18),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.place_outlined, size: 20, color: AppColors.blueColor),
          WBox(Get.width * 0.025),
          Expanded(
            child: Text(
              '${biddingStr(data.startPoint)}  →  ${biddingStr(data.endPoint)}',
              style: AppTextStyle.regularTextStyle.copyWith(
                color: AppColors.textBlackColor,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget biddingDetailRow(String label, String value, {bool isBold = false, Color? color}) {
    return Padding(
      padding: EdgeInsets.only(bottom: Get.height * 0.01),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 11,
            child: Text(
              label,
              style: AppTextStyle.regularTextStyle.copyWith(
                color: AppColors.hintTextColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                height: 1.3,
              ),
            ),
          ),
          Expanded(
            flex: 14,
            child: Text(
              value,
              style: AppTextStyle.regularTextStyle.copyWith(
                color: color ?? AppColors.textBlackColor,
                fontSize: 13,
                fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String biddingStr(String? v) {
    final s = v?.trim() ?? '';
    if (s.isEmpty || s == 'null') return '--';
    return s;
  }

  String biddingDateStr(String? v) {
    final s = v?.trim() ?? '';
    if (s.isEmpty || s == 'null') return '--';
    try {
      return DateFormat('dd/MM/yyyy · hh:mm a').format(DateTime.parse(s));
    } catch (_) {
      return s;
    }
  }
}

class TimelinePulseColumn extends StatefulWidget {
  const TimelinePulseColumn();

  @override
  State<TimelinePulseColumn> createState() => _TimelinePulseColumnState();
}

class _TimelinePulseColumnState extends State<TimelinePulseColumn> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1900),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final v = _controller.value;
        final wave = math.sin(v * math.pi * 2);
        final lineAlpha = 0.34 + 0.28 * v;
        return Column(
          children: [
            pulseDot(
              color: AppColors.primaryColor,
              icon: Icons.trip_origin_rounded,
              wave: wave,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: Get.height * 0.004),
                child: Center(
                  child: RepaintBoundary(
                    child: Container(
                      width: 3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryColor.withValues(alpha: 0.12 + 0.16 * v),
                            blurRadius: 3 + 5 * v,
                            spreadRadius: 0,
                          ),
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.primaryColor.withValues(alpha: lineAlpha),
                            Color.lerp(
                              AppColors.primaryColor,
                              AppColors.blueColor,
                              v,
                            )!.withValues(alpha: 0.52 + 0.12 * wave.abs()),
                            AppColors.blueColor.withValues(alpha: lineAlpha),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            pulseDot(
              color: AppColors.blueColor,
              icon: Icons.location_on_rounded,
              wave: -wave,
            ),
          ],
        );
      },
    );
  }

  Widget pulseDot({
    required Color color,
    required IconData icon,
    required double wave,
  }) {
    final scale = 1.0 + 0.065 * wave;
    return Transform.scale(
      scale: scale,
      child: Container(
        width: Get.height * 0.032,
        height: Get.height * 0.032,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.10 + 0.08 * wave.abs()),
          shape: BoxShape.circle,
          border: Border.all(
            color: color.withValues(alpha: 0.30 + 0.22 * (0.5 + 0.5 * wave)),
            width: 1.5,
          ),
        ),
        child: Icon(
          icon,
          size: Get.height * 0.016,
          color: color,
        ),
      ),
    );
  }
}
