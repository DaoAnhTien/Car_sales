import 'package:get/get.dart';
import 'package:oke_car_flutter/pages/post/post_dashboard/controller/post_controller.dart';
import 'package:oke_car_flutter/repositories/authenticate_client.dart';

class PostBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PostController(
      client: AuthenticateClient(),

    ));
  }
}