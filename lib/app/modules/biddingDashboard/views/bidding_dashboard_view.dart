import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../../../../Reusability/utils/app_colors.dart';
import '../../../../Reusability/utils/app_images.dart';
import '../../../../Reusability/utils/app_textstyle.dart';
import '../../../../Reusability/widgets/common_shimmer.dart';
import '../../../../Reusability/widgets/common_widget.dart';
import '../../../routes/app_pages.dart';
import '../../../data/model/getBiddingListModel.dart';
import '../controllers/bidding_dashboard_controller.dart';
import '../widgets/filterBottomSheet.dart';

class BiddingDashboardView extends GetView<BiddingDashboardController> {
  BiddingDashboardView({super.key});

  final c = Get.put(BiddingDashboardController());

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
                  title: "Bidding Dashboard",
                  onBack: () => Get.back(),
                  leading: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => FilterBottomSheet(biddingDashboardController: c),
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
              HBox(Get.height * 0.015),
              Expanded(
                child: Obx(
                  () => c.isLoaded.value
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                          child: HomeCardsShimmer()
                              .animate()
                              .fadeIn(
                                duration: 160.ms,
                                curve: Curves.easeOut,
                              ),
                        )
                      : cardsGrid(context),
                ),
              ),
            ],
          )
        ],
      ),
      floatingActionButton: buildAddFab()
          .animate()
          .fadeIn(
            duration: 220.ms,
            curve: Curves.easeOutCubic,
          )
          .scale(
            begin: const Offset(0.94, 0.94),
            end: const Offset(1, 1),
            duration: 220.ms,
            curve: Curves.easeOutCubic,
          ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget buildAddFab() {
    final radius = BorderRadius.circular(18);
    return Container(
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withValues(alpha: 0.38),
            blurRadius: 18,
            offset: const Offset(0, 8),
            spreadRadius: -2,
          ),
          BoxShadow(
            color: AppColors.textBlackColor.withValues(alpha: 0.07),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: AppColors.primaryColor,
        borderRadius: radius,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () async {
            var result = await Get.toNamed(Routes.VEHICLE_REQUEST);
            if(result != null && result){
              await c.getBiddingList();
            }
          },
          splashColor: Colors.white.withValues(alpha: 0.2),
          highlightColor: Colors.white.withValues(alpha: 0.08),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.055,
              vertical: Get.height * 0.017,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                  size: Get.height * 0.03,
                ),
                WBox(Get.width * 0.022),
                Text(
                  'New request',
                  style: AppTextStyle.regularTextStyle.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    letterSpacing: 0.15,
                    height: 1.1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static String labelForCountField(String fieldName) {
    var base = fieldName.endsWith('Count') ? fieldName.substring(0, fieldName.length - 5) : fieldName;
    final parts = base.split(RegExp(r'(?=[A-Z])')).where((p) => p.isNotEmpty);
    return parts.map((word) => '${word.substring(0, 1).toUpperCase()}${word.substring(1).toLowerCase()}').join(' ');
  }

  static String countStr(String? v) {
    if (v == null) return '0';
    final t = v.trim();
    return t.isEmpty ? '0' : t;
  }

  List<({String status, String label, String count, IconData icon, Color color})> statusItems(VehicleRequestCounts? v) {
    final specs = <(String field, String Function(VehicleRequestCounts?) pick)>[
      ('totalCount', (c) => countStr(c?.totalCount)),
      ('generatedCount', (c) => countStr(c?.generatedCount)),
      ('inProcessCount', (c) => countStr(c?.inProcessCount)),
      ('tripGeneratedCount', (c) => countStr(c?.tripGeneratedCount)),
      ('tripCancelledCount', (c) => countStr(c?.tripCancelledCount)),
      ('tripCompletedCount', (c) => countStr(c?.tripCompletedCount)),
    ];
    final statuses = <(String field, String code)>[
      ('totalCount', ''),
      ('generatedCount', 'BAR'),
      ('inProcessCount', 'AN6'),
      ('tripGeneratedCount', 'ANC'),
      ('tripCancelledCount', 'AND'),
      ('tripCompletedCount', 'ANA'),
    ];

    final visuals = [
      (Icons.folder_copy_outlined, const Color(0xFF0284C7)),
      (Icons.add_circle_outline_rounded, AppColors.primaryColor),
      (Icons.pending_actions_outlined, const Color(0xFFF59E0B)),
      (Icons.local_shipping_outlined, const Color(0xFF6366F1)),
      (Icons.cancel_outlined, AppColors.redColor),
      (Icons.check_circle_outline_rounded, AppColors.greenColor),
    ];
    return [
      for (var i = 0; i < specs.length; i++)
        (
          label: labelForCountField(specs[i].$1),
          count: specs[i].$2(v),
          icon: visuals[i].$1,
          color: visuals[i].$2,
          status: statuses[i].$2,
        ),
    ];
  }

  Widget buildStatusCard(item) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.BIDING_LIST, arguments: [item.status ?? '']);
      },
      child: Container(
        height: Get.height * 0.16,
        padding: EdgeInsets.fromLTRB(
          Get.width * 0.045,
          Get.height * 0.018,
          Get.width * 0.038,
          Get.height * 0.016,
        ),
        decoration: BoxDecoration(
          color: AppColors.surfaceColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.borderColor),
          boxShadow: [
            BoxShadow(
              color: AppColors.textBlackColor.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              item.label,
              style: AppTextStyle.regularTextStyle.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.textBlackColor,
                height: 1.3,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            HBox(Get.height * 0.005),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  item.count,
                  style: AppTextStyle.regularTextStyle.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textBlackColor,
                    height: 1.0,
                  ),
                ),
                const Spacer(),
                Container(
                  width: Get.height * 0.06,
                  height: Get.height * 0.06,
                  decoration: BoxDecoration(
                    color: item.color.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    item.icon,
                    size: 22,
                    color: item.color,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget cardsGrid(BuildContext context) {
    final list = statusItems(c.vehicleRequestCounts);
    final rowCount = (list.length + 1) ~/ 2;
    return RefreshIndicator(
      onRefresh: () => c.getBiddingList(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
          child: KeyedSubtree(
            key: const ValueKey('bidding_dashboard_grid'),
            child: Column(
              children: [
                for (int row = 0; row < rowCount; row++) ...[
                  if (row > 0) HBox(Get.height * 0.015),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: buildStatusCard(list[row * 2])),
                      if (row * 2 + 1 < list.length) ...[
                        WBox(Get.width * 0.035),
                        Expanded(child: buildStatusCard(list[row * 2 + 1])),
                      ] else
                        Expanded(child: Container()),
                    ],
                  ),
                ],
                HBox(MediaQuery.of(context).padding.bottom + Get.height * 0.02),
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
    );
  }
}
