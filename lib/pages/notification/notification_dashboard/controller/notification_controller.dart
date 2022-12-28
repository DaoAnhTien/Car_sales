import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/models/notification_model.dart';
import 'package:oke_car_flutter/pages/notification/notification_dashboard/view/notification_detail.dart';
import 'package:oke_car_flutter/pages/splash/model/meta_pagination_model.dart';
import 'package:oke_car_flutter/repositories/authenticate_client.dart';
import 'package:oke_car_flutter/utils/dialog_util.dart';
import 'package:oke_car_flutter/utils/error_util.dart';

class NotificationController extends GetxController {
  final AuthenticateClient client;
  var listNotification = <NotificationModel>[].obs;
  var imageDetail = '';
  var titleDetail = '';
  var descDetail = '';
  var createdDetail = '';

  NotificationController({required this.client});

  var meta = MetaPaginationModel().obs;
  final ctlRefresh = EasyRefreshController();
  final isLoading = false.obs;

  @override
  void onInit() {
    isLoading.value = true;
    getAllNotification();
    isLoading.value = false;
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getAllNotification() async {
    try {
      var response = await client.getListNotification();

      listNotification.assignAll((response.data['data'] as List)
          .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } catch (error) {
      print(error);
      DialogUtil.showErrorMessage('system_error'.tr);
    }
  }

  // onDetailNotification(
  //     String title, String image, String desc, String created) {
  //   titleDetail = title;
  //   imageDetail = image;
  //   descDetail = desc;
  //   createdDetail = created;
  //   Get.to(() => NotificationDetailPage());
  // }

  Future<void> onRefresh() async {
    await getAllNotification();
    ctlRefresh.resetLoadState();
    ctlRefresh.finishRefresh();
  }

  Future<void> onLoading() async {
    meta.value.offset++;
    try {
      var response =
          await client.getListNotification(offset: listNotification.length);
      if (response.data != null) {
        listNotification.addAll((response.data as List)
            .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
            .toList());
      }
    } catch (error) {
      print(error);
    }
  }

  handleReadNotification(NotificationModel notification) async {
    if (!notification.isRead) {
      client.getListNotificationId(notification.id).then((response) {
        var existing = listNotification
            .indexWhere((element) => element.id == notification.id);
        listNotification[existing].isRead = true;
        listNotification.refresh();
      }).catchError((error, trace) {
        ErrorUtil.catchError(error, trace);
      });
    }

    return Get.to(
      () => NotificationDetailPage(notification),
      arguments: notification,
    );
  }
}
