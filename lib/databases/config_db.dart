

import 'package:oke_car_flutter/constants/config_constant.dart';
import 'package:hive/hive.dart';
import 'package:oke_car_flutter/models/config_model.dart';

class ConfigDB {
  String? getConfigByName(String name) {
    final boxConfig = Hive.box<ConfigModel>(BOX_CONFIG);
    return boxConfig.get(name)?.value;
  }

  int getIntConfigByName(String name) {
    String? data = getConfigByName(name);
    try {
      return int.parse(data ?? '');
    } catch (_) {
      return -1;
    }
  }

  double getDoubleConfigByName(String name) {
    String? data = getConfigByName(name);
    try {
      return double.parse(data ?? '');
    } catch (_) {
      return -1;
    }
  }

  Future<ConfigModel?> save(ConfigModel configModel) async {
    final boxConfig = Hive.box<ConfigModel>(BOX_CONFIG);
    await boxConfig.put(configModel.name, configModel);

    return boxConfig.get(configModel.name);
  }

  Future<void> deleteConfigByName(String name) async {
    final boxConfig = Hive.box<ConfigModel>(BOX_CONFIG);
    await boxConfig.delete(name);
  }
}
