import 'package:get/get.dart';
import 'package:oke_car_flutter/pages/myNews/controller/my_post_controller.dart';
import 'package:oke_car_flutter/repositories/authenticate_client.dart';

class MyPostBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyPostController(client: AuthenticateClient()));
  }

}