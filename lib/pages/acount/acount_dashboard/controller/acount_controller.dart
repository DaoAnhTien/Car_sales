import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/constants/config_constant.dart';
import 'package:oke_car_flutter/databases/config_db.dart';
import 'package:oke_car_flutter/databases/user_db.dart';
import 'package:oke_car_flutter/models/user_model.dart';
import 'package:oke_car_flutter/pages/acount/acount_dashboard/model/static_url_model.dart';
import 'package:oke_car_flutter/repositories/authenticate_client.dart';
import 'package:oke_car_flutter/routes/app_pages.dart';
import 'package:oke_car_flutter/utils/dialog_util.dart';
import 'package:oke_car_flutter/utils/error_util.dart';
import 'package:oke_car_flutter/utils/object_util.dart';

class AccountController extends GetxController {
  final AuthenticateClient client;


  AccountController({required this.client});

  final loading = false.obs;
  final user = UserModel().obs;

  @override
  void onInit() {

    super.onInit();
  }
  onGotoProfile() {
    Get.toNamed(Routes.PROFILE);
  }
  onGotoMyPost() {
    Get.toNamed(Routes.MyPostView);
  }
  onGotoChangePassword() {
    Get.toNamed(Routes.CHANGE_PASS);
  }
  handleLogout() async {
      Get.offAllNamed(Routes.LOGIN);
      await ConfigDB().deleteConfigByName(CONFIG_USERNAME);
      await ConfigDB().deleteConfigByName(CONFIG_ACCESS_TOKEN);
      await ConfigDB().deleteConfigByName(CONFIG_ACCOUNT_MODE);

      await ConfigDB().deleteConfigByName(CONFIG_LAST_CHART_TYPE);
      await ConfigDB().deleteConfigByName(CONFIG_LAST_ORDER_TYPE);
      await ConfigDB().deleteConfigByName(CONFIG_REGISTER_USERNAME);

      await UserDB().clear();

  }


}