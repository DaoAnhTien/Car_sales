import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';

class CustomHeaderFilter extends StatelessWidget with PreferredSizeWidget {
  final String? title;

  CustomHeaderFilter({this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 8.w,
        ),
        Container(
          width: 80.w,
          height: 5.w,
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(16.w)),
        ),
        SizedBox(
          height: 8.w,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title ??'Loại xe'.tr,
                textAlign: TextAlign.center, style: Style().subtitleStyle1),
            GestureDetector(
              onTap: () {
                Get.back();
                FocusScope.of(Get.context!).requestFocus(new FocusNode());
              },
              child: Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
