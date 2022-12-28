import 'package:adjust_sdk/adjust.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LifeCycleController extends SuperController {


  @override
  void onDetached() {
    debugPrint('onDetached');
  }

  @override
  void onInactive() {
    debugPrint('onInactive');
  }

  @override
  void onPaused() {
    debugPrint('onPaused');
    Adjust.onPause();
  }

  @override
  Future<void> onResumed() async {
    debugPrint('onResumed before');
    if (!kDebugMode) {
      Adjust.onResume();
    }

  }
}
