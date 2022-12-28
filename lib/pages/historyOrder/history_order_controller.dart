import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/constants/app_constant.dart';
import 'package:oke_car_flutter/databases/user_db.dart';
import 'package:oke_car_flutter/models/product.model.dart';
import 'package:oke_car_flutter/models/user_model.dart';
import 'package:oke_car_flutter/pages/historyOrder/order_model.dart';
import 'package:oke_car_flutter/pages/splash/model/meta_pagination_model.dart';
import 'package:oke_car_flutter/repositories/authenticate_client.dart';
import 'package:oke_car_flutter/utils/error_util.dart';

class HistoryOrderController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final AuthenticateClient client;

  HistoryOrderController({required this.client});

  int? tabSelected;
  final ctlRefresh = EasyRefreshController();
  late TabController tabController;
  var loading = false.obs;
  final listSellingOrder = <OrderModel>[].obs;
  final listBuyingOrder = <OrderModel>[].obs;
  final listBought = <OrderModel>[].obs;
  final listSelled = <OrderModel>[].obs;
  final meta = MetaPaginationModel().obs;
  final user = UserModel().obs;

  @override
  void onInit() {
    super.onInit();
    user.value = UserDB().currentUser() ?? UserModel();
    tabController = TabController(vsync: this, length: 4);
    tabController.addListener(onSelectedTab);
    init();
  }

  init() async {
    fetchDataForSelling();
    fetchDataForBuying();
    fetchDataForBought();
    fetchDataForSelled();
  }

  onSelectedTab() async {
    tabSelected = tabController.index;
  }

  Future<void> onRefresh() async {
    ctlRefresh.resetLoadState();
    ctlRefresh.finishRefresh();
  }

  fetchDataForSelling() async {
    loading.value = true;
    await client.getOrderSeller(sellerId: user.value.id).then((response) async {
      listSellingOrder.assignAll((response.data['data'] as List)
          .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
          .toList());
      meta.value = MetaPaginationModel.fromJson(response.data['meta']);
      print(listSellingOrder.length);
      loading.value = false;
    }).catchError((error, trace) async {
      loading.value = false;
      ErrorUtil.catchError(error, trace);
    });
  }

  fetchDataForBuying() async {
    await client.getOrderBuyer(buyerId: user.value.id).then((response) async {
      listBuyingOrder.assignAll((response.data['data'] as List)
          .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
          .toList());
      meta.value = MetaPaginationModel.fromJson(response.data['meta']);
    }).catchError((error, trace) async {
      ErrorUtil.catchError(error, trace);
    });
  }

  fetchDataForBought() async {
    await client
        .getOrderBuyer(buyerId: user.value.id, status: DONE)
        .then((response) async {
      listBought.assignAll((response.data['data'] as List)
          .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
          .toList());
      meta.value = MetaPaginationModel.fromJson(response.data['meta']);
    }).catchError((error, trace) async {
      ErrorUtil.catchError(error, trace);
    });
  }

  fetchDataForSelled() async {
    await client
        .getOrderSeller(sellerId: user.value.id, status: DONE)
        .then((response) async {
      listSelled.assignAll((response.data['data'] as List)
          .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
          .toList());
      meta.value = MetaPaginationModel.fromJson(response.data['meta']);
    }).catchError((error, trace) async {
      ErrorUtil.catchError(error, trace);
    });
  }

  int? total() {
    return listBuyingOrder
        .map((item) => item.product?.price)
        .reduce((ele1, ele2) => ele1! + ele2!);
  }

  int? totalListBougt() {
    return listBought
        .map((item) => item.product?.price)
        .reduce((ele1, ele2) => ele1! + ele2!);
  }

  int? totalListSell() {
    return listSellingOrder
        .map((item) => item.product?.price)
        .reduce((ele1, ele2) => ele1! + ele2!);
  }

  int? totalListSelled() {
    return listSelled
        .map((item) => item.product?.price)
        .reduce((ele1, ele2) => ele1! + ele2!);
  }
}
