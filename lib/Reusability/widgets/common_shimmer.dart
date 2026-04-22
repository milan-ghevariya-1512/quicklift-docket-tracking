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
            borderRadius: 30,
            color: AppColors.shimmerBaseDark,
          ),
        ],
      ),
    );
  }
}
