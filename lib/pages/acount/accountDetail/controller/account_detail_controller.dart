import 'package:get/get.dart';
import 'package:oke_car_flutter/databases/user_db.dart';
import 'package:oke_car_flutter/models/user_model.dart';

class AccountDetailController extends GetxController {
  final user = UserModel().obs;

  @override
  void onInit() {
    super.onInit();
    user.value = UserDB().currentUser() ?? UserModel();
  }
}