import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/models/product.model.dart';
import 'package:oke_car_flutter/repositories/authenticate_client.dart';
import 'package:oke_car_flutter/utils/error_util.dart';

import '../../../utils/dialog_util.dart';
import '../../../utils/object_util.dart';
import '../../../widgets/popupMenu/popup_menu.dart';
import '../../splash/model/meta_pagination_model.dart';

class NewsManganerController extends GetxController {
  final AuthenticateClient client;

  NewsManganerController({required this.client});

  final loadingListLatest = false.obs;
  PopupMenu? menuFilterUser;
  var filterUserRole = 'All'.obs;
  final ctrRefresh = EasyRefreshController();
  final listLatestPost = <ProductModel>[].obs;
  final meta = MetaPaginationModel().obs;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  init() async {
    await fetchLatestPost();
  }

  Future<void> onRefresh() async {
    fetchLatestPost();
    ctrRefresh.resetLoadState();
    ctrRefresh.finishRefresh();
  }

  fetchLatestPost() async {
    loadingListLatest.value = true;
    await client.fetchAdminProduct().then((response) async {
      listLatestPost.assignAll((response.data['data'] as List)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList());
      meta.value = MetaPaginationModel.fromJson(response.data['meta']);

      loadingListLatest.value = false;
    }).catchError((error, trace) async {
      loadingListLatest.value = false;
      String? msg = ErrorUtil.getError(error, trace);
      if (ObjectUtil.isNotEmpty(msg)) {
        DialogUtil.showErrorMessage(msg!.tr);
      } else {
        DialogUtil.showErrorMessage('SYSTEM_ERROR'.tr);
      }
    });
  }

  Future<void> onLoading() async {
    await client
        .fetchLatestCar(
      offset: listLatestPost.length,
    )
        .then((response) async {
      listLatestPost.addAll((response.data['data'] as List)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList());
    }).catchError((error, trace) {
      ErrorUtil.catchError(error, trace);
    });
    ctrRefresh.finishLoad(noMore: listLatestPost.length >= meta.value.total);
  }
}
