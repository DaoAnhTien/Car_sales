import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:oke_car_flutter/utils/dialog_util.dart';
import 'package:oke_car_flutter/utils/object_util.dart';

class ErrorUtil {
  static ErrorUtil instance = new ErrorUtil();

  static String? getError(error, trace) {
    String? errorMsg;
    if (error is DioError) {
      if (kDebugMode) {
        print(
            'Error api: ${error.requestOptions.method} ${error.requestOptions.path}');
        print('Error request headers: ${error.requestOptions.headers}');
        print('Error request data: ${error.requestOptions.data}');
        print('Error response: ${error.response?.data}');
      }

      if (error.response?.statusCode == 500 ||
          error.response?.statusCode == 501 ||
          error.response?.statusCode == 502 ||
          error.response?.statusCode == 503) {
        return 'SYSTEM_ERROR';
      }

      if (error.response?.data is String) {
        errorMsg =
            '${error.requestOptions.path}\n${error.response?.data?.toString() ?? ''}';
      } else {
        if (error.response?.data != null &&
            error.response?.data['message'] != null) {
          errorMsg = error.response?.data['message'][0];
          if (errorMsg == 'INVALID_TOKEN') {
            // Get.offAllNamed(Routes.ON_BOARDING_AUTH);
          }
        } else {
          if (error.response?.data == null) {
            errorMsg = 'SERVER_NOT_RESPONDING';
          } else {
            errorMsg = error.requestOptions.path + '\n' + error.toString();
          }
        }
      }
    } else {
      errorMsg = error.toString();
    }

    return errorMsg;
  }

  static FutureOr<Null> catchError(error, trace) {
    if (kDebugMode) {
      print(error);
      print(trace);
    }
    String? msg = ErrorUtil.getError(error, trace);
    if (ObjectUtil.isNotEmpty(msg)) {
      DialogUtil.showErrorMessage(msg!.tr);
    } else {
      DialogUtil.showErrorMessage(error.toString());
    }

    return Future.value(null);
  }
}
