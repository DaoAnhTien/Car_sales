import 'package:flutter/cupertino.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/constants/app_constant.dart';
import 'package:oke_car_flutter/models/SubBranchModel.dart';
import 'package:oke_car_flutter/models/color_model.dart';
import 'package:oke_car_flutter/pages/dashboard/model/car_company_model.dart';
import 'package:oke_car_flutter/pages/dashboard/model/car_model.dart';
import 'package:oke_car_flutter/pages/product/product_dashboard/model/sort_model.dart';
import 'package:oke_car_flutter/pages/splash/model/meta_pagination_model.dart';
import 'package:oke_car_flutter/repositories/authenticate_client.dart';
import 'package:oke_car_flutter/utils/dialog_util.dart';
import 'package:oke_car_flutter/utils/error_util.dart';
import 'package:oke_car_flutter/utils/object_util.dart';

import '../../../../models/product.model.dart';

class ProductController extends GetxController {
  final AuthenticateClient client;

  final isShowAction = false.obs;

  ProductController({required this.client});

  final TextEditingController keywordSearchController = TextEditingController();
  final TextEditingController keywordSubController = TextEditingController();
  final TextEditingController branchController = TextEditingController();
  final TextEditingController keywordSearchAllProductController =
      TextEditingController();
  final FocusNode keywordSearchFocus = FocusNode();
  final FocusNode branchFocus = FocusNode();
  final FocusNode subFocus = FocusNode();
  final FocusNode keywordAllProductFocus = FocusNode();

  final ctlRefresh = EasyRefreshController();
  final listAllProduct = <ProductModel>[].obs;
  final loading = false.obs;
  final meta = MetaPaginationModel().obs;
  final location = ''.obs;
  final year = ''.obs;
  final brandSelect = ''.obs;
  var keyword = ''.obs;
  var keywordBranch = ''.obs;
  var keywordSub = ''.obs;
  final listFullCar = <CarCompanyModel>[].obs;
  final branchSelect = CarCompanyModel().obs;
  final subSelect = SubBranchModel().obs;
  final minPrice = 0.0.obs;
  final maxPrice = 200000000000.0.obs;
  final sortValue = SortModel('newest', 1).obs;
  final colorValue = ColorModel().obs;
  final carStatus = ''.obs;
  final List<SortModel> listSort = [
    SortModel('newest', 1),
    SortModel('alphabetically_zz', 2),
    SortModel('alphabetically_za', 3),
    SortModel('low_to_high_price', 4),
    SortModel('high_to_low_price', 5),
  ];

  final List<ColorModel> listColor = [
    ColorModel(color: 0xff000000, name: 'black'),
    ColorModel(color: 0xffffffff, name: 'white'),
    ColorModel(color: 0xffC0C0C0, name: 'sliver'),
    ColorModel(color: 0xfff30000, name: 'red'),
    ColorModel(color: 0xffA52A2A, name: 'brown'),
    ColorModel(color: 0xff008000, name: 'green'),
    ColorModel(color: 0xff0000FF, name: 'blue'),
    ColorModel(color: 0xffFFFF00, name: 'yellow'),
    ColorModel(color: 0xff2d0606, name: 'cream'),
    ColorModel(color: 0xffef420e, name: 'orange'),
    ColorModel(color: 0xffec7a7a, name: 'pink'),
  ];

  @override
  void onInit() {
    init();
    fetchFullCarModel();
    super.onInit();
  }

  @override
  void onClose() {
    branchController.dispose();
    branchFocus.dispose();
    keywordSearchController.dispose();
    ctlRefresh.dispose();
    keywordSearchFocus.dispose();
    // TODO: implement onClose
    super.onClose();
  }

  init() {
    fetchAllList();
  }

  Future<void> onRefresh() async {
    await fetchAllList();
    ctlRefresh.resetLoadState();
    ctlRefresh.finishRefresh();
  }

  showAction() {
    isShowAction.value = !isShowAction.value;
  }

  fetchAllList() async {
    loading.value = true;
    await client.fetchLatestCar().then((response) async {
      listAllProduct.assignAll((response.data['data'] as List)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList());
      meta.value = MetaPaginationModel.fromJson(response.data['meta']);

      loading.value = false;
    }).catchError((error, trace) async {
      loading.value = false;
      ErrorUtil.catchError(error, trace);
    });
  }

  Future<void> onLoading() async {
    await client
        .fetchLatestCar(
      offset: listAllProduct.length,
    )
        .then((response) async {
      listAllProduct.addAll((response.data['data'] as List)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList());
    }).catchError((error, trace) {
      ErrorUtil.catchError(error, trace);
    });
    ctlRefresh.finishLoad(noMore: listAllProduct.length >= meta.value.total);
  }

  handleSearchCity(String value) {
    keyword.value = value;
  }

  handleSearchBranch(String value) {
    keywordBranch.value = value;
  }

  handleSearchSub(String value) {
    keywordSub.value = value;
  }

  setCitySelected(String city) {
    location.value = city;
  }

  setYear(String value) {
    year.value = value;
    Get.back();
  }

  fetchFullCarModel() async {
    await client.getCarCompanyByType().then((response) async {
      // print(response);
      if (response.data != null) {
        listFullCar.assignAll((response.data['data'] as List)
            .map((e) => CarCompanyModel.fromJson(e as Map<String, dynamic>))
            .toList());
        // BannerDB().save(listBanner.value);
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

  selectBranch(CarCompanyModel model) {
    if (branchSelect.value != model) {
      subSelect.value = SubBranchModel();
      keywordSubController.text = '';
      keywordSub.value = '';
    }
    branchSelect.value = model;
    branchController.text = '';
    keywordBranch.value = '';
    Get.back();
  }

  selectSub(SubBranchModel model) {
    subSelect.value = model;
    keywordSubController.text = '';
    keywordSub.value = '';
    Get.back();
  }

  selectColor(ColorModel model) {
    colorValue.value = model;
    Get.back();
  }

  setDefaultValue(String type) {
    switch (type) {
      case BRANCH:
        branchSelect.value = CarCompanyModel();
        subSelect.value = SubBranchModel();
        branchController.text = '';
        keywordBranch.value = '';
        Get.back();
        break;
      case SUB:
        subSelect.value = SubBranchModel();
        keywordSubController.text = '';
        keywordSub.value = '';
        Get.back();
    }
  }

  setSortValue(SortModel model) {
    sortValue.value = model;
    // Get.back();
    // if (sortValue.value.id == 1) {
    //   fetchAllList();
    // } else if (sortValue.value.id == 2) {
    //   listAllProduct
    //       .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    // } else if (sortValue.value.id == 3) {
    //   listAllProduct
    //       .sort((a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()));
    // } else if (sortValue.value.id == 4) {
    //   listAllProduct.sort((a, b) => a.price.compareTo(b.price));
    // } else {
    //   listAllProduct.sort((a, b) => b.price.compareTo(a.price));
    //   // listAllProduct.reversed.toList();
    // }
  }

  setCarStatus(String value) {
    if (carStatus.value == value) {
      carStatus.value = '';
    } else
      carStatus.value = value;
  }

  cancelFitler() {
    branchSelect.value = CarCompanyModel();
    subSelect.value = SubBranchModel();
    branchController.text = '';
    keywordBranch.value = '';
    location.value = '';
    carStatus.value = '';
    fetchAllList();
    Get.back();
  }

  bool isValid() {
    return branchSelect.value.name == '' || location.value == '';
  }

  confirmFilter() {
    fetchAllList();
    Get.back();
  }

  bool isValidFileter() {
    return branchSelect.value.name == '' &&
        subSelect.value.name == '' &&
        year.value == '' &&
        carStatus.value == '';
  }
}
