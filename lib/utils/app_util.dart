import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/models/device_model.dart';
import 'package:intl/intl.dart';

import 'object_util.dart';

class AppUtil {
  static AppUtil instance = new AppUtil();

  static List<T> map<T>(List? list, Function handler, {int? length}) {
    final List<T> result = [];
    int size;

    if (ObjectUtil.isNotEmpty(list)) {
      size = (length != null && length <= (list?.length ?? 0))
          ? length
          : (list?.length ?? 0);

      for (var i = 0; i < size; i++) {
        result.add(handler(i, list?[i]));
      }
    }

    return result;
  }

  static Map<String, dynamic> filterRequestData(
      Map<String, dynamic> mapToEdit) {
    final keys = mapToEdit.keys.toList(growable: false);
    for (String key in keys) {
      final value = mapToEdit[key];
      if (value == null) {
        mapToEdit.remove(key);
      } else if (value is String) {
        if (value.isEmpty) {
          mapToEdit.remove(key);
        }
      } else if (value is Map) {
        filterRequestData(value as Map<String, dynamic>);
      }
    }
    return mapToEdit;
  }

  //
  static Future<DeviceModel> getDeviceInfo() async {
    DeviceModel device = DeviceModel(deviceId: '', deviceName: '');
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidDeviceInfo =
      await deviceInfoPlugin.androidInfo;
      device.deviceId = (androidDeviceInfo.id ?? '').toLowerCase();
      device.deviceName = androidDeviceInfo.model ?? '';
    } else {
      final IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
      device.deviceId = (iosDeviceInfo.identifierForVendor ?? '').toLowerCase();
      device.deviceName = iosDeviceInfo.name ?? '';
    }

    return device;
  }

  static Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  static String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }

  static String formatMoney(double money,
      {currency = 'đ', fractionDigits = 0, bool isContract = false}) {
    if (money.isNaN) {
      money = 0;
    }
    String format = '###,##${isContract ? '0.00' : '#.##'}';
    switch (fractionDigits) {
      case 0:
        format = '###,###';
        break;
      case 1:
        format = '###,##${isContract ? '0.0' : '#.#'}';
        break;
      case 2:
        format = '###,##${isContract ? '0.00' : '#.##'}';
        break;
      case 3:
        format = '###,##${isContract ? '0.000' : '#.###'}';
        break;
      case 4:
        format = '###,###${isContract ? '0.0000' : '#.####'}';
        break;
      case 5:
        format = '###,##${isContract ? '0.00000' : '#.#####'}';
        break;
    }
    var f = new NumberFormat(format, 'en_US');

    if (currency == 'đ' || currency == 'VND') {
      f = new NumberFormat('###,###.#####', 'en_US');
    }

    return '${f.format(money)} $currency';
  }

  static String formatMoneyInt(int money,
      {currency = 'đ', fractionDigits = 0, bool isContract = false}) {
    if (money.isNaN) {
      money = 0;
    }
    String format = '###,##${isContract ? '0.00' : '#.##'}';
    switch (fractionDigits) {
      case 0:
        format = '###,###';
        break;
      case 1:
        format = '###,##${isContract ? '0.0' : '#.#'}';
        break;
      case 2:
        format = '###,##${isContract ? '0.00' : '#.##'}';
        break;
      case 3:
        format = '###,##${isContract ? '0.000' : '#.###'}';
        break;
      case 4:
        format = '###,###${isContract ? '0.0000' : '#.####'}';
        break;
      case 5:
        format = '###,##${isContract ? '0.00000' : '#.#####'}';
        break;
    }
    var f = new NumberFormat(format, 'en_US');

    if (currency == 'đ' || currency == 'VND') {
      f = new NumberFormat('###,###.#####', 'en_US');
    }

    return '${f.format(money)} $currency';
  }

  static String formatNumber(double number,
      {fractionDigits = 0, bool isContract = false}) {
    if (number.isNaN) {
      number = 0;
    }
    String format = '###,##${isContract ? '0.00' : '#.##'}';
    switch (fractionDigits) {
      case 0:
        format = '###,###';
        break;
      case 1:
        format = '###,##${isContract ? '0.0' : '#.#'}';
        break;
      case 2:
        format = '###,##${isContract ? '0.00' : '#.##'}';
        break;
      case 3:
        format = '###,##${isContract ? '0.000' : '#.###'}';
        break;
      case 4:
        format = '###,###${isContract ? '0.0000' : '#.####'}';
        break;
      case 5:
        format = '###,##${isContract ? '0.00000' : '#.#####'}';
        break;
    }
    final f = new NumberFormat(format, 'en_US');

    return f.format(number);
  }

  static int getFractionDigits(double minimumPriceFluctuation) {
    final decimalPointIndex = minimumPriceFluctuation.toString().indexOf('.');
    return decimalPointIndex < 0
        ? 0
        : minimumPriceFluctuation
        .toString()
        .substring(decimalPointIndex + 1)
        .length;
  }

  String getImageUrl({required String key}) {
    final client = 'https://oke_car_flutter.vn';
    return client + key;
  }

  String hosting({required String key}) {
    final client = 'https://oke_car_flutter.vn/';
    return client + key;
  }
  String getImage({required String key}) {
    final client = 'https://testing.hoan-dragon.com/v1/storage';
    return client + key;
  }

  String url({required String key}) {
    final client = 'https://testing.hoan-dragon.com/v1';
    return client + key;
  }

  String carCategory(int index) {
    switch (index) {
      case 1 : return 'Xe tải';
      case 0 : return 'Xe hơi';
      default : return 'Xe tải';
    }
  }

  String status(String status) {
    switch (status) {
      case 'PENDING' : return 'Đang chờ duyệt';
      case 'APPROVED' : return 'Đã duyệt';
      case 'IS_BLOCKED' : return 'Đã bị từ chối';
      default : return 'Bị từ chối';
    }
  }

  String origin(String value) {
    switch (value) {
      case 'DOMESTIC' : return '';
      case 'IMPORT' : return 'Nhập khẩu';
      default : return 'Nội địa';
    }
  }

  Color statusColr(String index) {
    switch (index) {
      case 'PENDING' : return Get.context!.theme.highlightColor;
      case 'APPROVED' : return Get.context!.theme.primaryColorLight;
      default : return Get.context!.theme.primaryColor;
    }
  }

// String getImageUrl(String? key) {
//   final UploadClient client = UploadClient();
//   if (key == null) {
//     return client.uploadServiceBaseUrl;
//   } else if (key.contains('kyc-image')) {
//     return client.uploadServiceBaseUrl + '/admin' + key;
//   } else
//     return client.uploadServiceBaseUrl + key;
// }
}
