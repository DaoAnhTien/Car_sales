import 'package:oke_car_flutter/pages/product/product_dashboard/controller/product_controller.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/repositories/authenticate_client.dart';

class ProductBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ProductController(client: AuthenticateClient()));
  }

}