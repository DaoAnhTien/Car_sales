import 'package:oke_car_flutter/values/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TittleDefaultTextField extends StatelessWidget {
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

  TittleDefaultTextField({
    this.title,
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
        const EdgeInsets.only(top: 0, bottom: 0, left: 20, right: 20),
    this.outsidePadding =
        const EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
    this.autoFillHints,
    this.onTab,
    this.enableFocusBorder = true,
    this.filled = true,
    this.fillColor,
    this.suffix,
    this.onTabSuffix,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: outsidePadding!,
      child: SizedBox(
        width: width,
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              autofillHints: autoFillHints,
              focusNode: focusNode,
              cursorColor: context.textTheme.headline1!.color,
              autofocus: isAutoFocus!,
              textAlign: textAlign!,
              controller: controller,
              onChanged: onChanged,
              keyboardType: textInputType,
              maxLength: maxLength,
              maxLines: maxLines,
              inputFormatters: inputFormatter,
              obscureText: obscureText!,
              decoration: InputDecoration(
                labelStyle: Style().hintStyle,
                hintText: hintText,
                hintStyle: Style().hintStyle,
                filled: filled,
                fillColor: context.theme.backgroundColor,
                errorText: errorMsg,
                errorStyle: TextStyle(height: 0, color: Style.transparent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius!),
                  borderSide: !focusNode!.hasFocus
                      ? BorderSide(color: context.theme.hintColor, width: 1.0)
                      : BorderSide(
                          color: context.theme.colorScheme.secondary,
                          width: 2.0),
                ),
                focusedBorder: (enableFocusBorder ?? false)
                    ? OutlineInputBorder(
                        borderSide: BorderSide(
                            color: context.theme.colorScheme.secondary,
                            width: 2.0),
                        borderRadius: BorderRadius.circular(radius!),
                      )
                    : null,
                errorBorder: errorMsg != null
                    ? OutlineInputBorder(
                        borderSide: BorderSide(
                            color: context.theme.primaryColor, width: 2.0),
                        borderRadius: BorderRadius.circular(radius!),
                      )
                    : null,
                contentPadding: innerPadding,
                suffixIcon: suffix != null
                    ? GestureDetector(
                        // behavior: HitTestBehavior.translucent,
                        child: suffix,
                        onTap: onTabSuffix,
                      )
                    : null,
              ),
              style: Style().subtitleStyle1,
            ),
          ],
        ),
      ),
    );
  }
}
