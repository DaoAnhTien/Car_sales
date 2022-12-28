import 'package:get/get.dart';
import 'package:oke_car_flutter/pages/auth/register/controller/register_controller.dart';
import 'package:oke_car_flutter/repositories/authenticate_client.dart';

class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController(client: AuthenticateClient()));
  }
}
