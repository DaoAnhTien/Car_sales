import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/constants/app_constant.dart';
import 'package:oke_car_flutter/utils/object_util.dart';
import 'package:oke_car_flutter/values/style.dart';

class RadiusTextField extends StatelessWidget {
  final double? fontSize;
  final TextAlign? textAlign;
  final String? fontFamily;
  final Color? bgColor;
  final Color? textColor;
  final Color? shadowColor;
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

  RadiusTextField({
    this.fontSize = 14,
    this.textAlign = TextAlign.left,
    this.fontFamily = Style.fontRegular,
    this.hintText = '',
    this.errorMsg,
    this.hintColor,
    this.maxLines = 1,
    this.maxLength,
    this.fixedLines,
    this.softWrap = true,
    this.bgColor = Style.btnDefaultBgColor,
    this.textColor = Style.textDefaultColor,
    this.shadowColor = Style.transparent,
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
    this.enableFocusBorder = false,
    this.filled = false,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: outsidePadding!,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: borderRadiusEdge == BORDER_LEFT
                ? BorderRadius.only(
                    topLeft: Radius.circular(radius!),
                    bottomLeft: Radius.circular(radius!))
                : borderRadiusEdge == BORDER_RIGHT
                    ? BorderRadius.only(
                        topRight: Radius.circular(radius!),
                        bottomRight: Radius.circular(radius!))
                    : BorderRadius.circular(radius!),
            color: bgColor,
            boxShadow: [
              BoxShadow(color: shadowColor!, blurRadius: blurRadius!)
            ],
          ),
          child: isIgnorePointer!
              ? IgnorePointer(
                  child: Center(
                  child: TextField(
                    autofillHints: autoFillHints,
                    focusNode: focusNode,
                    cursorColor: textColor,
                    autofocus: isAutoFocus!,
                    textAlign: textAlign!,
                    controller: controller,
                    onChanged: onChanged,
                    keyboardType: textInputType,
                    maxLength: maxLength,
                    maxLines: maxLines,
                    minLines: 1,
                    obscureText: obscureText!,
                    decoration: InputDecoration(
                        hintText: hintText,
                        hintStyle: TextStyle(
                            fontSize: fontSize,
                            color: hintColor,
                            letterSpacing: letterSpacing),
                        errorText: errorMsg,
                        border: InputBorder.none,
                        focusedBorder: (enableFocusBorder ?? false)
                            ? OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: context.theme.highlightColor,
                                    width: 2.0),
                                borderRadius: BorderRadius.circular(radius!),
                              )
                            : null,
                        filled: filled,
                        fillColor: fillColor,
                        contentPadding: innerPadding),
                    style: (TextStyle(
                        color: textColor,
                        letterSpacing: letterSpacing,
                        fontSize: fontSize,
                        fontFamily: fontFamily)),
                  ),
                ))
              : Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ObjectUtil.isNotEmpty(preIcon) ? preIcon! : SizedBox(),
                      Expanded(
                        child: TextField(
                          autofillHints: autoFillHints,
                          focusNode: focusNode,
                          cursorColor: textColor,
                          autofocus: isAutoFocus!,
                          textAlign: textAlign!,
                          controller: controller,
                          onChanged: onChanged,
                          keyboardType: textInputType,
                          maxLength: maxLength,
                          maxLines: maxLines,
                          minLines: 1,
                          inputFormatters: inputFormatter,
                          obscureText: obscureText!,
                          decoration: InputDecoration(
                            hintText: hintText,
                            hintStyle: TextStyle(
                                fontSize: fontSize,
                                color: hintColor,
                                letterSpacing: letterSpacing),
                            errorText: errorMsg,
                            border: InputBorder.none,
                            focusedBorder: (enableFocusBorder ?? false)
                                ? OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: context.theme.highlightColor,
                                        width: 2.0),
                                    borderRadius:
                                        BorderRadius.circular(radius!),
                                  )
                                : null,
                            contentPadding: innerPadding,
                          ),
                          style: (TextStyle(
                              color: textColor,
                              letterSpacing: letterSpacing,
                              fontSize: fontSize,
                              fontFamily: fontFamily)),
                        ),
                      ),
                      ObjectUtil.isNotEmpty(postIcon) ? postIcon! : SizedBox(),
                    ],
                  ),
                ),
        ),
        onTap: () {
          if (onTab != null) {
            onTab!();
          }
        },
      ),
    );
  }
}
