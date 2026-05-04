import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

enum TrackConnectorMode { disabled, progressing, complete }

class AnimatedTrackConnectorLine extends StatefulWidget {
  const AnimatedTrackConnectorLine({
    super.key,
    required this.mode,
    this.axis = Axis.horizontal,
    this.extent = 6,
    this.duration = const Duration(milliseconds: 1000),
    this.lightColor,
    this.darkColor,
    this.disabledColor,
  });

  final TrackConnectorMode mode;
  final Axis axis;

  final double extent;
  final Duration duration;

  final Color? lightColor;
  final Color? darkColor;
  final Color? disabledColor;

  @override
  State<AnimatedTrackConnectorLine> createState() => _AnimatedTrackConnectorLineState();
}

class _AnimatedTrackConnectorLineState extends State<AnimatedTrackConnectorLine> with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  Color get light => widget.lightColor ?? const Color(0xFFB8EBCA);
  Color get dark => widget.darkColor ?? AppColors.primaryColor;
  Color get disabled => widget.disabledColor ?? const Color(0xFFB8EBCA).withValues(alpha: 0.5);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: widget.duration);
    if (widget.mode == TrackConnectorMode.progressing) {
      controller.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedTrackConnectorLine oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.duration != widget.duration) {
      controller.duration = widget.duration;
    }

    if (widget.mode == TrackConnectorMode.progressing) {
      if (!controller.isAnimating) controller.repeat();
    } else {
      controller.stop();
      controller.reset();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isVertical = widget.axis == Axis.vertical;
    return ClipRect(
      child: isVertical
          ? SizedBox(
              width: widget.extent,
              height: double.infinity,
              child: buildBody(),
            )
          : SizedBox(
              height: widget.extent,
              width: double.infinity,
              child: buildBody(),
            ),
    );
  }

  Widget buildBody() {
    switch (widget.mode) {
      case TrackConnectorMode.disabled:
        return Container(color: disabled);

      case TrackConnectorMode.complete:
        return Container(color: dark);

      case TrackConnectorMode.progressing:
        return AnimatedBuilder(
          animation: controller,
          builder: (_, __) {
            return CustomPaint(
              painter: TrackDotsPainter(
                t: controller.value,
                light: light,
                dark: dark,
                axis: widget.axis,
              ),
            );
          },
        );
    }
  }
}

class TrackDotsPainter extends CustomPainter {
  TrackDotsPainter({
    required this.t,
    required this.light,
    required this.dark,
    required this.axis,
  });

  final double t;
  final Color light;
  final Color dark;
  final Axis axis;

  static const double spacing = 10;
  static const double radius = 3;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    final shift = t * spacing;

    if (axis == Axis.horizontal) {
      final startX = -spacing + shift;
      final totalDots = (size.width / spacing).ceil() + 2;

      for (var i = 0; i < totalDots; i++) {
        final dx = startX + (i * spacing);

        if (dx < -spacing || dx > size.width + spacing) continue;

        final progress = dx / size.width;
        final intensity = ((0.5 - (progress - 0.5).abs()).clamp(0.0, 0.5) * 2);
        paint.color = Color.lerp(light, dark, intensity)!;

        canvas.drawCircle(
          Offset(dx, size.height / 2),
          radius,
          paint,
        );
      }
    } else {
      final startY = -spacing + shift;
      final totalDots = (size.height / spacing).ceil() + 2;

      for (var i = 0; i < totalDots; i++) {
        final dy = startY + (i * spacing);

        if (dy < -spacing || dy > size.height + spacing) continue;

        final progress = dy / size.height;
        final intensity = ((0.5 - (progress - 0.5).abs()).clamp(0.0, 0.5) * 2);
        paint.color = Color.lerp(light, dark, intensity)!;

        canvas.drawCircle(
          Offset(size.width / 2, dy),
          radius,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant TrackDotsPainter oldDelegate) {
    return oldDelegate.t != t ||
        oldDelegate.light != light ||
        oldDelegate.dark != dark ||
        oldDelegate.axis != axis;
  }
}
