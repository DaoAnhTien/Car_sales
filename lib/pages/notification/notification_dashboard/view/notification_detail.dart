import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';
import 'package:oke_car_flutter/models/notification_model.dart';
import 'package:oke_car_flutter/pages/notification/notification_dashboard/controller/notification_controller.dart';
import 'package:oke_car_flutter/values/setting.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:oke_car_flutter/widgets/_cachedImage.dart';
import 'package:oke_car_flutter/widgets/_custom_header.dart';
import 'package:oke_car_flutter/widgets/custom/customAppBar/custom_app_bar.dart';

import '../../../../utils/date_util.dart';

class NotificationDetailPage extends StatelessWidget {
  final NotificationModel notification;

  NotificationDetailPage( this.notification);

  @override
  Widget build(BuildContext context) {
    final notification = this.notification;
    return Material(
      color: context.theme.backgroundColor,
      child: Scaffold(
          backgroundColor: context.theme.backgroundColor,
          appBar: CustomHeaderWidget(
            title: 'Chi tiết thông báo',
          ),
          body: Container(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 0.5.w, color: Colors.grey),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.mark_email_unread,
                        color: context.theme.highlightColor,
                        size: 20.w,
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notification.title,
                              style: Style().subtitleStyle1,
                            ),
                            SizedBox(
                              height: 5.w,
                            ),
                            Text(
                              notification.message,
                              style: Style().cardStyle,
                            ),
                            SizedBox(
                              height: 15.w,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16.w,
                ),
                Container(
                  child: Text(
                    DateUtil.formatDate(notification.createdAt),
                    style: Style().subtitleStyle2,
                  ),
                )
              ],
            ),
          )),
    );
  }
}
