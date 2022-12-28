// import 'dart:async';
// import 'dart:io';
// import 'dart:ui' as ui show window;
//
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:package_info_plus/package_info_plus.dart';
// import 'package:sentry/sentry.dart';
//
// import 'package:system_info/system_info.dart';
//
// const int MEGABYTE = 1024 * 1024;
//
// typedef Future<Null> ErrorReporter(Object error, StackTrace stackTrace);
// typedef Widget ErrorReportingWidget(ErrorReporter reporter);
//
// Future<Null> reportError(Object error, StackTrace stackTrace) async {
//   print('Caught error: $error');
//   if (kDebugMode) {
//     print(stackTrace);
// //    when release application will enable it to only detect in production mode
// //     In dev mode. Not sending report to Sentry.io.
//     return;
//   }
//
//   debugPrint('Reporting to Sentry.io...');
//
//   try {
//     Sentry.captureException(error, stackTrace: stackTrace);
//   } catch (e, stackTrace) {
//     debugPrint(
//         'Exception whilst reporting to Sentry.io\n' + stackTrace.toString());
//   }
// }
//
// configureSentryScope() async {
//   final PackageInfo info = await PackageInfo.fromPlatform();
//
//   final Map<String, dynamic> extra = {};
//   final Map<String, String> deviceInfo = {};
//   try {
//     final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
//     if (Platform.isAndroid) {
//       final AndroidDeviceInfo androidDeviceInfo =
//       await deviceInfoPlugin.androidInfo;
//       deviceInfo['device_id'] = androidDeviceInfo.id ?? '';
//       deviceInfo['device_name'] = androidDeviceInfo.model ?? '';
//       deviceInfo['brand_name'] = androidDeviceInfo.brand ?? '';
//       deviceInfo['type'] = androidDeviceInfo.type ?? '';
//       deviceInfo['fingerprint'] = androidDeviceInfo.fingerprint ?? '';
//       deviceInfo['host'] = androidDeviceInfo.host ?? '';
//       deviceInfo['device'] = androidDeviceInfo.device ?? '';
//       deviceInfo['physical_device'] =
//           androidDeviceInfo.isPhysicalDevice.toString();
//       deviceInfo['android_version'] = androidDeviceInfo.version.release ?? '';
//       deviceInfo['API_level'] = androidDeviceInfo.version.sdkInt.toString();
//     } else if (Platform.isIOS) {
//       final IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
//       deviceInfo['device_id'] = iosDeviceInfo.identifierForVendor ?? '';
//       deviceInfo['device_name'] = iosDeviceInfo.utsname.machine ?? '';
//       deviceInfo['physical_device'] = iosDeviceInfo.isPhysicalDevice.toString();
//       deviceInfo['version'] = iosDeviceInfo.utsname.release ?? '';
//       deviceInfo['node_name'] = iosDeviceInfo.utsname.nodename ?? '';
//       deviceInfo['model'] = iosDeviceInfo.model ?? '';
//       deviceInfo['name'] = iosDeviceInfo.name ?? '';
//       deviceInfo['system_name'] = iosDeviceInfo.systemName ?? '';
//       deviceInfo['system_version'] = iosDeviceInfo.systemVersion ?? '';
//       deviceInfo['localized_model'] = iosDeviceInfo.localizedModel ?? '';
//     }
//     extra['device_info'] = deviceInfo;
//   } catch (error) {
//     extra['device_info'] = "Can't get device info";
//   }
//
//   // String? username = ConfigDB().getConfigByName(CONFIG_USERNAME);
//
//   final String mode = kDebugMode ? 'debug' : 'release';
//
//   final Map<String, String> tags = {};
//   tags['platform'] =
//       defaultTargetPlatform.toString().substring('TargetPlatform.'.length);
//   tags['package_name'] = info.packageName;
//   tags['build_number'] = info.buildNumber;
//   tags['version'] = info.version;
//   tags['mode'] = mode;
//   tags['locale'] = Platform.localeName.toString();
//   tags['device_id'] = deviceInfo['device_id'] ?? 'Error';
//   tags['device_name'] = deviceInfo['device_name'] ?? 'Error';
//   // tags['username'] = username ?? 'empty';
//
//   final ConnectivityResult connectivity =
//   await Connectivity().checkConnectivity();
//   tags['connectivity'] =
//       connectivity.toString().substring('ConnectivityResult.'.length);
//
//   final Map<String, dynamic> uiValues = {};
//   uiValues['locale'] = Platform.localeName.toString();
//   uiValues['pixel_ratio'] = ui.window.devicePixelRatio;
//   uiValues['default_route'] = ui.window.defaultRouteName;
//   uiValues['physical_size'] = [
//     ui.window.physicalSize.width,
//     ui.window.physicalSize.height
//   ];
//   uiValues['text_scale_factor'] = ui.window.textScaleFactor;
//   uiValues['view_insets'] = [
//     ui.window.viewInsets.left,
//     ui.window.viewInsets.top,
//     ui.window.viewInsets.right,
//     ui.window.viewInsets.bottom
//   ];
//   uiValues['padding'] = [
//     ui.window.padding.left,
//     ui.window.padding.top,
//     ui.window.padding.right,
//     ui.window.padding.bottom
//   ];
//   if (WidgetsBinding.instance != null) {
//     // Removed the widget tree as it posts too much information.
//     /*
// 		if (WidgetsBinding.instance.renderViewElement != null) {
// 			uiValues['render_view'] = WidgetsBinding.instance.renderViewElement.toStringDeep();
// 		} else {
// 			uiValues['render_view'] = '<no tree currently mounted>';
// 		}
// 		*/
//   }
//   extra['ui'] = uiValues;
//
//   final Map<String, dynamic> memory = {};
//   try {
//     memory['physical_total'] =
//     '${SysInfo.getTotalPhysicalMemory() ~/ MEGABYTE}MB';
//     memory['physical_free'] =
//     '${SysInfo.getFreePhysicalMemory() ~/ MEGABYTE}MB';
//     memory['virtual_total'] =
//     '${SysInfo.getTotalVirtualMemory() ~/ MEGABYTE}MB';
//     memory['virtual_free'] = '${SysInfo.getFreeVirtualMemory() ~/ MEGABYTE}MB';
//     extra['memory'] = memory;
//   } catch (error) {
//     extra['memory'] = "Can't get memory info";
//   }
//
//   extra['dart_version'] = Platform.version;
//
//   // final user = UserDB().currentUser();
//   //
//   // Sentry.configureScope((scope) => {
//   //       scope
//   //         ..user = SentryUser(
//   //           id: user?.id ?? 'empty',
//   //           username: user?.name ?? 'empty',
//   //           email: user?.email ?? 'empty',
//   //           ipAddress: 'unknown',
//   //           extras: extra,
//   //         ),
//   //       scope.setExtra('memory', memory),
//   //       scope.setTag('platform', tags['platform'] ?? ''),
//   //       scope.setTag('package_name', tags['package_name'] ?? ''),
//   //       scope.setTag('build_number', tags['build_number'] ?? ''),
//   //       scope.setTag('version', tags['version'] ?? ''),
//   //       scope.setTag('mode', tags['mode'] ?? ''),
//   //       scope.setTag('locale', tags['locale'] ?? ''),
//   //       scope.setTag('device_id', tags['device_id'] ?? ''),
//   //       scope.setTag('device_name', tags['device_name'] ?? ''),
//   //       scope.setTag('username', tags['username'] ?? ''),
//   //       scope.setTag('connectivity', tags['connectivity'] ?? ''),
//   //     });
// }
