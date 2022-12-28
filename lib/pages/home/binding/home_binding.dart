import 'package:oke_car_flutter/pages/acount/acount_dashboard/controller/acount_controller.dart';
import 'package:oke_car_flutter/pages/admin/carCompany/carCompany-controller.dart';
import 'package:oke_car_flutter/pages/dashboard/controller/dashboard_controller.dart';
import 'package:oke_car_flutter/pages/home/controller/home_controller.dart';
import 'package:oke_car_flutter/pages/notification/notification_dashboard/binding/notification_binding.dart';
import 'package:oke_car_flutter/pages/notification/notification_dashboard/controller/notification_controller.dart';
import 'package:oke_car_flutter/pages/product/product_dashboard/controller/product_controller.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/pages/search/searchDashboard/controller/search_controller.dart';
import 'package:oke_car_flutter/repositories/authenticate_client.dart';

import '../../admin/news-manganer/news-manganer-controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => DashBoardController(client: AuthenticateClient()));
    Get.lazyPut(() => AccountController(client: AuthenticateClient()));
    Get.lazyPut(() => NotificationController(client: AuthenticateClient()));
    Get.lazyPut(() => SearchController(client: AuthenticateClient()));
    Get.lazyPut(() => NewsManganerController(client: AuthenticateClient()));
    Get.lazyPut(() => CarCompanyController(client: AuthenticateClient()));

    // Get.lazyPut(() => Ac());
    // Get.lazyPut(() => SearchController());
  }
}
