import 'package:get/get.dart';
import 'package:oke_car_flutter/pages/auth/forgot_password/controller/forgot_password_controller.dart';
import 'package:oke_car_flutter/repositories/authenticate_client.dart';

class ForgotPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgotPasswordController(
        client: AuthenticateClient(),
        ));
  }
}
