import 'package:get/get.dart';
import 'package:oke_car_flutter/repositories/authenticate_client.dart';
import 'carCompany-controller.dart';

class CarCompanyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CarCompanyController(client: AuthenticateClient()));
  }
}
