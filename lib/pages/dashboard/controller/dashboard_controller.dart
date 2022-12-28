import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/constants/app_constant.dart';
import 'package:oke_car_flutter/databases/user_db.dart';
import 'package:oke_car_flutter/models/banner_model.dart';
import 'package:oke_car_flutter/models/blog_model.dart';
import 'package:oke_car_flutter/models/product.model.dart';
import 'package:oke_car_flutter/models/user_model.dart';
import 'package:oke_car_flutter/pages/dashboard/model/car_company_model.dart';
import 'package:oke_car_flutter/pages/dashboard/model/car_model.dart';
import 'package:oke_car_flutter/pages/dashboard/model/showroom_model.dart';
import 'package:oke_car_flutter/pages/home/controller/home_controller.dart';
import 'package:oke_car_flutter/repositories/authenticate_client.dart';
import 'package:oke_car_flutter/routes/app_pages.dart';
import 'package:oke_car_flutter/utils/app_util.dart';
import 'package:oke_car_flutter/utils/dialog_util.dart';
import 'package:oke_car_flutter/utils/error_util.dart';
import 'package:oke_car_flutter/utils/object_util.dart';
import 'package:oke_car_flutter/widgets/custom/custom_web.dart';
import 'package:url_launcher/url_launcher.dart';

class DashBoardController extends GetxController {
  final AuthenticateClient client;

  DashBoardController({required this.client});

  final user = UserModel().obs;
  final bannerIndex = 0.obs;
  final listLatestPost = <ProductModel>[].obs;
  final listVipPost = <CarModel>[].obs;
  var totalPost = 0.obs;
  final ctrRefresh = EasyRefreshController();
  final scrollController = ScrollController();
  final listShowroom = <ShowRoomModel>[].obs;
  final listCarModel = <CarCompanyModel>[].obs;
  final listFullCar = <CarCompanyModel>[].obs;
  final listBanner = [
    'assets/banner1.jpeg',
    'assets/banner-bang-oto-1-1440x648.jpg',
    'assets/banner-quang-cao-khuyen-mai-sang-trong_103212930.jpg',
  ];
  final loadingListBlog = false.obs;
  final loadingListLatest = false.obs;
  final loadingListVip = false.obs;
  final headerOffset = 0.0.obs;
  final List<String> text = [
    "Honda HR-V 2022 ra mắt tại Việt Nam, giá từ 826 triệu đồng",
    "VinFast VF8 đã được cấp giấy chứng nhận chất lượng tại Việt Nam"
  ];
  final isShowAction = false.obs;
  var blogs = [];

  @override
  void onInit() {
    user.value = UserDB().currentUser() ?? UserModel();
    init();
    super.onInit();
  }

  showAction() {
    isShowAction.value = !isShowAction.value;
  }

  @override
  void onClose() {
    super.onClose();
  }

  init() {
    fetchLatestPost();
    fetchCarModel();
  }

  setOFFSET(double value) {
    headerOffset.value = value;
  }

  Future<void> onRefresh() async {
    init();
    ctrRefresh.resetLoadState();
    ctrRefresh.finishRefresh();
  }

  fetchLatestPost() async {
    loadingListLatest.value = true;
    await client.fetchLatestCar(status: APPROVED).then((response) async {
      listLatestPost.assignAll((response.data['data'] as List)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList());
      loadingListLatest.value = false;
    }).catchError((error, trace) async {
      print(error);
      print(trace);
      loadingListLatest.value = false;
      String? msg = ErrorUtil.getError(error, trace);
      if (ObjectUtil.isNotEmpty(msg)) {
        DialogUtil.showErrorMessage(msg!.tr);
      } else {
        DialogUtil.showErrorMessage('SYSTEM_ERROR'.tr);
      }
    });
  }

  goViewAll() {
    Get.toNamed(Routes.PRODUCT);
    // home.onSelectedItem(1);
  }

  fetchCarModel() async {
    await client.getCarCompanyByType().then((response) async {
      if (response.data != null) {
        listCarModel.assignAll((response.data['data'] as List)
            .map((e) => CarCompanyModel.fromJson(e as Map<String, dynamic>))
            .toList());
      }
    }).catchError((error, trace) async {
      print(error);
      print(trace);
      String? msg = ErrorUtil.getError(error, trace);
      if (ObjectUtil.isNotEmpty(msg)) {
        DialogUtil.showErrorMessage(msg!.tr);
      } else {
        DialogUtil.showErrorMessage('SYSTEM_ERROR'.tr);
      }
    });
  }

  launchNumber(String phoneNumber) async {
    String url = "tel://" + phoneNumber;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not call';
    }
  }

  openPriceWeb(String url) {
    Get.to(() => CustomWebView(url: AppUtil().hosting(key: url + '?t=mobile')));
  }
}
