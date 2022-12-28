import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';
import 'package:oke_car_flutter/models/vehicle_model.dart';
import 'package:oke_car_flutter/pages/admin/carCompany/detailCar/add-vehicle-page.dart';
import 'package:oke_car_flutter/pages/admin/carCompany/detailCar/detail-car-controller.dart';
import 'package:oke_car_flutter/pages/product/detail_product/controller/detail_controller.dart';
import 'package:oke_car_flutter/utils/dialog_util.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:oke_car_flutter/widgets/_no_data_view.dart';
import 'package:oke_car_flutter/widgets/custom/customAppBar/custom_app_bar.dart';
import 'package:oke_car_flutter/widgets/custom/custom_easy_refresh.dart';
import 'package:oke_car_flutter/widgets/custom/custom_indicator.dart';

class DetailCarScreenAdmin extends GetView<DetailCarAdminController> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.theme.primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(
            title: 'Hãng xe : ${controller.carModel.value.name}',
            enableBack: false,
            actionButton: GestureDetector(
              onTap: () {
                controller.setAdd();
                Get.bottomSheet(AddVehicle(),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.w),
                          topRight: Radius.circular(16.w)),
                    ),
                    backgroundColor: context.theme.backgroundColor,
                    isScrollControlled: true);
              },
              child: Container(
                margin: EdgeInsets.only(right: 16.w),
                child: Icon(
                  Icons.add_circle_outline_sharp,
                  color: Style.blackColor,
                ),
              ),
            ),
          ),
          body: CustomEasyRefresh(
            controller: controller.ctrRefresh,
            onRefresh: controller.onRefresh,
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: buildProduct(context),
                );
              },
              childCount: 1,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildProduct(BuildContext context) {
    return Obx(() {
      if (controller.listCarLine.value.isEmpty && controller.loading.value) {
        return Container(
            margin: EdgeInsets.only(top: 200.w), child: CustomIndicator());
      }
      if (controller.listCarLine.isEmpty) {
        return Center(
          child: NoDataView(
            message: 'Chưa có dòng xe nào',
          ),
        );
      }
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: controller.listCarLine
              .map((element) => buildListView(context, element))
              .toList());
    });
  }

  Widget buildListView(BuildContext context, VehicleModel model) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0.w),
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(
            width: 1.0.w,
            color: Color.fromRGBO(157, 163, 172, 0.36),
          ),
        )),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tên dòng xe: ' + model.name,
                    style: Style().subtitleStyle2,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                    onTap: () {
                      controller.setEdit(model);
                      Get.bottomSheet(AddVehicle(),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16.w),
                                topRight: Radius.circular(16.w)),
                          ),
                          backgroundColor: context.theme.backgroundColor,
                          isScrollControlled: true);
                    },
                    child: Icon(Icons.edit)),
                GestureDetector(
                  onTap: () {
                    DialogUtil.showConfirmDialog(
                      Get.context!,
                      title: 'Chú ý'.tr,
                      button: 'Đã hiểu' ,
                      description:
                          'Việc xoá hãng sẽ ảnh hưởng đến đến các dữ liệu khác '.tr,
                    );
                  },
                  child: Icon(
                    Icons.delete,
                    color: context.theme.primaryColorDark,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
