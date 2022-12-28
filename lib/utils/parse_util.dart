import 'package:oke_car_flutter/constants/app_constant.dart';
import 'package:intl/intl.dart';
import 'package:oke_car_flutter/helpers/extension/validator.dart';

class ParseUtil {
  static int parseInt(dynamic s) {
    if (s is double) {
      return s.toInt();
    }

    if (s is String) {
      if (s.isEmpty) {
        return 0;
      }

      s = s.replaceAll(',', '');

      return int.parse(s);
    }

    if (s is int) {
      return s;
    }

    return 0;
  }

  static double parseDouble(dynamic s) {
    if (s is double) {
      return s;
    }

    if (s is String) {
      if (s.isEmpty) {
        return 0.0;
      }

      s = s.replaceAll(',', '');

      return double.parse(s);
    }

    if (s is int) {
      return s + .0;
    }

    return 0;
  }

  static bool parseBool(dynamic s) {
    if (s is String) {
      if (s.isEmpty) {
        return false;
      }

      return TRUE == s;
    }

    if (s is bool) {
      return s;
    }

    return false;
  }

  static double parseNumber(String? stringNumber) {
    if (stringNumber == null || stringNumber.isEmpty) {
      return 0.0;
    }

    stringNumber = stringNumber.replaceAll(',', '');
    if (!stringNumber.isNumeric()) {
      return 0.0;
    }

    final f = new NumberFormat('###,###.##', 'en_US');
    return f.parse(stringNumber).toDouble();
  }
}
