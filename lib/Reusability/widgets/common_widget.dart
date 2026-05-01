import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../utils/app_colors.dart';
import '../utils/app_images.dart';
import '../utils/app_textstyle.dart';

class CommonWidget{

}

class AppPageHeader extends StatelessWidget {
  final String title;
  final Widget? leading;
  final VoidCallback? onBack;

  const AppPageHeader({super.key, required this.title, this.onBack, this.leading});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (onBack != null)
          GestureDetector(
            onTap: onBack,
            child: Container(
              height: Get.height * 0.046,
              width: Get.height * 0.046,
              decoration: BoxDecoration(
                color: AppColors.surfaceColor,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.borderColor),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.textBlackColor.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Image.asset(
                AppImage.backIcon,
                height: Get.height * 0.024,
                width: Get.height * 0.024,
                fit: BoxFit.contain,
              ),
            ),
          ),
        if (onBack != null) WBox(Get.width * 0.03),
        Expanded(
          child: Text(
            title,
            maxLines: 1, overflow: TextOverflow.ellipsis,
            style: AppTextStyle.regularTextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w700, letterSpacing: -0.3, height: 1.3),
          ),
        ),
        if (leading != null) WBox(Get.width * 0.03),
        if (leading != null) leading ?? SizedBox.shrink()
      ],
    );
  }
}

class HBox extends StatelessWidget {
  final double? height;
  HBox(this.height, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}

class WBox extends StatelessWidget {
  final double? width;
  WBox(this.width, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}

class CommonButton extends StatelessWidget {
  final Function()? onPressed;
  final String textVal;
  final double? btnHeight;
  final double? btnWidth;
  final double? btnRadius;
  final TextStyle? style;
  final Color? bgColor;
  final Widget? child;
  CommonButton({
    super.key,
    this.onPressed,
    this.bgColor,
    required this.textVal,
    this.style,
    this.btnRadius,
    this.btnHeight,
    this.btnWidth,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? () {},
      child: Container(
        height: btnHeight ?? Get.height * 0.058,
        width: btnWidth ?? Get.width,
        decoration: BoxDecoration(
          color: bgColor ?? AppColors.primaryColor,
          borderRadius: BorderRadius.circular(btnRadius ?? 30),
          boxShadow: [
            if (bgColor == null || bgColor == AppColors.primaryColor)
              BoxShadow(
                color: AppColors.primaryColor.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Center(
          child: Text(
            textVal.tr,
            style: style ?? AppTextStyle.regularTextStyle.copyWith(fontSize: 15, fontWeight: FontWeight.w700, letterSpacing: 0.5, color: AppColors.whiteColor),
          ),
        ),
      ),
    );
  }
}

class TextFField extends StatelessWidget {
  final String? hintText;
  final Widget? prefixIcon;
  final String? initialValue;
  final String? errorText;
  final IconData? icon;
  final bool? readOnly;
  final bool? obscureText;
  final bool? enabled;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final Function()? onEditingComplete;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Color? suffixIconColor;
  final Color? fillColor;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final int? maxLength;
  final int? maxLine;
  final double? radius;
  final EdgeInsetsGeometry? margin;
  final TextInputAction? textInputAction;

  const TextFField(
      {this.hintText,
        this.maxLine,
        this.prefixIcon,
        this.initialValue,
        this.margin,
        this.readOnly,
        this.onTap,
        this.controller,
        this.icon,
        this.enabled,
        this.errorText,
        this.focusNode,
        this.inputFormatters,
        this.keyboardType,
        this.maxLength,
        this.obscureText,
        this.onChanged,
        this.fillColor,
        this.radius,
        this.onSaved,
        this.onEditingComplete,
        this.textInputAction,
        this.suffixIcon,
        this.suffixIconColor,
        this.validator,
        super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      focusNode: focusNode,
      enabled: enabled,
      maxLines: maxLine ?? 1,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: keyboardType,
      readOnly: readOnly ?? false,
      initialValue: initialValue,
      style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor, fontSize: 14, fontWeight: FontWeight.w500),
      controller: controller,
      onChanged: onChanged,
      onTap: onTap,
      inputFormatters: inputFormatters,
      onEditingComplete: onEditingComplete,
      obscureText: obscureText ?? false,
      validator: validator,
      onSaved: onSaved,
      obscuringCharacter: "*",
      textInputAction: textInputAction,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      decoration: InputDecoration(
        counterText: "",
        filled: true,
        fillColor: fillColor ?? AppColors.whiteColor,
        errorText: errorText,
        contentPadding: EdgeInsets.symmetric(vertical: Get.height * 0.018, horizontal: Get.width * 0.04),
        hintText: hintText,
        hintStyle: AppTextStyle.regularTextStyle.copyWith(color: AppColors.hintTextColor, fontSize: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(radius ?? 30), borderSide: BorderSide(color: AppColors.hintTextColor)),
        disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(radius ?? 30), borderSide: BorderSide(color: AppColors.borderColor)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(radius ?? 30), borderSide: BorderSide(color: AppColors.borderColor)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(radius ?? 30), borderSide: BorderSide(color: AppColors.borderColor)),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 30),
          borderSide: const BorderSide(width: 1, color: AppColors.redColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 30),
          borderSide: const BorderSide(width: 1, color: AppColors.redColor),
        ),
        errorStyle: AppTextStyle.regularTextStyle.copyWith(color: AppColors.redColor, fontSize: 12),
        prefixIcon: prefixIcon,
        prefixIconColor: AppColors.hintTextColor,
        prefixIconConstraints: BoxConstraints(
          maxHeight: Get.height * 0.04,
          maxWidth: Get.width * 0.16,
          minWidth: Get.width * 0.14,
        ),
        suffixIcon: suffixIcon,
        suffixIconColor: suffixIconColor,
        suffixIconConstraints: BoxConstraints(
          maxHeight: Get.height * 0.055,
          maxWidth: Get.width * 0.1,
          minWidth: Get.width * 0.1,
        ),
        // suffixIcon: Icon(Icons.arrow_drop_down)
      ),
    );
  }
}

class NoData extends StatelessWidget {
  final String? title;

  const NoData({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1, vertical: Get.height * 0.04),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.inbox_outlined, size: 56, color: AppColors.hintTextColor.withOpacity(0.5)),
            HBox(Get.height * 0.02),
            Text(
              (title ?? "Not Found"),
              textAlign: TextAlign.center,
              style: AppTextStyle.regularTextStyle.copyWith(fontSize: 13, height: 1.4, color: AppColors.hintTextColor, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

class ToastWidget extends StatefulWidget {
  final String message;
  final Color backgroundColor;
  final VoidCallback onDismiss;

  const ToastWidget({
    super.key,
    required this.message,
    required this.backgroundColor,
    required this.onDismiss,
  });

  @override
  State<ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<ToastWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();

    Future.delayed(const Duration(seconds: 2), () async {
      if (!mounted || _controller.status == AnimationStatus.dismissed) return;

      try {
        await _controller.reverse();
        if (mounted) {
          widget.onDismiss();
        }
      } catch (e) {
        debugPrint('Toast reverse error: $e');
      }
    });
  }

  @override
  void dispose() {
    if (_controller.isAnimating) {
      _controller.stop();
    }
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      left: 16,
      right: 16,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Dismissible(
            key: const ValueKey("toast_widget"),
            direction: DismissDirection.up,
            onDismissed: (_) {
              if (mounted) {
                widget.onDismiss();
              }
            },
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                decoration: BoxDecoration(
                  color: widget.backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Text(
                  widget.message,
                  style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.whiteColor),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DropdownTextField<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final String Function(T) itemLabel;
  final ValueChanged<T?> onChanged;
  final String? hintText;
  final String? Function(T?)? validator;
  final bool enabled;
  final AutovalidateMode autovalidateMode;

  const DropdownTextField({
    super.key,
    required this.value,
    required this.items,
    required this.itemLabel,
    required this.onChanged,
    this.hintText,
    this.validator,
    this.enabled = true,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      autovalidateMode: autovalidateMode,
      validator: validator,
      isExpanded: true,
      borderRadius: BorderRadius.circular(20),
      menuMaxHeight: Get.height * 0.5,
      value: value,
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        color: AppColors.textBlackColor,
      ),
      style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.hintTextColor, fontSize: 14),
      hint: Text(
        hintText ?? '',
        style: AppTextStyle.regularTextStyle.copyWith(
          color: items.isEmpty ? AppColors.borderColor : AppColors.hintTextColor,
          fontSize: 14,
        ),
      ),
      decoration: InputDecoration(
        counterText: "",
        filled: true,
        fillColor: AppColors.whiteColor,
        contentPadding: EdgeInsets.symmetric(vertical: Get.height * 0.018, horizontal: Get.width * 0.04),
        hintText: hintText,
        hintStyle: AppTextStyle.regularTextStyle.copyWith(color: AppColors.hintTextColor, fontSize: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: AppColors.hintTextColor)),
        disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: AppColors.borderColor)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: AppColors.borderColor)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: AppColors.borderColor)),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(width: 1, color: AppColors.redColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(width: 1, color: AppColors.redColor),
        ),
        errorStyle: AppTextStyle.regularTextStyle.copyWith(color: AppColors.redColor, fontSize: 12),
      ),
      onChanged: enabled ? onChanged : null,
      items: items.map((option) {
        return DropdownMenuItem<T>(
          value: option,
          child: Text(
            itemLabel(option),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor, fontSize: 14, fontWeight: FontWeight.w500),
          ),
        );
      }).toList(),
    );
  }
}

class FieldScrollWrapper extends StatefulWidget {
  final Widget child;
  const FieldScrollWrapper({super.key, required this.child});

  @override
  State<FieldScrollWrapper> createState() => _FieldScrollWrapperState();
}

class _FieldScrollWrapperState extends State<FieldScrollWrapper> {

  void _scrollToField(BuildContext ctx) {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;

      Scrollable.ensureVisible(
        ctx,
        alignment: 0.1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.linear,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (ctx) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => _scrollToField(ctx),
          child: Focus(
            onFocusChange: (hasFocus) {
              if (hasFocus) {
                _scrollToField(ctx);
              }
            },
            child: widget.child,
          ),
        );
      },
    );
  }
}

class CommonDivider extends StatelessWidget {

  const CommonDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: AppColors.borderColor,
    );
  }
}







