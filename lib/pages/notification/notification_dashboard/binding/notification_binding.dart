import 'package:get/get.dart';
import 'package:oke_car_flutter/pages/notification/notification_dashboard/controller/notification_controller.dart';
import 'package:oke_car_flutter/repositories/authenticate_client.dart';

class NotificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationController(
      client: AuthenticateClient(),
    ));
  }
}