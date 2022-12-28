import 'package:get/get.dart';
import 'package:oke_car_flutter/pages/auth/login/controller/login_controller.dart';
import 'package:oke_car_flutter/repositories/authenticate_client.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(
        client: AuthenticateClient(),
        ));
  }
}
