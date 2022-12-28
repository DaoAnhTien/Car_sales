import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/values/style.dart';

import 'custom/typehead/flutter_typehead.dart';

class SuggestionTextField extends StatelessWidget {
  final String? title;
  final TextAlign? textAlign;
  final int maxLines;
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
  final TextInputType textInputType;
  final bool? enabled;
  final bool? obscureText;
  final double? letterSpacing;
  final List<TextInputFormatter>? inputFormatter;
  final Widget? preIcon;
  final Widget? postIcon;
  final List<String> autoFillHints;
  final Function? onTab;
  final bool? enableFocusBorder;
  final bool? filled;
  final Color? fillColor;
  final Widget? suffix;
  final GestureTapCallback? onTabSuffix;
  final bool? required;
  final LinearGradient? gradient;

  const SuggestionTextField({
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
        const EdgeInsets.only(top: 8, bottom: 8, left: 20, right: 20),
    this.outsidePadding =
        const EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
    this.autoFillHints = const <String>[],
    this.onTab,
    this.enableFocusBorder = true,
    this.filled = true,
    this.required = false,
    this.fillColor,
    this.suffix,
    this.onTabSuffix,
    this.gradient,
    Key? key,
  }) : super(key: key);

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
            Row(
              children: [
                Text(
                  title ?? '',
                  style: Style().bodyStyle1,
                ),
                (required ?? false)
                    ? Text(
                        ' *',
                        style: Style().bodyStyle1.copyWith(
                              color: context.theme.primaryColorDark,
                            ),
                      )
                    : const SizedBox(),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius!),
                  border: Border.all(
                    color: !focusNode!.hasFocus
                        ? context.theme.hintColor
                        : context.theme.colorScheme.secondary,
                    width: 2,
                  )),
              child: TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
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
                    labelStyle: Style().subtitleStyle1,
                    hintText: hintText,
                    hintStyle: Style().subtitleStyle1,
                    filled: filled,
                    fillColor: fillColor ?? Style.transparent,
                    errorText: errorMsg,
                    errorStyle:
                        const TextStyle(height: 0, color: Style.transparent),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(radius!),
                      borderSide: !focusNode!.hasFocus
                          ? const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            )
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
                                color: context.theme.primaryColorDark,
                                width: 2.0),
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
                suggestionsCallback: (pattern) async {
                  return getSuggestions(pattern);
                },
                itemBuilder: (context, String suggestion) {
                  return Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: context.theme.cardColor,
                    ),
                    child: Text(suggestion),
                  );
                },
                onSuggestionSelected: (String suggestion) {
                  controller?.text = suggestion;
                  focusNode?.unfocus();
                  if (onChanged != null) {
                    onChanged!(suggestion);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> getSuggestions(String query) {
    query = query.replaceAll('@gmail.com', '');
    query = query.replaceAll('@yahoo.com', '');
    query = query.replaceAll('@outlook.com', '');
    if (query.contains('@')) {
      int index = query.indexOf('@');
      query = query.substring(0, index);
    }
    List<String> matches = <String>[];
    matches.assignAll([
      query + '@gmail.com',
      query + '@yahoo.com',
      query + '@outlook.com',
    ]);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}
