import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/databases/user_db.dart';
import 'package:oke_car_flutter/models/user_model.dart';
import 'package:oke_car_flutter/pages/acount/acount_dashboard/view/acount_page.dart';
import 'package:oke_car_flutter/pages/dashboard/view/dashboard_page.dart';
import 'package:oke_car_flutter/pages/notification/notification_dashboard/view/notification_view.dart';
import 'package:oke_car_flutter/pages/product/product_dashboard/view/product_view.dart';
import 'package:oke_car_flutter/routes/app_pages.dart';

import '../../admin/carCompany/carCompany-page.dart';
import '../../admin/news-manganer/news-manganer-page.dart';
import '../../search/searchDashboard/view/search_view.dart';

class HomeController extends GetxController {
  final keyword = ''.obs;
  final pair = <String, dynamic>{}.obs;
  final currentIndex = 0.obs;
  List<Widget> children = [];

  final userModel = UserModel().obs;

  @override
  void onInit() {
    userModel.value = UserDB().currentUser() ?? UserModel();
    children = userModel.value.role == 'admin'
        ? [
            NewsManganerPage(),
            CarCompanyPage(),
            AccountPage(),
          ]
        : [
            DashBoardPage(),
            SearchPage(),
            NotificationPage(),
            AccountPage(),
          ];
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Widget get currentPage => children[currentIndex.value];

  onSelectedItem(int index) async {
    currentIndex.value = index;
  }

  onGotoCreatePost() {
    Get.toNamed(Routes.POST_CREATE);
  }
}
