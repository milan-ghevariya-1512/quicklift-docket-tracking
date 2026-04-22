import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../utils/app_colors.dart';
import '../utils/app_images.dart';
import '../utils/app_textstyle.dart';

class CommonWidget{

  static toast(String message){
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.greyColor.withOpacity(0.3),
      textColor: AppColors.textBlackColor,
      fontSize: 14,
    );
  }

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
  final Color? bColor;
  final Widget? child;
  const CommonButton(
      {super.key,
        this.onPressed,
        required this.textVal,
        this.style,
        this.btnRadius,
        this.btnHeight,
        this.btnWidth,
        this.bgColor,
        this.bColor,
        this.child,
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? () {},
      child: Container(
        height:btnHeight,
        width: btnWidth,
        padding: EdgeInsets.symmetric(vertical: Get.height*0.013,horizontal: Get.width*0.05),
        decoration: BoxDecoration(
          color: bgColor ?? AppColors.primaryColor,
          borderRadius: BorderRadius.circular(btnRadius ?? 6),
          border: Border.all(color: bColor ?? AppColors.primaryColor)
        ),
        child: Center(child: Text(textVal, style: style ?? AppTextStyle.regularTextStyle.copyWith(fontSize: 16,color: AppColors.whiteColor,fontWeight: FontWeight.w600))),
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
  final TextInputAction? textInputAction;

    const TextFField({
    this.hintText,
    this.prefixIcon,
    this.initialValue,
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
    this.maxLine,
    this.obscureText,
    this.onChanged,
    this.fillColor,
    this.onSaved,
    this.onEditingComplete,
    this.textInputAction,
    this.suffixIcon,this.suffixIconColor,this.validator,
    super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      focusNode: focusNode,
      maxLines: maxLine ?? 1,
      enabled: enabled,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: keyboardType,
      readOnly: readOnly ?? false,
      initialValue: initialValue,
      style: AppTextStyle.regularTextStyle.copyWith(overflow: TextOverflow.ellipsis,color:AppColors.textBlackColor,fontSize: 14,fontWeight:FontWeight.w500),
      controller: controller,
      onChanged: onChanged,
      onTap: onTap,
      inputFormatters: inputFormatters,
      onEditingComplete: onEditingComplete,
      obscureText: obscureText ?? false,
      validator: validator,
      onSaved: onSaved,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        counterText: "",
        filled: true,
        fillColor: fillColor ?? AppColors.backgroundColor,
        errorText: errorText,
        contentPadding: EdgeInsets.symmetric(
            vertical: Get.height * 0.01, horizontal: Get.width * 0.05),
        hintText: hintText,
        hintStyle: AppTextStyle.regularTextStyle.copyWith(color:AppColors.hintTextColor,fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(width: 1, color: AppColors.redColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(width: 1.5, color: AppColors.redColor),
        ),
        errorStyle: AppTextStyle.regularTextStyle.copyWith(color: AppColors.redColor),
        prefixIcon: prefixIcon ,
        prefixIconColor: AppColors.greyColor,
        prefixIconConstraints: BoxConstraints(
          maxHeight: Get.height * 0.045,
          maxWidth: Get.width * 0.2,
          minWidth: Get.width * 0.16,
        ),
        suffixIcon: suffixIcon,
        suffixIconColor:suffixIconColor ,
        suffixIconConstraints: BoxConstraints(
          maxHeight: Get.height * 0.052,
          maxWidth: Get.width * 0.2,
          minWidth: Get.width * 0.16,
        ),
        // suffixIcon: Icon(Icons.arrow_drop_down)
      ),
    );
  }
}

class NoData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Image.asset(AppImage.noDataImage,height: Get.height*0.07,width : Get.width,color: AppColors.textBlackColor),

        HBox(Get.height*0.01),

        Text("No Data",style: AppTextStyle.regularTextStyle.copyWith(fontSize: 15,color: AppColors.greyColor,fontWeight: FontWeight.w600)),

        HBox(Get.height*0.005),

        Text("Data has not been recorded for this section",textAlign: TextAlign.center,
            style: AppTextStyle.regularTextStyle.copyWith(fontSize: 12,color: AppColors.greyColor.withOpacity(0.9))),
      ],
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









