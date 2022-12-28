import 'package:get/get.dart';
import 'package:oke_car_flutter/pages/search/searchDashboard/controller/search_controller.dart';
import 'package:oke_car_flutter/repositories/authenticate_client.dart';

class SearchBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() =>
        SearchController(client: AuthenticateClient()));
  }
}
