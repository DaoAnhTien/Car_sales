import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';

class CustomTextField extends StatelessWidget {
  final String? title;
  final TextAlign? textAlign;
  final int? maxLines;
  final int? maxLength;
  final int? fixedLines;
  final bool? softWrap;
  final EdgeInsetsGeometry? outsidePadding;
  final EdgeInsetsGeometry? innerPadding;
  final TextEditingController? controller;
  final String? errorMsg;
  final String? hintText;
  final Color? hintColor;
  final bool? isAutoFocus;
  final double? width;
  final double? height;
  final String? borderRadiusEdge;
  final FocusNode? focusNode;
  final bool? isIgnorePointer;
  final ValueChanged<String>? onChanged;
  final double? blurRadius;
  final double? radius;
  final Function? onSubmitted;
  final TextInputType? textInputType;
  final bool? enabled;
  final bool? obscureText;
  final double? letterSpacing;
  final List<TextInputFormatter>? inputFormatter;
  final Widget? preIcon;
  final Widget? postIcon;
  final List<String>? autoFillHints;
  final Function? onTab;
  final bool? enableFocusBorder;
  final bool? filled;
  final Color? fillColor;
  final Widget? suffix;
  final GestureTapCallback? onTabSuffix;
  final String? labelText;

  CustomTextField(
      {this.title,
      this.textAlign = TextAlign.left,
      this.hintText = '',
      this.errorMsg,
      this.hintColor,
      this.maxLines = 1,
      this.maxLength,
      this.fixedLines,
      this.softWrap = true,
      this.isAutoFocus = false,
      this.controller,
      this.textInputType = TextInputType.text,
      this.width = 150,
      this.height,
      this.borderRadiusEdge = '',
      this.focusNode,
      this.isIgnorePointer = false,
      this.onChanged,
      this.onSubmitted,
      this.radius = 25,
      this.blurRadius = 0,
      this.enabled = true,
      this.letterSpacing,
      this.inputFormatter,
      this.obscureText = false,
      this.preIcon,
      this.postIcon,
      this.innerPadding =
          const EdgeInsets.only(top: 8, bottom: 8, left: 20, right: 20),
      this.outsidePadding =
          const EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
      this.autoFillHints,
      this.onTab,
      this.enableFocusBorder = true,
      this.filled = true,
      this.fillColor,
      this.suffix,
      this.onTabSuffix,
      this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      // onSubmitted: (_) => FocusScope.of(context).nextFocus(),
      // textInputAction: textInputType,
      keyboardType: textInputType,
      controller: controller,
      style: Style().subtitleStyle1,
      onChanged: onChanged,
      obscureText: obscureText!,
      decoration: InputDecoration(
        // errorText: errorMsg,
        suffixIcon: suffix != null
            ? GestureDetector(
                // behavior: HitTestBehavior.translucent,
                child: suffix,
                onTap: onTabSuffix,
              )
            : null,
        labelText: labelText,
        labelStyle: TextStyle(
            color: Get.textTheme.headline1!.color,
            fontFamily: Style.fontRegular,
            fontSize: 14.sp),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: (enableFocusBorder ?? false)
                  ? context.theme.primaryColorLight
                  : context.theme.hintColor),
        ),
        errorBorder: errorMsg != null
            ? UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              )
            : null,
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: context.theme.hintColor)),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        contentPadding: EdgeInsets.only(bottom: 0),
        isDense: true,
        border: InputBorder.none,
        hintStyle: TextStyle(
            color: hintColor, fontFamily: Style.fontRegular, fontSize: 16.sp),
      ),
    );
  }
}
