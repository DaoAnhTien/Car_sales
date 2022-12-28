import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/pages/dashboard/controller/dashboard_controller.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';
import 'package:oke_car_flutter/values/setting.dart';
import 'package:oke_car_flutter/values/style.dart';

class HomeAppBar extends GetView<DashBoardController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              child: Stack(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.w, horizontal: 16.w),
                    child: Row(
                      children: [
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          child: Padding(
                            padding: EdgeInsets.only(right: 8.w),
                            child: Icon(
                              Icons.facebook_outlined,
                              color: Colors.white,
                            ),
                          ),
                          // onTap: controller.goGroupFacebook,
                        ),
                        Flexible(
                            child: Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: Text(
                            controller.user.value.userName != ''
                                ? controller.user.value.userName
                                : controller.user.value.email,
                            textAlign: TextAlign.left,
                            style: Style()
                                .bodyStyle2
                                .copyWith(color: Colors.white),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )),
                      ],
                    ),
                  ),
                  Positioned.fill(
                    top: 5.w,
                    left: 5.w,
                    right: 10.w,
                    child: Container(
                      // key: controller.home.keyAccount,
                      width: context.width,
                    ),
                  ),
                ],
              ),
              onTap: () {
                // Get.toNamed(Routes.ACCOUNT);?
              },
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: Padding(
              padding: EdgeInsets.only(
                  top: 5.w, bottom: 5.w, left: 8.w, right: 16.w),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      AppSetting.ic_bell,
                      width: 21.w,
                      height: 24.w,
                      fit: BoxFit.scaleDown,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: 6 > 0
                        ? Container(
                            alignment: Alignment.center,
                            width: 15.w,
                            height: 15.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: context.theme.colorScheme.secondary,
                            ),
                            child: Text(
                              '${6}',
                              textAlign: TextAlign.center,
                              style: Style().normalStyle1.copyWith(
                                    fontSize: 10.sp,
                                    color: Style.textHighLightColor,
                                  ),
                            ),
                          )
                        : SizedBox(),
                  ),
                ],
              ),
            ),
            onTap: () {
              // Get.toNamed(Routes.NOTIFICATION);
            },
          ),
        ],
      ),
    );
  }
}
