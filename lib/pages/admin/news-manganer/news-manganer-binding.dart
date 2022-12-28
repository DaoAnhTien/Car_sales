import 'package:get/get.dart';
import 'package:oke_car_flutter/repositories/authenticate_client.dart';

import 'news-manganer-controller.dart';

class NewsManganerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewsManganerController(client: AuthenticateClient()));
  }

}