import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';

class BannerWithText extends StatelessWidget {
  final String? imgUrl;
  final String? title;
  final String? sub;

  BannerWithText({this.imgUrl, this.title, this.sub});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(

        image: DecorationImage(
          image: AssetImage(imgUrl!),
          fit: BoxFit.fill,

        ),
      ),
      height: 160.w,
      padding: EdgeInsets.all(16.w),
      width: MediaQuery.of(context).size.width,

      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    title ?? '',
                    style: TextStyle(
                      color: context.theme.colorScheme.secondary,
                      fontFamily: Style.fontDemiBold,
                      fontSize: 20.sp,
                      letterSpacing: 0.35.sp,
                    ),
                  ),
                ),
                Expanded(child: Container())
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    sub ?? '',
                    style: TextStyle(
                      color: Style.whiteColor,
                      fontFamily: Style.fontDemiBold,
                      fontSize: 20.sp,
                      letterSpacing: 0.35.sp,
                    ),
                  ),
                ),
                Expanded(child: Container())
              ],
            ),
          ]),
    );
  }
}
