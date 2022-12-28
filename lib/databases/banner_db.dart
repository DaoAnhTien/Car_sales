// import 'package:hive/hive.dart';
// import 'package:oke_car_flutter/models/banner_model.dart';
//
// class SystemConfigDB {
//   BannerModel currentConfig() {
//     final boxSystemConfig = Hive.box<BannerModel>(BOX_SYSTEM_CONFIG);
//     return boxSystemConfig.get(0) ?? SystemConfig();
//   }
//
//   Future<SystemConfig> save(SystemConfig systemConfig) async {
//     final boxSystemConfig = Hive.box<SystemConfig>(BOX_SYSTEM_CONFIG);
//     await boxSystemConfig.put(0, systemConfig);
//
//     return boxSystemConfig.get(0)!;
//   }
// }
