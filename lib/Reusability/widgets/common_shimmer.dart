import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../utils/app_colors.dart';
import 'common_widget.dart';

class CommonShimmer extends StatelessWidget {
  final Widget child;
  final Duration? duration;
  final Color? color;
  final double? colorOpacity;
  final bool enabled;

  const CommonShimmer({
    super.key,
    required this.child,
    this.duration,
    this.color,
    this.colorOpacity,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: duration ?? const Duration(milliseconds: 1800),
      color: color ?? AppColors.whiteColor,
      colorOpacity: colorOpacity ?? 0.45,
      enabled: enabled,
      child: child,
    );
  }
}

class ShimmerBox extends StatelessWidget {
  final double? width;
  final double? height;
  final double borderRadius;
  final Color? color;

  const ShimmerBox({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 8,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color ?? AppColors.shimmerBase,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}

class FormShimmer extends StatelessWidget {
  const FormShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonShimmer(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HBox(Get.height * 0.01),
            ...List.generate(8, (_) => _shimmerFieldRow()),
            HBox(Get.height * 0.15),
          ],
        ),
      ),
    );
  }

  Widget _shimmerFieldRow() {
    return Padding(
      padding: EdgeInsets.only(bottom: Get.height * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerBox(
            width: Get.width * 0.25,
            height: 12,
            borderRadius: 4,
            color: AppColors.shimmerBaseDark,
          ),
          HBox(Get.height * 0.01),
          ShimmerBox(
            width: double.infinity,
            height: Get.height * 0.058,
            borderRadius: 14,
            color: AppColors.shimmerBaseDark,
          ),
        ],
      ),
    );
  }
}

class HomeCardsShimmer extends StatelessWidget {
  const HomeCardsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonShimmer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.15,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: _shimmerCard()),
                  WBox(Get.height * 0.015),
                  Expanded(child: _shimmerCard()),
                ],
              ),
            ),
            HBox(Get.height * 0.015),
            SizedBox(
              height: Get.height * 0.15,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: _shimmerCard()),
                  WBox(Get.height * 0.015),
                  Expanded(child: _shimmerCard()),
                ],
              ),
            ),
            HBox(Get.height * 0.015),
            SizedBox(
              height: Get.height * 0.15,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: _shimmerCard()),
                  WBox(Get.height * 0.015),
                  Expanded(child: _shimmerCard()),
                ],
              ),
            ),
            HBox(MediaQuery.of(context).padding.bottom + Get.height * 0.06),
          ],
        ),
      ),
    );
  }

  Widget _shimmerCard() {
    return Container(
      height: Get.height * 0.15,
      padding: EdgeInsets.fromLTRB(
        Get.width * 0.045,
        Get.height * 0.018,
        Get.width * 0.038,
        Get.height * 0.016,
      ),
      decoration: BoxDecoration(
        color: AppColors.shimmerBase,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderColor),
        boxShadow: [
          BoxShadow(
            color: AppColors.textBlackColor.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ShimmerBox(
            width: Get.width * 0.35,
            height: 14,
            borderRadius: 4,
            color: AppColors.shimmerBaseDark,
          ),
          const Spacer(),
          HBox(Get.height * 0.005),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ShimmerBox(
                width: 48,
                height: 28,
                borderRadius: 4,
                color: AppColors.shimmerBaseDark,
              ),
              const Spacer(),
              Container(
                width: Get.height * 0.06,
                height: Get.height * 0.06,
                decoration: BoxDecoration(
                  color: AppColors.shimmerBaseDark.withOpacity(0.4),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BiddingListShimmer extends StatelessWidget {
  const BiddingListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonShimmer(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(
          Get.width * 0.05,
          Get.height * 0.004,
          Get.width * 0.05,
          0,
        ),
        child: Column(
          children: [
            for (int i = 0; i < 4; i++) ...[
              if (i > 0) HBox(Get.height * 0.012),
              _listCardSkeleton(),
            ],
            HBox(Get.height * 0.06),
          ],
        ),
      ),
    );
  }

  Widget _listCardSkeleton() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.borderColor.withValues(alpha: 0.95),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.textBlackColor.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 4),
            spreadRadius: -2,
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(
              Get.width * 0.04,
              Get.height * 0.016,
              Get.width * 0.04,
              Get.height * 0.014,
            ),
            decoration: BoxDecoration(
              color: AppColors.shimmerBase,
              border: Border(
                bottom: BorderSide(
                  color: AppColors.borderColor.withValues(alpha: 0.7),
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerBox(
                        width: Get.width * 0.18,
                        height: 10,
                        borderRadius: 4,
                        color: AppColors.shimmerBaseDark,
                      ),
                      HBox(Get.height * 0.008),
                      ShimmerBox(
                        width: Get.width * 0.42,
                        height: 18,
                        borderRadius: 6,
                        color: AppColors.shimmerBaseDark,
                      ),
                      HBox(Get.height * 0.008),
                      ShimmerBox(
                        width: Get.width * 0.5,
                        height: 12,
                        borderRadius: 4,
                        color: AppColors.shimmerBaseDark,
                      ),
                    ],
                  ),
                ),
                ShimmerBox(
                  width: Get.width * 0.14,
                  height: Get.height * 0.034,
                  borderRadius: 22,
                  color: AppColors.shimmerBaseDark,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              Get.width * 0.04,
              Get.height * 0.014,
              Get.width * 0.04,
              Get.height * 0.016,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerBox(
                  width: Get.width * 0.22,
                  height: 10,
                  borderRadius: 4,
                  color: AppColors.shimmerBaseDark,
                ),
                HBox(Get.height * 0.012),
                ShimmerBox(
                  width: double.infinity,
                  height: 12,
                  borderRadius: 6,
                  color: AppColors.shimmerBaseDark,
                ),
                HBox(Get.height * 0.01),
                ShimmerBox(
                  width: Get.width * 0.72,
                  height: 12,
                  borderRadius: 6,
                  color: AppColors.shimmerBaseDark,
                ),
                HBox(Get.height * 0.01),
                ShimmerBox(
                  width: Get.width * 0.55,
                  height: 12,
                  borderRadius: 6,
                  color: AppColors.shimmerBaseDark,
                ),
                HBox(Get.height * 0.014),
                ShimmerBox(
                  width: Get.width * 0.28,
                  height: 10,
                  borderRadius: 4,
                  color: AppColors.shimmerBaseDark,
                ),
                HBox(Get.height * 0.01),
                ShimmerBox(
                  width: double.infinity,
                  height: Get.height * 0.05,
                  borderRadius: 12,
                  color: AppColors.shimmerBaseDark,
                ),
                HBox(Get.height * 0.012),
                ShimmerBox(
                  width: double.infinity,
                  height: 12,
                  borderRadius: 6,
                  color: AppColors.shimmerBaseDark,
                ),
                HBox(Get.height * 0.008),
                ShimmerBox(
                  width: Get.width * 0.65,
                  height: 12,
                  borderRadius: 6,
                  color: AppColors.shimmerBaseDark,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}