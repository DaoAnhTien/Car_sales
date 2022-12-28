import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/constants/app_constant.dart';
import 'package:oke_car_flutter/databases/user_db.dart';
import 'package:oke_car_flutter/models/image_model.dart';
import 'package:oke_car_flutter/models/user_model.dart';
import 'package:oke_car_flutter/pages/post/post_dashboard/model/version_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:oke_car_flutter/models/vehicle_model.dart';
import 'package:oke_car_flutter/pages/dashboard/model/car_company_model.dart';
import 'package:oke_car_flutter/pages/post/post_dashboard/model/image_upload.dart';
import 'package:oke_car_flutter/pages/post/post_dashboard/model/info_post_model.dart';
import 'package:oke_car_flutter/pages/post/post_dashboard/model/info_value.dart';
import 'package:oke_car_flutter/repositories/authenticate_client.dart';
import 'package:oke_car_flutter/utils/dialog_util.dart';
import 'package:oke_car_flutter/utils/error_util.dart';
import 'package:oke_car_flutter/utils/object_util.dart';
import 'package:oke_car_flutter/widgets/camera_vietnamese_text_delegate.dart';
import 'package:oke_car_flutter/widgets/vietnamese_text_delegate.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';
import 'package:oke_car_flutter/helpers/extension/validator.dart';

class PostController extends GetxController {
  final AuthenticateClient client;

  //images

  dynamic pickImageError;

  final pageController = PageController();
  var activeStep = 0.obs;

  PostController({required this.client});

  final TextEditingController carCompanySearch = TextEditingController();
  final FocusNode carCompanyFocus = FocusNode();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController youtubeController = TextEditingController();
  final TextEditingController titleCarController = TextEditingController();
  final TextEditingController describeCarController = TextEditingController();
  final TextEditingController citySearchController = TextEditingController();
  final TextEditingController versionCarController = TextEditingController();
  final FocusNode searchFocus = FocusNode();
  final FocusNode titleCarFocus = FocusNode();
  final FocusNode describeCarFocus = FocusNode();
  final FocusNode versionFocus = FocusNode();
  final FocusNode youtubFocus = FocusNode();
  final FocusNode priceFocus = FocusNode();
  final FocusNode nameFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode addressFocus = FocusNode();
  var carCompanySearchValue = ''.obs;
  var carLineSearchValue = ''.obs;
  var carCompanyValue = CarCompanyModel().obs;
  var carLine = VehicleModel().obs;
  var versionValue = VersionModel().obs;
  final imageCar = ImageModel().obs;
  final userValue = UserModel().obs;
  final listFullCar = <CarCompanyModel>[].obs;
  final listCarLine = <VehicleModel>[].obs;
  final listVersion = <VersionModel>[].obs;
  final year = '2022'.obs;
  final location = ''.obs;
  final listCarInfo = <InfoPostModel>[].obs;

  final origin = LIST_ORIGIN;
  final carStyling = InfoPostModel().obs;
  final fuel = ''.obs;
  final carStatus = LIST_CAR_STATUS;
  final gear = LIST_GEAR;
  final weight = InfoPostModel().obs;
  var versionValid = true.obs;
  final originValue = ''.obs;
  final fuelValue = ''.obs;
  final carStatusValue = ''.obs;
  final carColorValue = ''.obs;
  final gearValue = ''.obs;
  var titleLength = 0.obs;
  var desLength = 0.obs;
  var titleValue = true.obs;
  var desValue = true.obs;
  var listCar = <ImageModel>[].obs;

  var loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFullCarModel();
    userValue.value = UserDB().currentUser() ?? UserModel();
    if (ObjectUtil.isNotEmpty(userValue.value.fullName)) {
      nameController.text = userValue.value.fullName;
    } else {
      nameController.clear();
    }
    if (ObjectUtil.isNotEmpty(userValue.value.phone)) {
      phoneController.text = userValue.value.phone;
    } else {
      phoneController.clear();
    }
    if (ObjectUtil.isNotEmpty(userValue.value.address)) {
      addressController.text = userValue.value.address;
    } else {
      addressController.clear();
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  resetFocus() {
    FocusScope.of(Get.context!).requestFocus(new FocusNode());
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
                      listCar.insert(0, imageCar.value);
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
            listCar.insert(0, imageCar.value);
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

  nextScreen() {
    if (activeStep < 2) {
      activeStep.value++;
    }
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

  fetchCarLine() async {
    await client
        .getListVehicleByCarId(brandId: carCompanyValue.value.id)
        .then((response) async {
      if (response.data != null) {
        listCarLine.assignAll((response.data['data'] as List)
            .map((e) => VehicleModel.fromJson(e as Map<String, dynamic>))
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

  fetchVersion() async {
    await client.getVersion(brandId: carLine.value.id).then((response) async {
      if (response.data != null) {
        listVersion.assignAll((response.data['data'] as List)
            .map((e) => VersionModel.fromJson(e as Map<String, dynamic>))
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

  handleSearchBranch(String value) {
    carCompanySearchValue.value = value;
  }

  handleVersion(String value) {
    versionValid.value = versionCarController.text.isNotEmpty;
  }

  handleCarLine(String value) {
    carLineSearchValue.value = value;
  }

  setYear(String value) {
    year.value = value;
    FocusScope.of(Get.context!).requestFocus(new FocusNode());
    Get.back();
  }

  setCarCompany(CarCompanyModel model) {
    if (model != carCompanyValue.value) {
      carLine.value = VehicleModel();
    }
    FocusScope.of(Get.context!).requestFocus(new FocusNode());
    carCompanyValue.value = model;
    fetchCarLine();
    Get.back();
  }

  setCarline(VehicleModel model) {
    carLine.value = model;
    fetchVersion();
    FocusScope.of(Get.context!).requestFocus(new FocusNode());
    Get.back();
  }

  setVersion(VersionModel model) {
    versionValue.value = model;
    FocusScope.of(Get.context!).requestFocus(new FocusNode());
    Get.back();
  }

  setOrigin(String value) {
    originValue.value = value;
    Get.back();
  }

  setFuleCar(String valueModel) {
    fuelValue.value = valueModel;
    Get.back();
  }

  setLocation(String valueModel) {
    location.value = valueModel;
    Get.back();
  }

  setCarStatus(String valueModel) {
    carStatusValue.value = valueModel;
    Get.back();
  }

  setCarColor(String valueModel) {
    carColorValue.value = valueModel;
    Get.back();
  }

  setGerCar(String valueModel) {
    gearValue.value = valueModel;
    Get.back();
  }

  resetInfo() {
    carCompanyValue.value = CarCompanyModel();
    carLine.value = VehicleModel();
    originValue.value = '';
    versionCarController.text = '';
    fuelValue.value = '';
    carStatusValue.value = '';
    carColorValue.value = '';
    gearValue.value = '';
  }

  bool isValidUpload() {
    return listCar.isNotEmpty;
  }

  bool isValidInfoXeHoi() {
    return carCompanyValue.value.name.isNotEmpty &&
        carLine.value.title.isNotEmpty &&
        originValue.value.isNotEmpty &&
        fuelValue.value.isNotEmpty &&
        versionCarController.text.isNotEmpty &&
        carColorValue.value.isNotEmpty &&
        carStatusValue.value.isNotEmpty &&
        gearValue.value.isNotEmpty;
  }

  bool isValidInfoXCar() {
    return carCompanyValue.value.name.isNotEmpty &&
        carLine.value.name.isNotEmpty &&
        originValue.value.isNotEmpty &&
        versionCarController.text.isNotEmpty &&
        versionValid.value &&
        fuelValue.value.isNotEmpty &&
        carStatusValue.value.isNotEmpty;
  }

  onChangeTitle(String value) {
    titleValue.value = titleCarController.text.isNotEmpty;
    titleLength.value = value.length;
  }

  onDesChange(String value) {
    desValue.value = describeCarController.text.isNotEmpty;
    desLength.value = value.length;
  }

  bool isValid() {
    if (activeStep == 0) {
      return isValidUpload();
    } else if (activeStep == 1) {
      return isValidInfoXCar();
    } else if (activeStep == 2) {
      return true;
    }
    return true;
  }

  checkValid() {
    if (titleCarController.text.isEmpty) {
      return DialogUtil.showErrorToast('Vui lòng nhập tiêu để');
    }
    if (describeCarController.text.isEmpty) {
      return DialogUtil.showErrorToast('Vui lòng nhập mô tả');
    }
    if (titleLength.value < 50) {
      return DialogUtil.showErrorToast('Tiêu đề phải có từ 50 kí tự trở lên');
    }
    if (desLength.value < 50) {
      return DialogUtil.showErrorToast('Mô tả phải có từ 50 kí tự trở lên');
    }
    return activeStep.value++;
  }

  postNews() async {
    if (nameController.text.isEmpty) {
      return DialogUtil.showErrorToast('Vui lòng nhập họ tên');
    }
    if (phoneController.text.isEmpty) {
      return DialogUtil.showErrorToast('Vui lòng nhập Số điện thoại');
    }

    if (!phoneController.text.isValidPhone()) {
      return DialogUtil.showErrorToast('Số điện thoại chưa đúng định dạng');
    }
    if (addressController.text.isEmpty) {
      return DialogUtil.showErrorToast('Vui lòng nhập địa chỉ');
    }
    var amount =
        priceController.text.isNotEmpty ? priceController.text.trim() : '0';
    double amountDouble = double.parse(amount.replaceAll(RegExp(','), ''));
    final data = {
      'carCompanyId': carCompanyValue.value.id,
      'vehiclesId': carLine.value.id,
      'year': int.parse(year.value),
      'version': versionCarController.text,
      'price': amountDouble,
      'avatar': listCar,
      'title': titleCarController.text,
      'description': describeCarController.text,
      'nameSeller': nameController.text,
      'phoneSeller': phoneController.text,
      'addressSeller': addressController.text,
      'video': youtubeController.text,
      'location': location.value,
      'origin': originValue.value,
      'fuel': fuelValue.value,
      'carStatus': carStatusValue.value,
      'color': carColorValue.value,
      'gear': gearValue.value,
    };
    print(data);
    loading.value = true;
    await client.creteNews(data).then((response) async {
      DialogUtil.showSuccessMessage(
          'Tạo tin thành công, chúng tôi sẽ sớm xét duyệt bài đăng của bạn !');
      Get.back();
      loading.value = false;
    }).catchError((error, trace) async {
      DialogUtil.showSuccessToast(
          'Tạo tin thất bại. Vui lòng kiểm tra lại thông tin');
      loading.value = false;
      ErrorUtil.catchError(error, trace);
    });
  }

  removeImage(ImageModel model) {
    listCar.remove(model);
    listCar.refresh();
  }
}
