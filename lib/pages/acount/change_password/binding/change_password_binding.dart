import 'package:get/get.dart';
import 'package:oke_car_flutter/pages/acount/change_password/controller/change_password_controller.dart';
import 'package:oke_car_flutter/repositories/authenticate_client.dart';

class ChangePasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChangePasswordController(
        client: AuthenticateClient(),
        ));
  }
}
