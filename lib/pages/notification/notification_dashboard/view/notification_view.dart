import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/models/notification_model.dart';
import 'package:oke_car_flutter/pages/notification/notification_dashboard/controller/notification_controller.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';
import 'package:oke_car_flutter/widgets/custom/custom_easy_refresh.dart';

import '../../../../utils/date_util.dart';

class NotificationPage extends GetView<NotificationController> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.theme.primaryColor,
      child: SafeArea(
        child: Scaffold(
          body: Obx(
            () {
              return CustomEasyRefresh(
                controller: controller.ctlRefresh,
                onRefresh: controller.onRefresh,
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return _buildListNotification(
                        context, controller.listNotification[index], index);
                  },
                  childCount: controller.listNotification.length,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildListNotification(
      BuildContext context, NotificationModel notification, index) {
    return InkWell(
      onTap: () => controller.handleReadNotification(notification),
      child: Container(
        margin: EdgeInsets.only(
            top: index == 0 ? 10.w : 0, left: 16.w, right: 16.w),
        padding: EdgeInsets.symmetric(vertical: 10.0.w),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 0.5.w,
            ),
          ),
        ),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.notifications_active,
                  color: !notification.isRead
                      ? context.theme.primaryColorDark
                      : context.textTheme.caption!.color,
                  size: 20.w,
                ),
                SizedBox(
                  width: 8.w,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.title,
                        style: Style().subtitleStyle1.copyWith(
                              color: !notification.isRead
                                  ? context.textTheme.headline1?.color
                                  : context.textTheme.caption!.color,
                            ),
                      ),
                      SizedBox(
                        height: 5.w,
                      ),
                      Text(
                        notification.message,
                        style: Style().subtitleStyle2.copyWith(
                              color: !notification.isRead
                                  ? context.textTheme.headline1?.color
                                  : context.textTheme.caption!.color,
                            ),
                      ),
                      SizedBox(
                        height: 10.w,
                      ),
                      Text(
                        DateUtil.formatDate(notification.createdAt),
                        style: Style().cardStyle.copyWith(
                              color: !notification.isRead
                                  ? context.textTheme.headline1?.color
                                  : context.textTheme.caption!.color,
                            ),
                      ),
                    ],
                  ),
                ),
                CircleAvatar(
                  backgroundColor: !notification.isRead
                      ? context.theme.primaryColorDark
                      : context.textTheme.caption!.color,
                  radius: 4.0.w,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
