import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/constants/config_constant.dart';
import 'package:oke_car_flutter/databases/config_db.dart';
import 'package:oke_car_flutter/databases/user_db.dart';
import 'package:oke_car_flutter/models/config_model.dart';
import 'package:oke_car_flutter/models/product.model.dart';
import 'package:oke_car_flutter/models/user_model.dart';
import 'package:oke_car_flutter/pages/home/controller/home_controller.dart';
import 'package:oke_car_flutter/repositories/authenticate_client.dart';
import 'package:oke_car_flutter/routes/app_pages.dart';
import 'package:oke_car_flutter/utils/app_util.dart';
import 'package:oke_car_flutter/utils/error_util.dart';

class SearchController extends GetxController {
  final AuthenticateClient client;

  SearchController({required this.client});

  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocus = FocusNode();
  final keyword = ''.obs;
  final loading = false.obs;
  List<String> matches = [];
  final listNFT = <ProductModel>[].obs;
  final showResult = false.obs;
  final loadingUser = false.obs;
  final loadingNFT = false.obs;
  final loadingCollection = false.obs;
  final hasToken =
      (ConfigDB().getConfigByName(CONFIG_ACCESS_TOKEN) ?? '').isNotEmpty;
  final user = UserModel().obs;
  final listSimple = [0, 1, 2];

  @override
  void onInit() {
    user.value = UserDB().currentUser() ?? UserModel();
    String noteOfAccountant =
        ConfigDB().getConfigByName(CONFIG_HISTORY_SEARCH) ?? '';
    matches = noteOfAccountant.split('-');
    super.onInit();
  }

  @override
  void onClose() {
    searchController.dispose();
    searchFocus.dispose();
    super.onClose();
  }

  resetFocus() {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
  }

  onSearchKeyword(String value) {
    keyword.value = value;
    if (keyword.value.isNotEmpty) {
      Future.delayed(const Duration(milliseconds: 1000)).then((_) async {
        init();
      });
    }
  }

  init() {
    searchNFT();
  }

  onSaveHistorySearch(String value) async {
    final String searchKey =
        ConfigDB().getConfigByName(CONFIG_HISTORY_SEARCH) ?? '';
    List<String> listSearch = searchKey.split('-');
    if (!listSearch.contains(value)) {
      if (listSearch.length >= 5) {
        listSearch.removeLast();
      }
      listSearch.insert(0, value);
    }
    String keySearch = listSearch.join('-');
    await ConfigDB().save(ConfigModel(CONFIG_HISTORY_SEARCH, keySearch));
    if (!matches.contains(value)) {
      if (matches.length >= 5) {
        matches.removeLast();
      }
      matches.insert(0, value);
    }
  }

  searchNFT() async {
    loadingNFT.value = true;
    await client.search(keyword.value).then((response) async {
      if (response.data['data'] != null) {
        listNFT.assignAll((response.data['data'] as List)
            .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
            .toList());
      }
      loadingNFT.value = false;
    }).catchError((error, trace) {
      ErrorUtil.catchError(error, trace);
    });
  }

  goToAllNFT() {
    // Get.toNamed(Routes.ALL_SEARCH_RESULT, arguments: {
    //   'keyword': keyword.value,
    //   'type': 0,
    // });
  }
}
