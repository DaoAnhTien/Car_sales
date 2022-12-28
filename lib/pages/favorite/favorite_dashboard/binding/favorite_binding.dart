import 'package:oke_car_flutter/pages/favorite/favorite_dashboard/controller/favorite_controller.dart';
import 'package:get/get.dart';

class FavoriteBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavoriteController());
    // TODO: implement dependencies
  }
}
