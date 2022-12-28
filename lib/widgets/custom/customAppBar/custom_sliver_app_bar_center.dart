import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/models/user_model.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';
import 'package:oke_car_flutter/values/style.dart';

class SliverCustomHeaderDelegateCenter extends SliverPersistentHeaderDelegate {
  final double collapsedHeight;
  final double expandedHeight;
  final double paddingTop;

  final bool? enableBack;
  final bool? enableUploadAvatar;
  final bool? enableUploadCover;
  final bool? enableReportIcon;
  final String? icon;
  final VoidCallback? onBackPress;
  final bool? centerTitle;
  final GestureTapCallback? changeAvatar;
  final GestureTapCallback? changeCover;
  final GestureTapCallback? onTap;
  final GestureTapCallback? report;
  final UserModel user;

  SliverCustomHeaderDelegateCenter(
      {required this.collapsedHeight,
      required this.expandedHeight,
      required this.paddingTop,
      this.onBackPress,
      this.centerTitle = false,
      this.enableUploadAvatar = false,
      this.enableUploadCover = false,
      this.onTap,
      this.icon,
      this.changeAvatar,
      this.changeCover,
      required this.user,
      this.enableReportIcon = true,
      this.report,
      this.enableBack = true});

  @override
  double get minExtent => collapsedHeight + paddingTop;

  @override
  double get maxExtent => expandedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  Color makeStickyHeaderBgColor(shrinkOffset) {
    final int alpha =
        (shrinkOffset / (maxExtent - minExtent) * 255).clamp(0, 255).toInt();
    return Color.fromARGB(alpha, 35, 38, 47);
  }

  Color makeStickyHeaderTextColor(shrinkOffset, isIcon) {
    if (shrinkOffset <= 50) {
      return isIcon ? Colors.white : Colors.transparent;
    } else {
      final int alpha =
          (shrinkOffset / (maxExtent - minExtent) * 255).clamp(0, 255).toInt();
      return Color.fromARGB(alpha, 255, 255, 255);
    }
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      height: maxExtent,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Background image
          Container(
              height: maxExtent,
              color: makeStickyHeaderBgColor(shrinkOffset),
              child: buildInfoUser(context)),
          // Put your head back
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 3,
            child: Container(
              color: makeStickyHeaderBgColor(shrinkOffset), // Background color
              child: SafeArea(
                bottom: false,
                child: SizedBox(
                  height: collapsedHeight,
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.brown.shade800,
                        child: const Text('AH'),
                      ),
                      Text(
                        user.userName,
                        textAlign: TextAlign.center,
                        style: Style().subtitleStyle1.copyWith(
                              color: makeStickyHeaderTextColor(
                                  shrinkOffset, false),
                            ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInfoUser(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: Container(
          color: Style.toastErrorBgColor,
            margin: EdgeInsets.only(bottom: 16.w, top: 24.w),
        ));
  }
}
