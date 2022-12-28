import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/repositories/authenticate_client.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

import '../../../models/image_model.dart';
import '../../../utils/dialog_util.dart';
import '../../../utils/error_util.dart';
import '../../../utils/object_util.dart';
import '../../../widgets/camera_vietnamese_text_delegate.dart';
import '../../../widgets/vietnamese_text_delegate.dart';
import '../../dashboard/model/car_company_model.dart';

class CarCompanyController extends GetxController {
  final ctrRefresh = EasyRefreshController();
  final AuthenticateClient client;

  final listFullCar = <CarCompanyModel>[].obs;
  dynamic pickImageError;

  CarCompanyController({required this.client});

  final imageCar = ImageModel().obs;
  final TextEditingController titleCarController = TextEditingController();
  final FocusNode titleCarFocus = FocusNode();
  final isEdit = false.obs;
  final idCar = ''.obs;

  Future<void> onRefresh() async {
    fetchFullCarModel();
    ctrRefresh.resetLoadState();
    ctrRefresh.finishRefresh();
  }

  resetFocus() {
    FocusScope.of(Get.context!).requestFocus(new FocusNode());
  }

  @override
  void onInit() {
    init();
    super.onInit();
  }

  init() async {
    await fetchFullCarModel();
  }

  setEdit(CarCompanyModel model) {
    isEdit.value = true;
    imageCar.value = model.avatar ?? ImageModel();
    titleCarController.text = model.name;
    idCar.value = model.id;
  }

  setAdd() {
    isEdit.value = false;
    imageCar.value = ImageModel();
    titleCarController.clear();
  }

  fetchFullCarModel() async {
    await client.getCarCompanyByType().then((response) async {
      if (response.data != null) {
        listFullCar.assignAll((response.data['data'] as List)
            .map((e) => CarCompanyModel.fromJson(e as Map<String, dynamic>))
            .toList());
      }
    }).catchError((error, trace) async {
      String? msg = ErrorUtil.getError(error, trace);
      if (ObjectUtil.isNotEmpty(msg)) {
        DialogUtil.showErrorMessage(msg!.tr);
      } else {
        DialogUtil.showErrorMessage('SYSTEM_ERROR'.tr);
      }
    });
  }

  uploadMedia() async {
    try {
      final List<AssetEntity>? assets = await AssetPicker.pickAssets(
        Get.context!,
        pickerConfig: AssetPickerConfig(
          maxAssets: 1,
          requestType: RequestType.image,
          textDelegate: VietnameseTextDelegate(),
          specialItemPosition: SpecialItemPosition.prepend,
          specialItemBuilder:
              (BuildContext context, AssetPathEntity? path, int length) {
            if (path?.isAll != true) {
              return null;
            }

            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () async {
                final AssetEntity? result = await CameraPicker.pickFromCamera(
                  Get.context!,
                  pickerConfig: CameraPickerConfig(
                    enableRecording: false,
                    textDelegate: CameraVietnamTextDelegate(),
                  ),
                );
                if (result != null) {
                  final File? image = await result.file;
                  if (image != null) {
                    final Directory appDirectory =
                        await getApplicationDocumentsDirectory();
                    final String path = appDirectory.path;
                    File? compressedImage =
                        await FlutterImageCompress.compressAndGetFile(
                      image.path,
                      '$path/${image.path.split('/').last}',
                      quality: 50,
                    );
                    DialogUtil.showProgressDialog(Get.context!);
                    await client
                        .uploadImage(compressedImage!)
                        .then((response) async {
                      imageCar.value =
                          ImageModel.fromJson(response.data['data']);
                      imageCar.refresh();
                      print(imageCar);
                    }).catchError((error, trace) async {
                      ErrorUtil.catchError(error, trace);
                    });
                  }
                  Get.back();
                  Get.back();
                  if (Get.isDialogOpen ?? false) {
                    Get.back();
                  }
                  // handleResult(context, result);
                }
              },
              child: const Center(
                child: Icon(Icons.camera_enhance, size: 42.0),
              ),
            );
          },
        ),
      );

      if (assets != null && assets.isNotEmpty) {
        final File? image = await assets.first.file;
        if (image != null) {
          final Directory appDirectory =
              await getApplicationDocumentsDirectory();
          final String path = appDirectory.path;
          File? compressedImage = await FlutterImageCompress.compressAndGetFile(
            image.path,
            '$path/${image.path.split('/').last}',
            quality: 50,
          );
          DialogUtil.showProgressDialog(Get.context!);
          await client.uploadImage(compressedImage!).then((response) async {
            imageCar.value = ImageModel.fromJson(response.data['data']);
            imageCar.refresh();
          }).catchError((error, trace) async {
            ErrorUtil.catchError(error, trace);
          });
        }

        Get.back();
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
      }
    } catch (e) {
      pickImageError = e;
    }
  }

  addNewCarCompany() async {
    if (titleCarController.text.isEmpty) {
      return DialogUtil.showErrorMessage('Vui lòng nhập tên hãng xe');
    }
    final data = {"avatar": imageCar.value, "name": titleCarController.text};
    await client.addCar(data).then((response) async {
      if (response.data['data'] != null) {
        final CarCompanyModel carCompanyModel =
            CarCompanyModel.fromJson(response.data['data']);
        listFullCar.insert(0, carCompanyModel);
        listFullCar.refresh();
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
    final data = {"avatar": imageCar.value, "name": titleCarController.text};
    await client.edit(id, data).then((response) async {
      if (response.data['data'] != null) {
        final index = listFullCar.indexWhere((element) => element.id == id);
        listFullCar[index].name = titleCarController.text;
        listFullCar[index].avatar == imageCar.value;
        listFullCar.refresh();
        DialogUtil.showSuccessMessage(
          'Thêm thông tin thành công'.tr,
        );
        Get.back();
      }
    }).catchError((error, trace) {
      ErrorUtil.catchError(error, trace);
    });
  }
}
