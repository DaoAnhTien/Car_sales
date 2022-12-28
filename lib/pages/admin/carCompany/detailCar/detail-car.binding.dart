import 'package:get/get.dart';
import 'package:oke_car_flutter/pages/admin/carCompany/detailCar/detail-car-controller.dart';
import 'package:oke_car_flutter/pages/product/detail_product/controller/detail_controller.dart';
import 'package:oke_car_flutter/repositories/authenticate_client.dart';

class DetailCarCompanyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailCarAdminController(client: AuthenticateClient()));
  }

}