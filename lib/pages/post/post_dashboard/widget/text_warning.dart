import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';

class TextWarning extends StatelessWidget {
  final String? title;
  final String? subTile;

  TextWarning({this.title, this.subTile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.w, top: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                title ?? '',
                style: Style().bodyStyle2,
              ),
              SizedBox(
                width: 4.w,
              ),
              Text(
                '*',
                style: Style()
                    .bodyStyle2
                    .copyWith(color: Get.context!.theme.primaryColor),
              ),
            ],
          ),
          Text(
            subTile ?? '',
            style: Style().normalStyle2,
          ),
        ],
      ),
    );
  }
}
