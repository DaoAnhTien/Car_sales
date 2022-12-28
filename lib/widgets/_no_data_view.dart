import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';
import 'package:oke_car_flutter/values/setting.dart';
import 'package:oke_car_flutter/values/style.dart';

class NoDataView extends StatelessWidget {
  final String? message;

  const NoDataView({this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 10),
          Container(
            alignment: Alignment.center,
            child: Lottie.asset(
              AppSetting.lottieNoData,
              width: 300.w,
              height: 150.w,
              fit: BoxFit.scaleDown,
              repeat: true,
            ),
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.only(bottom: 10.w, left: 16.w, right: 16.w),
            child: Text(
              (message == null) ? 'we_could_not_find_your_data'.tr : message!,
              style: Style().noteStyle1.copyWith(
                    fontFamily: Style.fontRegular,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
