import 'package:get/get.dart' show RxBool;
import 'package:rxdart/rxdart.dart';

extension FutureEx<T> on Future<T> {
  Future<T> loading(RxBool loading) => Stream<T>.fromFuture(this)
      .doOnListen(() => loading.value = true)
      .doOnDone(() => loading.value = false)
      .single;
}

extension FutureFuncEx<T> on Future<T> Function() {
  Future<T> loading(RxBool loading) => this().loading(loading);
}