import 'package:get/get.dart';
import 'package:oke_car_flutter/repositories/authenticate_client.dart';

import 'history_order_controller.dart';

class HistoryOrderBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HistoryOrderController(client: AuthenticateClient()));
  }
}
