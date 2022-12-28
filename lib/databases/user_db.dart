
import 'package:oke_car_flutter/constants/config_constant.dart';
import 'package:oke_car_flutter/models/user_model.dart';
import 'package:hive/hive.dart';

class UserDB {
  UserModel? currentUser() {
    final boxUser = Hive.box<UserModel>(BOX_USER);
    return boxUser.get(0);
  }

  Future<UserModel> save(UserModel userModel) async {
    final boxUser = Hive.box<UserModel>(BOX_USER);
    await boxUser.put(0, userModel);

    return boxUser.get(0)!;
  }

  Future<void> clear() async {
    final boxUser = Hive.box<UserModel>(BOX_USER);
    await boxUser.delete(0);
    await boxUser.clear();
  }
}
