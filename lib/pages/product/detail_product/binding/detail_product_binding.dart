import 'package:get/get.dart';
import 'package:oke_car_flutter/pages/product/detail_product/controller/detail_controller.dart';
import 'package:oke_car_flutter/repositories/authenticate_client.dart';

class DetailCarBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailCarController(client: AuthenticateClient()));
  }
}
