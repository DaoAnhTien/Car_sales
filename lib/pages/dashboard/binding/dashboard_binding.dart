import 'package:get/get.dart';
import 'package:oke_car_flutter/pages/dashboard/controller/dashboard_controller.dart';
import 'package:oke_car_flutter/repositories/authenticate_client.dart';

class DashBoardBinding implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => DashBoardController(client: AuthenticateClient()));
  }

}