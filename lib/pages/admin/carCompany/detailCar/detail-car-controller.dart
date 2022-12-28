import 'package:flutter/cupertino.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/models/vehicle_model.dart';
import 'package:oke_car_flutter/pages/dashboard/model/car_company_model.dart';
import 'package:oke_car_flutter/repositories/authenticate_client.dart';
import 'package:oke_car_flutter/utils/dialog_util.dart';
import 'package:oke_car_flutter/utils/error_util.dart';
import 'package:oke_car_flutter/utils/object_util.dart';

class DetailCarAdminController extends GetxController  {
  final AuthenticateClient client;
  final ctrRefresh = EasyRefreshController();
  final carModel = CarCompanyModel().obs;
  DetailCarAdminController({required this.client});
  final listCarLine = <VehicleModel>[].obs;
  final loading = false.obs;

  final TextEditingController titleCarController = TextEditingController();
  final FocusNode titleCarFocus = FocusNode();
  final isEdit = false.obs;
  final idVehicle = ''.obs;

  @override
  void onInit() {
    if (Get.arguments != null && Get.arguments is CarCompanyModel) {
      carModel.value = Get.arguments;
    }
    init();
    super.onInit();
  }
  init() {
    fetchCarLine();
  }
  Future<void> onRefresh() async {
    fetchCarLine();
    ctrRefresh.resetLoadState();
    ctrRefresh.finishRefresh();
  }

  setEdit(VehicleModel model) {
    isEdit.value = true;
    titleCarController.text = model.name;
    idVehicle.value = model.id;
  }


  fetchCarLine() async {
    loading.value = true;
    await client
        .getListVehicleByCarId(brandId: carModel.value.id)
        .then((response) async {
      if (response.data != null) {
        listCarLine.assignAll((response.data['data'] as List)
            .map((e) => VehicleModel.fromJson(e as Map<String, dynamic>))
            .toList());
      }
      loading.value = false;

    }).catchError((error, trace) async {
      loading.value = false;
      String? msg = ErrorUtil.getError(error, trace);
      if (ObjectUtil.isNotEmpty(msg)) {
        DialogUtil.showErrorMessage(msg!.tr);
      } else {
        DialogUtil.showErrorMessage('SYSTEM_ERROR'.tr);
      }
    });
  }

  setAdd() {
    isEdit.value = false;
    titleCarController.clear();
  }

  resetFocus() {
    FocusScope.of(Get.context!).requestFocus(new FocusNode());
  }

  add() async {
    if (titleCarController.text.isEmpty) {
      return DialogUtil.showErrorMessage('Vui lòng nhập tên hãng xe');
    }
    final data = {"carCompanyId": carModel.value.id, "name": titleCarController.text};
    await client.addVehicle(data).then((response) async {
      if (response.data['data'] != null) {
        final VehicleModel vehicleModel =
        VehicleModel.fromJson(response.data['data']);
        listCarLine.insert(0, vehicleModel);
        listCarLine.refresh();
        DialogUtil.showSuccessMessage(
          'Thêm thông tin thành công'.tr,
        );
        Get.back();
      }
    }).catchError((error, trace) {
      ErrorUtil.catchError(error, trace);
    });
  }

  edit(String id) async {
    if (titleCarController.text.isEmpty) {
      return DialogUtil.showErrorMessage('Vui lòng nhập tên hãng xe');
    }
    final data = {"carCompanyId": carModel.value.id, "name": titleCarController.text};
    await client.editVehicle(id,data).then((response) async {
      if (response.data['data'] != null) {
        final index = listCarLine.indexWhere((element) => element.id == id);
        listCarLine[index].name = titleCarController.text;
        listCarLine.refresh();
        DialogUtil.showSuccessMessage(
          'Chỉ sửa thông tin thành công'.tr,
        );
        Get.back();
      }
    }).catchError((error, trace) {
      ErrorUtil.catchError(error, trace);
    });
  }
}