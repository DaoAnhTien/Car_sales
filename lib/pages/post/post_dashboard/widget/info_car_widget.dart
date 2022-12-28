import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/constants/app_constant.dart';
import 'package:oke_car_flutter/pages/post/post_dashboard/model/info_value.dart';
import 'package:oke_car_flutter/pages/post/post_dashboard/widget/custom_hearder_filter.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';

class CartInfoWidget extends StatelessWidget {
  final List<String> listValue;
  final String? headerTitle;
  final String? infoSeted;
  final double? height;
  final Function(String model) onTap;

  CartInfoWidget(
      {required this.listValue,
      this.headerTitle,
      this.height,
      this.infoSeted,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 200.w,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          CustomHeaderFilter(
            title: headerTitle,
          ),
          SizedBox(
            height: 16.w,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: listValue
                    .map<Widget>((model) => buildItem(model,
                        context: context, isSelected: model == infoSeted))
                    .toList(),
              ),
            ),
          ),
          // SizedBox(height: 16.0.w),
        ],
      ),
    );
  }

  Widget buildItem(String value,
      {required BuildContext context, bool? isSelected}) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        onTap(value);
        FocusScope.of(Get.context!).requestFocus(new FocusNode());
      },
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  value.tr,
                  style: isSelected!
                      ? Style().noteStyleRegular
                      : Style()
                          .noteStyleRegular
                          .copyWith(color: context.theme.hintColor),
                ),
              ),
              isSelected
                  ? Icon(
                      Icons.check_circle_outline_sharp,
                      color: context.theme.primaryColorLight,
                    )
                  : const SizedBox(),
            ],
          ),
          SizedBox(
            height: 12.w,
          )
        ],
      ),
    );
  }
}
