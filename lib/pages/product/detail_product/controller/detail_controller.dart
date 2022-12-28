import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/constants/app_constant.dart';
import 'package:oke_car_flutter/databases/user_db.dart';
import 'package:oke_car_flutter/models/product.model.dart';
import 'package:oke_car_flutter/models/user_model.dart';
import 'package:oke_car_flutter/pages/admin/news-manganer/news-manganer-controller.dart';
import 'package:oke_car_flutter/pages/product/detail_product/model/create_order_model.dart';
import 'package:oke_car_flutter/utils/date_util.dart';
import 'package:share_plus/share_plus.dart';
import 'package:oke_car_flutter/pages/dashboard/model/car_model.dart';
import 'package:oke_car_flutter/repositories/authenticate_client.dart';
import 'package:oke_car_flutter/utils/app_util.dart';
import 'package:oke_car_flutter/utils/dialog_util.dart';
import 'package:oke_car_flutter/utils/error_util.dart';

import '../../../../widgets/custom/timePicker/time_picker_widget.dart';

class DetailCarController extends GetxController {
  final AuthenticateClient client;

  DetailCarController({required this.client});

  final carModel = ProductModel().obs;
  final indexImage = 0.obs;
  final carDetail = ''.obs;
  final listAllProduct = <CarModel>[].obs;
  final loading = false.obs;
  final carId = ''.obs;
  final address = ''.obs;

  final userModel = UserModel().obs;
  final endTime = DateUtil.removeTimeInHour(DateTime.now())
      .add(const Duration(hours: 1))
      .obs;

  @override
  void onInit() {
    if (Get.arguments != null && Get.arguments is ProductModel) {
      carModel.value = Get.arguments;
    }

    userModel.value = UserDB().currentUser() ?? UserModel();

    super.onInit();
    init();
  }

  setDefaultImage(int index) {
    indexImage.value = index;
  }

  init() async {
    await getDetailCar();
    fetchAllList();
  }

  getDetailCar() async {}

  fetchAllList() async {}

  sharePost(String slug) async {
    await Share.share(AppUtil().hosting(key: slug));
  }

  changeStatus(String status) async {
    await client.changeStatus(carModel.value.id, status).then((response) async {
      if (response.data['data'] != null) {
        final NewsManganerController ctl = Get.find();
        final index = ctl.listLatestPost
            .indexWhere((element) => element.id == carModel.value.id);
        ctl.listLatestPost[index].status = status;
        carModel.value.status == status;
        carModel.refresh();
        ctl.listLatestPost.refresh();
        DialogUtil.showSuccessMessage(
          'Cập nhật thành công'.tr,
        );
        // Get.back();
      }
    }).catchError((error, trace) {
      ErrorUtil.catchError(error, trace);
    });
  }

  canCelPostchangeStatus(String status) async {
    await client.cancelPost(carModel.value.id, status).then((response) async {
      carModel.value.status == status;
      carModel.refresh();
      DialogUtil.showSuccessMessage(
        'Cập nhật thành công'.tr,
      );
      // Get.back();
    }).catchError((error, trace) {
      ErrorUtil.catchError(error, trace);
    });
  }

  confirmOrder() async {
    await client.confirmOrder(carModel.value.id).then((response) async {
      carModel.value.status = DONE;
      carModel.refresh();
      DialogUtil.showSuccessMessage(
        'Đã xác nhận thanh toán thành công'.tr,
      );
      // Get.back();
    }).catchError((error, trace) {
      ErrorUtil.catchError(error, trace);
    });
  }

  cancelOrder() async {
    await client.cancelOredr(carModel.value.id).then((response) async {
      carModel.value.status = APPROVED;
      carModel.refresh();
      DialogUtil.showSuccessMessage(
        'Đã huỷ lịch hẹn thành công'.tr,
      );
      // Get.back();
    }).catchError((error, trace) {
      ErrorUtil.catchError(error, trace);
    });
  }

  selectEndTime() async {
    DateTime? selectedDate = await Get.generalDialog<DateTime>(
      pageBuilder: (context, animation1, animation2) => const SizedBox(),
      transitionBuilder: (context, a1, a2, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: context.theme.primaryColor,
              onPrimary: context.textTheme.overline!.color!,
              surface: context.theme.cardColor,
              onSurface: context.textTheme.headline1!.color!,
            ),
            dialogBackgroundColor: context.theme.backgroundColor,
          ),
          child: DatePickerDialog(
            initialDate: endTime.value,
            firstDate: DateTime.now(),
            lastDate: DateTime(2040),
            helpText: 'Chọn ngày xem xe'.tr,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierLabel: '',
      barrierDismissible: false,
    );
    if (selectedDate == null) return;
    TimeOfDay? selectedTime = await showCustomTimePicker(
      context: Get.context!,
      // It is a must if you provide selectableTimePredicate
      onFailValidation: (context) => Get.log('Unavailable selection'),
      initialTime:
          TimeOfDay(hour: endTime.value.hour, minute: endTime.value.minute),
      selectableTimePredicate: (time) {
        if (DateTime.now().day == selectedDate!.day) {
          return time!.hour >= endTime.value.hour &&
              (time.minute == 0 || time.minute == 30);
        }
        return time!.minute == 0 || time.minute == 30;
      },
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme:
                ColorScheme.dark(primary: Get.context!.theme.primaryColor),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (selectedTime == null) return;
    selectedDate = DateUtil.removeTimeInDate(selectedDate);
    selectedDate = selectedDate
        .add(Duration(hours: selectedTime.hour, minutes: selectedTime.minute));

    print(selectedDate);
    final now = DateUtil.removeTimeInMinute(DateTime.now());
    if (selectedDate.isAfter(now)) {
      if (!DateUtil.isValidAuctionTime(selectedDate)) {
        DialogUtil.showErrorMessage('Thời gian không hợp lệ'.tr);
      } else {
        endTime.value = selectedDate.toUtc();
      }
    } else {
      DialogUtil.showErrorMessage('Thời gian không hợp lệ'.tr);
    }
    CreateOrderModel createOrderModel = new CreateOrderModel();
    createOrderModel.bookingDate = selectedDate.toUtc();
    await client
        .createOrder(carModel.value.id, createOrderModel.toJson())
        .then((response) async {
      DialogUtil.showSuccessMessage('Đặt lịch hẹn thành công');
      carModel.value.status = CONFIRMING;
      carModel.refresh();
      loading.value = false;
    }).catchError((error, trace) async {
      DialogUtil.showSuccessToast('Đặt lịch hẹn thất bại');
      loading.value = false;
      ErrorUtil.catchError(error, trace);
    });
  }
}
