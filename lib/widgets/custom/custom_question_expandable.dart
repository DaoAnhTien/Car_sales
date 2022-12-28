import 'dart:math' as math;

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';
import 'package:oke_car_flutter/values/style.dart';

class CustomQuestionExpandable extends StatelessWidget {
  final String question;
  final String answer;
  final int? index;

  CustomQuestionExpandable({
    required this.question,
    required this.answer,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ExpandablePanel(
              theme: const ExpandableThemeData(
                headerAlignment: ExpandablePanelHeaderAlignment.center,
                tapBodyToCollapse: true,
                hasIcon: false,
              ),
              header: Container(
                child: Padding(
                  padding: EdgeInsets.all(5.0.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ExpandableIcon(
                        theme: ExpandableThemeData(
                          expandIcon: Icons.keyboard_arrow_right_outlined,
                          collapseIcon: Icons.keyboard_arrow_down_outlined,
                          iconColor: context.textTheme.headline1!.color,
                          iconSize: 20.0,
                          iconRotationAngle: math.pi / 2,
                          iconPadding: EdgeInsets.only(right: 16),
                          hasIcon: false,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          (index != null ? '$index. ' : '') + question.tr,
                          style: Style().hintStyle.copyWith(
                              color: context.textTheme.headline1!.color,
                              fontSize: 15.sp),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              collapsed: SizedBox.shrink(),
              expanded: Padding(
                padding: const EdgeInsets.only(left: 16.0 + 22.0),
                child: Text(
                  answer.tr,
                  style: Style()
                      .hintStyle
                      .copyWith(fontSize: 13.sp, height: 22.sp / 13.sp),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
