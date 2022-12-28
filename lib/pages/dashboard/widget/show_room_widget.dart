import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/pages/dashboard/controller/dashboard_controller.dart';
import 'package:oke_car_flutter/pages/dashboard/model/showroom_model.dart';
import 'package:oke_car_flutter/utils/app_util.dart';
import 'package:oke_car_flutter/values/setting.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:oke_car_flutter/widgets/_cachedImage.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';
import 'package:oke_car_flutter/widgets/custom/custom_web.dart';
import 'package:oke_car_flutter/widgets/flutter_slimmer.dart';

class ShowRoomWidget extends GetView<DashBoardController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Obx(
        () {
          return Container(
            child: Row(
              children: controller.listShowroom
                  .map<Widget>(
                    (showroomModel) => buildShowroom(context, showroomModel),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }

  Widget buildShowroom(BuildContext context, ShowRoomModel model) {
    return GestureDetector(
      onTap: () {
        Get.to(
            () => CustomWebView(url: model.link + '?t=mobile', title: ''.tr));
      },
      child: Container(
        margin: EdgeInsets.only(left: 16.w),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: context.theme.cardColor,
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            color: context.theme.backgroundColor,
            borderRadius: BorderRadius.circular(10.w)),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.w),
                      topRight: Radius.circular(10.w)),
                  child: CachedImage(
                    model.image,
                    defaultUrl: AppSetting.imgLogo,
                    height: 150.w,
                    width: 300.w,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 56.0.w),

                Text(
                  model.name,
                  style: Style().subtitleStyle1,
                ),
                SizedBox(
                  height: 8.w,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: context.theme.highlightColor,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      model.address,
                      style: Style().subtitleStyle2,
                    ),
                  ],
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Get.to(() => CustomWebView(
                        url: model.link + '?t=mobile',
                        title: 'about_hitrade'.tr));
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        AppSetting.icPhoneGift,
                        height: 50.w,
                      ),
                      Text(
                        model.phone,
                        style: Style()
                            .titleStyle1
                            .copyWith(color: context.theme.primaryColorDark),
                      ),
                    ],
                  ),
                )
                // SizedBox(height: 76.0.w),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 16.w),
                //   child: Text(
                //     userModel.displayName != ''
                //         ? userModel.displayName
                //         : userModel.username,
                //     style: TextStyle(
                //         color: context.textTheme.subtitle1!.color,
                //         fontWeight: FontWeight.bold,
                //         fontFamily: Style.fontBold,
                //         fontSize: 22.sp,
                //         letterSpacing: 0.0),
                //     textAlign: TextAlign.center,
                //   ),
                // ),
                // SizedBox(height: 8.0.w),
                // userModel.creatorStatus == CREATOR_STATUS_DONE
                //     ? buildCreatorStatus(context)
                //     : buildKYCStatus(context),
                // userModel.creatorStatus != CREATOR_STATUS_DONE ||
                //     userModel.userInfo!.kycStatus == KYC_STATUS_NONE
                //     ? _registerCreator(context)
                //     : SizedBox(),
                // userModel.bio != ''
                //     ? Padding(
                //   padding: EdgeInsets.symmetric(
                //       horizontal: 20.w, vertical: 12.w),
                //   child: Text(
                //     userModel.bio,
                //     textAlign: TextAlign.justify,
                //     style: Style().hintStyle,
                //     maxLines: 3,
                //     overflow: TextOverflow.ellipsis,
                //   ),
                // )
                //     : SizedBox(),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 16.w),
                //   child: Text(
                //     'member_since'.trArgs([
                //       DateUtil.formatDate(userModel.createdAt,
                //           format: DataFormats.yyyy)
                //     ]),
                //     textAlign: TextAlign.center,
                //     style: Style().hintStyle.copyWith(fontSize: 13.sp),
                //     maxLines: 2,
                //     overflow: TextOverflow.ellipsis,
                //   ),
                // )
              ],
            ),
            // Profile image
            Positioned(
              top: 100.0, // (background container size) - (circle height / 2)
              child: model.image != ''
                  ? Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 6.w, color: context.theme.backgroundColor),
                          borderRadius: BorderRadius.circular(100.w)),
                      child: CircleAvatar(
                        radius: 40.0.w,
                        foregroundColor: context.theme.hintColor,
                        backgroundImage: NetworkImage(
                          model.image,
                        ),
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 6.w, color: context.theme.backgroundColor),
                          borderRadius: BorderRadius.circular(100.w)),
                      child: CircleAvatar(
                          foregroundColor: context.theme.hintColor,
                          radius: 40.0.w,
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage(AppSetting.imgLogo)),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
