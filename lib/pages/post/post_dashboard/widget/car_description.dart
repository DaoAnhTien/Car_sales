import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/constants/app_constant.dart';
import 'package:oke_car_flutter/helpers/formatter/numericFormatter.dart';
import 'package:oke_car_flutter/pages/post/post_dashboard/controller/post_controller.dart';
import 'package:oke_car_flutter/pages/post/post_dashboard/widget/car_category_value.dart';
import 'package:oke_car_flutter/pages/post/post_dashboard/widget/car_company_widget.dart';
import 'package:oke_car_flutter/pages/post/post_dashboard/widget/car_line_widget.dart';
import 'package:oke_car_flutter/pages/post/post_dashboard/widget/info_car_widget.dart';
import 'package:oke_car_flutter/pages/post/post_dashboard/widget/select_year.dart';
import 'package:oke_car_flutter/pages/post/post_dashboard/widget/version_widget.dart';
import 'package:oke_car_flutter/utils/app_util.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:oke_car_flutter/widgets/_default_text_field.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';

class CarDescription extends GetView<PostController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => buildContent(
                context,
                title: 'Hãng xe',
                value: controller.carCompanyValue.value.name,
                onTap: () {
                  Get.bottomSheet(CarCompanyWidget(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.w),
                            topRight: Radius.circular(16.w)),
                      ),
                      backgroundColor: context.theme.backgroundColor,
                      isScrollControlled: false);
                },
              ),
            ),
            Obx(
              () => buildContent(
                context,
                title: 'Dòng xe',
                value: controller.carLine.value.name,
                onTap: () {
                  Get.bottomSheet(CarLineWidget(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.w),
                            topRight: Radius.circular(16.w)),
                      ),
                      backgroundColor: context.theme.backgroundColor,
                      isScrollControlled: false);
                },
              ),
            ),
            SizedBox(
              height: 16.w,
            ),
            Text(
              'Phiên bản',
              style: Style().bodyStyle2,
            ),
            SizedBox(
              height: 8.w,
            ),
            DefaultTextField(
              width: double.infinity,
              radius: 10,
              controller: controller.versionCarController,
              focusNode: controller.versionFocus,
              textInputType: TextInputType.text,
              autoFillHints: [AutofillHints.email],
              hintText: 'Ví dụ G,E,LX...',
              isAutoFocus: false,
              onChanged: (text) {
                controller.handleVersion(text);
                // controller.onChangeReferral(text);
              },
            ),
            Obx(
              () => buildContent(
                context,
                title: 'Năm sản xuất',
                value: controller.year.value.toString(),
                onTap: () {
                  Get.bottomSheet(SelectYearWidget(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.w),
                            topRight: Radius.circular(16.w)),
                      ),
                      backgroundColor: context.theme.backgroundColor,
                      isScrollControlled: false);
                },
              ),
            ),
            SizedBox(
              height: 16.w,
            ),
            Text(
              'Giá bán',
              style: Style().bodyStyle2,
            ),
            SizedBox(
              height: 16.w,
            ),
            DefaultTextField(
              width: double.infinity,
              radius: 10,
              controller: controller.priceController,
              focusNode: controller.priceFocus,
              textInputType: TextInputType.number,
              isAutoFocus: false,
              autoFillHints: [AutofillHints.email],
              inputFormatter: [DecimalFormatter(decimalDigits: 0)],
              onChanged: (text) {
                // controller.onChangeUserName(text);
                // controller.onChangeReferral(text);
              },
            ),
            Obx(
              () => buildContent(
                context,
                title: 'Xuất xứ',
                value: controller.originValue.value.tr,
                onTap: () {
                  Get.bottomSheet(
                      CartInfoWidget(
                        listValue: controller.origin,
                        headerTitle: 'Xuất xứ',
                        infoSeted: controller.originValue.value,
                        onTap: (value) {
                          controller.setOrigin(value);
                        },
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.w),
                            topRight: Radius.circular(16.w)),
                      ),
                      backgroundColor: context.theme.backgroundColor,
                      isScrollControlled: false);
                },
              ),
            ),
            Obx(
              () => buildContent(
                context,
                title: 'Tình trạng',
                value: controller.carStatusValue.value.tr,
                onTap: () {
                  Get.bottomSheet(
                      CartInfoWidget(
                        listValue: controller.carStatus,
                        headerTitle: 'Tình trạng',
                        infoSeted: controller.carStatusValue.value,
                        onTap: (value) {
                          controller.setCarStatus(value);
                        },
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.w),
                            topRight: Radius.circular(16.w)),
                      ),
                      backgroundColor: context.theme.backgroundColor,
                      isScrollControlled: false);
                },
              ),
            ),
            Obx(
              () => buildContent(
                context,
                title: 'Hộp số',
                value: controller.gearValue.value.tr,
                onTap: () {
                  Get.bottomSheet(
                      CartInfoWidget(
                        listValue: controller.gear,
                        headerTitle: 'Hộp số',
                        infoSeted: controller.gearValue.value,
                        onTap: (value) {
                          controller.setGerCar(value);
                        },
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.w),
                            topRight: Radius.circular(16.w)),
                      ),
                      backgroundColor: context.theme.backgroundColor,
                      isScrollControlled: false);
                },
              ),
            ),
            Obx(
              () => buildContent(
                context,
                title: 'Nhiên liệu',
                value: controller.fuelValue.value,
                onTap: () {
                  Get.bottomSheet(
                      CartInfoWidget(
                        listValue: FULE,
                        headerTitle: 'Nhiên liệu',
                        infoSeted: controller.fuel.value,
                        onTap: (value) {
                          controller.setFuleCar(value);
                        },
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.w),
                            topRight: Radius.circular(16.w)),
                      ),
                      backgroundColor: context.theme.backgroundColor,
                      isScrollControlled: false);
                },
              ),
            ),

            Obx(
              () => buildContent(
                context,
                title: 'Màu sắc',
                value: controller.carColorValue.value,
                onTap: () {
                  Get.bottomSheet(
                      CartInfoWidget(
                        listValue: COLORS,
                        headerTitle: 'Màu sắc',
                        infoSeted: controller.carColorValue.value,
                        onTap: (value) {
                          controller.setCarColor(value);
                        },
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.w),
                            topRight: Radius.circular(16.w)),
                      ),
                      backgroundColor: context.theme.backgroundColor,
                      isScrollControlled: false);
                },
              ),
            ),

            Obx(
              () => buildContent(
                context,
                title: 'Địa điểm',
                value: controller.location.value,
                onTap: () {
                  Get.bottomSheet(
                      CartInfoWidget(
                        height: 400,
                        listValue: LIST_CITY,
                        headerTitle: 'Địa  điểm',
                        infoSeted: controller.location.value,
                        onTap: (value) {
                          controller.setLocation(value);
                        },
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.w),
                            topRight: Radius.circular(16.w)),
                      ),
                      backgroundColor: context.theme.backgroundColor,
                      isScrollControlled: false);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildContent(BuildContext context,
      {String? title, String? value, GestureTapCallback? onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle(context, title: title),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16.0.w, horizontal: 16.0.w),
            decoration: BoxDecoration(
              color: context.theme.cardColor,
              borderRadius: BorderRadius.all(Radius.circular(10.0.w)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  value ?? '',
                  style: TextStyle(
                      fontFamily: Style.fontRegular,
                      fontSize: 15.sp,
                      color: context.textTheme.headline1!.color),
                ),
                Container(
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTitle(BuildContext context, {String? title}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.w, top: 16.w),
      child: Row(
        children: [
          Text(
            title ?? '',
            style: Style().bodyStyle2,
          ),
          SizedBox(
            width: 4.w,
          ),
          Text(
            '*',
            style:
                Style().bodyStyle2.copyWith(color: context.theme.primaryColorDark),
          ),
        ],
      ),
    );
  }
}
