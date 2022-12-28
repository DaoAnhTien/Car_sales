import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/pages/product/product_dashboard/controller/product_controller.dart';
import 'package:oke_car_flutter/pages/product/widget/branch_widget.dart';
import 'package:oke_car_flutter/pages/product/widget/color_filter.dart';
import 'package:oke_car_flutter/pages/product/widget/custom_button.dart';
import 'package:oke_car_flutter/pages/product/widget/location_widget.dart';
import 'package:oke_car_flutter/pages/product/widget/sub_screen.dart';
import 'package:oke_car_flutter/pages/product/widget/year_widget.dart';
import 'package:oke_car_flutter/utils/app_util.dart';
import 'package:oke_car_flutter/values/setting.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:oke_car_flutter/widgets/_cachedImage.dart';
import 'package:oke_car_flutter/widgets/_custom_header.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';
import 'package:oke_car_flutter/widgets/_radius_button.dart';
import 'package:oke_car_flutter/widgets/custom_xlider.dart';

class FilterScreen extends GetView<ProductController> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.theme.backgroundColor,
      child: SafeArea(
        bottom: false,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: CustomHeaderWidget(
              title: 'filter'.tr,
            ),
            backgroundColor: context.theme.backgroundColor,
            body: Container(
              color: context.theme.cardColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 10.w,
                            color: context.theme.cardColor,
                          ),
                          buildBranch(context),
                          Container(
                            height: 10.w,
                            color: context.theme.cardColor,
                          ),
                          Container(
                            height: 10.w,
                            color: context.theme.cardColor,
                          ),
                          buildSapXep(context),
                          Container(
                            height: 10.w,
                            color: context.theme.cardColor,
                          ),
                          buildCarStatus(context),
                          Container(
                            height: 10.w,
                            color: context.theme.cardColor,
                          ),
                          buildCarYear(context)
                        ],
                      ),
                    ),
                  ),
                  _buildButton(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: RadiusButton(
            isFullWidth: true,
            border: Border.all(color: context.theme.primaryColorDark, width: 2),
            // isDisable: !controller.isValid(),
            maxWidth: double.infinity,
            radius: 30.w,
            outsidePadding: EdgeInsets.only(
              top: 23.w,
              bottom: 35.w,
              left: 16.w,
            ),

            innerPadding: controller.loading.value
                ? EdgeInsets.only(
                    top: 14.w, bottom: 14.w, left: 20.w, right: 20.w)
                : EdgeInsets.only(
                    top: 16.w,
                    bottom: 16.w,
                    left: 5.w,
                    right: 5.w,
                  ),
            isLoading: controller.loading.value,
            indicatorSize: 24.w,
            text: 'dis_filer'.tr,
            fontFamily: Style.fontMedium,
            fontSize: 17.sp,
            backgroundColor: context.theme.backgroundColor,
            textColor: context.textTheme.headline1!.color,
            onTap: controller.cancelFitler,
          ),
        ),
        SizedBox(
          width: 16.w,
        ),
        Obx(
          () => Expanded(
            child: RadiusButton(
              isFullWidth: true,

              maxWidth: double.infinity,
              radius: 30.w,
              outsidePadding:
                  EdgeInsets.only(top: 23.w, bottom: 35.w, right: 16.w),

              innerPadding: controller.loading.value
                  ? EdgeInsets.only(
                      top: 14.w, bottom: 14.w, left: 20.w, right: 20.w)
                  : EdgeInsets.only(
                      top: 16.w,
                      bottom: 16.w,
                      left: 5.w,
                      right: 5.w,
                    ),
              isLoading: controller.loading.value,
              indicatorSize: 24.w,
              text: 'filter_btn'.tr,
              fontFamily: Style.fontDemiBold,
              fontSize: 17.sp,
              backgroundColor: context.theme.primaryColor,
              textColor: context.textTheme.button!.color,
              onTap: controller.confirmFilter,
            ),
          ),
        )
      ],
    );
  }

  Widget buildBranch(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      color: context.theme.backgroundColor,
      width: context.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'branch'.tr,
            style: Style().bodyStyle2,
          ),
          SizedBox(height: 10.0.w),
          GestureDetector(
            onTap: () {
              Get.bottomSheet(BrandWidget(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.w),
                        topRight: Radius.circular(16.w)),
                  ),
                  backgroundColor: context.theme.backgroundColor,
                  isScrollControlled: false);
            },
            child: Container(
              padding:
                  EdgeInsets.symmetric(vertical: 16.0.w, horizontal: 16.0.w),
              decoration: BoxDecoration(
                color: context.theme.cardColor,
                borderRadius: BorderRadius.all(Radius.circular(10.0.w)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() => controller.branchSelect.value.name.isBlank!
                      ? Text(
                          'all'.tr,
                          style: TextStyle(
                              fontFamily: Style.fontRegular,
                              fontSize: 15.sp,
                              color: context.textTheme.headline1!.color),
                        )
                      : Row(
                          children: [
                            CachedImage(
                              AppUtil().getImageUrl(
                                key: controller.branchSelect.value.avatar?.url ?? '',
                              ),
                              defaultUrl: AppSetting.imgLogo,
                              width: 24.w,
                              height: 24.w
                              ,
                            ),
                            SizedBox(
                              width: 16.w,
                            ),
                            Text(
                              controller.branchSelect.value.name,
                              style: TextStyle(
                                  color: context.textTheme.headline1!.color,
                                  fontSize: 17.sp,
                                  fontFamily: Style.fontDemiBold),
                            ),
                          ],
                        )),
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
          SizedBox(height: 16.0.w),
          Obx(
            () => Opacity(
              opacity: controller.branchSelect.value.name.isBlank! ? 0.25 : 1,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'dong_xe'.tr,
                      style: Style().bodyStyle2,
                    ),
                    SizedBox(height: 10.0.w),
                    GestureDetector(
                      onTap: () {
                        controller.branchSelect.value.name.isBlank!
                            ? null
                            : Get.bottomSheet(SubBranchWidget(),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16.w),
                                      topRight: Radius.circular(16.w)),
                                ),
                                backgroundColor: context.theme.backgroundColor,
                                isScrollControlled: false);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 16.0.w, horizontal: 16.0.w),
                        decoration: BoxDecoration(
                          color: context.theme.cardColor,
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0.w)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            controller.subSelect.value.name.isBlank!
                                ? Text(
                                    'all'.tr,
                                    style: TextStyle(
                                        fontFamily: Style.fontRegular,
                                        fontSize: 15.sp,
                                        color:
                                            context.textTheme.headline1!.color),
                                  )
                                : Row(
                                    children: [
                                      CachedImage(
                                        AppUtil().getImageUrl(
                                          key: controller.subSelect.value.icon,
                                        ),
                                        defaultUrl: AppSetting.imgLogo,
                                        width: 24.w,
                                        height: 24,
                                      ),
                                      SizedBox(
                                        width: 16.w,
                                      ),
                                      Text(
                                        controller.subSelect.value.name,
                                        style: TextStyle(
                                            color: context
                                                .textTheme.headline1!.color,
                                            fontSize: 17.sp,
                                            fontFamily: Style.fontDemiBold),
                                      ),
                                    ],
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPrice(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      color: context.theme.backgroundColor,
      width: context.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'price'.tr,
            style: Style().bodyStyle2,
          ),
          /*Fixed Values*/
          Obx(
            () => FlutterSlider(
              handler: customHandler(),
              rightHandler: customHandler(),
              values: [controller.minPrice.value, controller.maxPrice.value],
              rangeSlider: true,
              max: 200000000000,
              min: 0.0,
              step: FlutterSliderStep(step: 1000000),
              jump: false,
              rtl: false,
              trackBar: FlutterSliderTrackBar(
                inactiveTrackBarHeight: 2,
                activeTrackBarHeight: 4,
              ),
              handlerWidth: 24.w,
              disabled: false,
              onDragging: (handlerIndex, lowerValue, upperValue) {
                controller.minPrice.value = lowerValue;
                controller.maxPrice.value = upperValue;
                // setState(() {});
              },
            ),
          ),
          Obx(
            () => RichText(
              text: TextSpan(
                text: 'min_price'.tr,
                style: Style().bodyStyle1,
                children: <TextSpan>[
                  TextSpan(
                      text: AppUtil.formatMoney(
                          controller.minPrice.value.toDouble()),
                      style: Style().bodyStyle2),
                  TextSpan(text: 'to'.tr),
                  TextSpan(
                      text: AppUtil.formatMoney(
                          controller.maxPrice.value.toDouble()),
                      style: Style().bodyStyle2),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildSapXep(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      color: context.theme.backgroundColor,
      width: context.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'location'.tr,
            style: Style().bodyStyle2,
          ),
          SizedBox(
            height: 8.w,
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => SearchCityPage());
            },
            child: Container(
              padding:
                  EdgeInsets.symmetric(vertical: 16.0.w, horizontal: 16.0.w),
              decoration: BoxDecoration(
                color: context.theme.cardColor,
                borderRadius: BorderRadius.all(Radius.circular(10.0.w)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() => controller.location.value.isBlank!
                      ? Text(
                          'all'.tr,
                          style: TextStyle(
                              fontFamily: Style.fontRegular,
                              fontSize: 15.sp,
                              color: context.textTheme.headline1!.color),
                        )
                      : Row(
                          children: [
                            Text(
                              controller.location.value.tr,
                              style: TextStyle(
                                  color: context.textTheme.headline1!.color,
                                  fontSize: 17.sp,
                                  fontFamily: Style.fontDemiBold),
                            ),
                          ],
                        )),
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
          /*Fixed Values*/
        ],
      ),
    );
  }

  Widget buildColor(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      color: context.theme.backgroundColor,
      width: context.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'color'.tr,
            style: Style().bodyStyle2,
          ),
          SizedBox(
            height: 8.w,
          ),
          GestureDetector(
            onTap: () {
              Get.bottomSheet(ColorFilter(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.w),
                        topRight: Radius.circular(16.w)),
                  ),
                  backgroundColor: context.theme.backgroundColor,
                  isScrollControlled: true);
            },
            child: Container(
              padding:
                  EdgeInsets.symmetric(vertical: 16.0.w, horizontal: 16.0.w),
              decoration: BoxDecoration(
                color: context.theme.cardColor,
                borderRadius: BorderRadius.all(Radius.circular(10.0.w)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() => controller.colorValue.value.name.isBlank!
                      ? Text(
                          'all'.tr,
                          style: TextStyle(
                              fontFamily: Style.fontRegular,
                              fontSize: 15.sp,
                              color: context.textTheme.headline1!.color),
                        )
                      : Row(
                          children: [
                            Container(
                              height: 24.w,
                              width: 24.w,
                              decoration: BoxDecoration(
                                  color:
                                      Color(controller.colorValue.value.color),
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                      color: Style.blackColor, width: 1)),
                            ),
                            SizedBox(
                              width: 16.w,
                            ),
                            Text(
                              controller.colorValue.value.name.tr,
                              style: TextStyle(
                                  color: context.textTheme.headline1!.color,
                                  fontSize: 17.sp,
                                  fontFamily: Style.fontDemiBold),
                            ),
                          ],
                        )),
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
          /*Fixed Values*/
        ],
      ),
    );
  }

  Widget buildCarStatus(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      color: context.theme.backgroundColor,
      width: context.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'car_status'.tr,
            style: Style().bodyStyle2,
          ),
          SizedBox(
            height: 8.w,
          ),
          Obx(
            () => Row(
              children: [
                Expanded(
                    child: CustomButton(
                  text: 'new_car',
                  isSelected: controller.carStatus.value == 'new_car',
                  onTap: () {
                    controller.setCarStatus('new_car');
                  },
                )),
                SizedBox(
                  width: 16.w,
                ),
                Expanded(
                  child: CustomButton(
                    onTap: () {
                      controller.setCarStatus('old_car');
                    },
                    text: 'old_car',
                    isSelected: controller.carStatus.value == 'old_car',
                  ),
                ),
              ],
            ),
          )
          /*Fixed Values*/
        ],
      ),
    );
  }

  Widget buildCarYear(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      color: context.theme.backgroundColor,
      width: context.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'year_sx'.tr,
            style: Style().bodyStyle2,
          ),
          SizedBox(
            height: 8.w,
          ),
          SizedBox(
            height: 8.w,
          ),
          GestureDetector(
            onTap: () {
              Get.bottomSheet(ListYear(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.w),
                        topRight: Radius.circular(16.w)),
                  ),
                  backgroundColor: context.theme.backgroundColor,
                  isScrollControlled: true);
            },
            child: Container(
              padding:
                  EdgeInsets.symmetric(vertical: 16.0.w, horizontal: 16.0.w),
              decoration: BoxDecoration(
                color: context.theme.cardColor,
                borderRadius: BorderRadius.all(Radius.circular(10.0.w)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() => controller.year.value.isBlank!
                      ? Text(
                          'all'.tr,
                          style: TextStyle(
                              fontFamily: Style.fontRegular,
                              fontSize: 15.sp,
                              color: context.textTheme.headline1!.color),
                        )
                      : Row(
                          children: [
                            Text(
                              controller.year.value.tr,
                              style: TextStyle(
                                  color: context.textTheme.headline1!.color,
                                  fontSize: 17.sp,
                                  fontFamily: Style.fontDemiBold),
                            ),
                          ],
                        )),
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

          /*Fixed Values*/
        ],
      ),
    );
  }

  customHandler() {
    return FlutterSliderHandler(
      decoration: BoxDecoration(),
      child: Container(
        child: Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.3), shape: BoxShape.circle),
          // child: Icon(
          //   icon,
          //   color: Colors.white,
          //   size: 23,
          // ),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: Colors.blue.withOpacity(0.3),
                spreadRadius: 0.05,
                blurRadius: 5,
                offset: Offset(0, 1))
          ],
        ),
      ),
    );
  }

  buildSoft(BuildContext context, {bool? isSelect, String? text}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.w),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(color: context.theme.dividerColor, width: 1.w)),
      ),
      child: Row(
        children: [
          isSelect != false
              ? Container(
                  alignment: Alignment.center,
                  width: 24.w,
                  height: 24.w,
                  child: Icon(
                    Icons.check_circle,
                    color: context.theme.primaryColorDark,
                  ),
                )
              : Container(
                  alignment: Alignment.center,
                  width: 24.w,
                  height: 24.w,
                  child: Icon(
                    Icons.radio_button_unchecked,
                    color: context.theme.hintColor,
                  ),
                ),
          SizedBox(
            width: 16.w,
          ),
          Text(
            text!.tr,
            style: Style().bodyStyle1,
          )
        ],
      ),
    );
  }
}
