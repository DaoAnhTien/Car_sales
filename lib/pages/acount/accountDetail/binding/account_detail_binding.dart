import 'package:get/get.dart';
import 'package:oke_car_flutter/pages/acount/accountDetail/controller/account_detail_controller.dart';

class AccountDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AccountDetailController());
  }

}