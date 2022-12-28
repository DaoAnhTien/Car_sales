import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/constants/app_constant.dart';

import '../values/style.dart';

class AuthUtil {
  static AuthUtil instance = new AuthUtil();

  static Color status(String status) {
    switch (status) {
      case PENDING:
        return Style.dialogButtonYesBgColor;
      case APPROVED:
        return Get.context!.theme.colorScheme.secondary;
      case CONFIRMING:
        return Get.context!.theme.primaryColorDark;
      case DONE:
        return Get.context!.theme.primaryColorLight;
      case IS_BLOCKED:
        return Get.context!.theme.primaryColor;
      default:
        return Style.textPrimaryColor;
    }
  }

  static String statusText(String status) {
    switch (status) {
      case CANCEL : return 'Đã huỷ';
      case PENDING:
        return 'Đang chờ duyệt';
      case APPROVED:
        return 'Đặt lịch hẹn';
      case CONFIRMING:
        return 'Đang giao dịch';
      case DONE:
        return 'Đã hoàn thành giao dịch';
      case IS_BLOCKED:
        return 'Bị từ chối';
      default:
        return '';
    }
  }

  static String owner(String status) {
    switch (status) {
      case CANCEL : return 'Đã huỷ';
      case PENDING:
        return 'Đang chờ duyệt';
      case APPROVED:
        return 'Đã duyệt';
      case CONFIRMING:
        return 'Đang giao dịch';
      case DONE:
        return 'Đã hoàn thành giao dịch';
      case IS_BLOCKED:
        return 'Bị từ chối';
      default:
        return '';
    }
  }

  static String textForOwner(String status) {
    switch (status) {
      case CANCEL : return 'Đã huỷ';
      case PENDING:
      case APPROVED:
        return 'Huỷ đăng tin';
      case CONFIRMING:
        return 'Chấp nhận thanh toán';
      case DONE:
        return 'Đã hoàn thành giao dịch';
      case IS_BLOCKED:
        return 'Bị từ chối';
      default:
        return '';
    }
  }
}
