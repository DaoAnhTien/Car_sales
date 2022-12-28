import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/constants/app_constant.dart';
import 'package:oke_car_flutter/pages/dashboard/model/car_model.dart';
import 'package:oke_car_flutter/pages/product/detail_product/controller/detail_controller.dart';
import 'package:oke_car_flutter/pages/product/detail_product/view/review_screen.dart';
import 'package:oke_car_flutter/pages/product/widget/read_more.dart';
import 'package:oke_car_flutter/repositories/authenticate_client.dart';
import 'package:oke_car_flutter/routes/app_pages.dart';
import 'package:oke_car_flutter/utils/app_util.dart';
import 'package:oke_car_flutter/utils/auth_util.dart';
import 'package:oke_car_flutter/utils/date_util.dart';
import 'package:oke_car_flutter/values/setting.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:oke_car_flutter/widgets/_cachedImage.dart';
import 'package:oke_car_flutter/widgets/_radius_button.dart';
import 'package:oke_car_flutter/widgets/_rating_widget.dart';
import 'package:oke_car_flutter/widgets/custom_app_bar.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utils/dialog_util.dart';

class DetailProductPage extends GetView<DetailCarController> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
          backgroundColor: context.theme.cardColor,
          appBar: CustomAppBar(
            titleColor: context.theme.backgroundColor,
            bgColor: Style.toastErrorBgColor,
            title: 'detail'.tr,
            centerTitle: false,
            actionButton: GestureDetector(
              onTap: () {
                controller.sharePost(controller.carModel.value.title);
              },
              child: Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: Icon(
                  Icons.share,
                  color: context.theme.backgroundColor,
                ),
              ),
            ),
          ),
          body: Obx(
            () => controller.loading.value
                ? Center(
                    child: SpinKitThreeBounce(
                      color: context.theme.primaryColor,
                      size: 24,
                    ),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  padding: EdgeInsets.symmetric(vertical: 8.w),
                                  color: context.theme.cardColor,
                                  child: buildImage(context, controller)),
                              SizedBox(height: 8.w),
                              buildInfoCar(context, controller),
                            ],
                          ),
                        ),
                      ),
                      buildFooter(
                          context, controller, controller.userModel.value.role)
                    ],
                  ),
          )),
    );
  }

  Widget buildImage(BuildContext context, DetailCarController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildBigImage(context, controller),
          SizedBox(
            height: 8.w,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...List.generate(
                    controller.carModel.value.avatar.length,
                    (index) =>
                        buildSmallProductPreview(context, index, controller)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBigImage(BuildContext context, DetailCarController controller) {
    return Padding(
      padding: EdgeInsets.only(top: 10.w),
      child: Obx(() => Stack(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: false,
                  viewportFraction: 1.0,
                  aspectRatio: context.isTablet
                      ? context.width / 320.w
                      : context.width / 160.w,
                  enlargeCenterPage: true,
                  height: context.isTablet ? 320.w : 220.w,
                  onPageChanged: (index, reason) {
                    controller.indexImage.value = index;
                  },
                ),
                items: controller.carModel.value.avatar
                    .map(
                      (banner) => GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.w),
                          child: CachedImage(
                            AppUtil().getImage(
                                key: controller.carModel.value
                                    .avatar[controller.indexImage.value].url),
                            defaultUrl: AppSetting.imgLogo,
                            fit: BoxFit.cover,
                            height: 220.w,
                            width: context.width,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              Positioned(
                left: 0,
                bottom: 18.w,
                right: 0,
                child: Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: controller.carModel.value.avatar
                          .asMap()
                          .entries
                          .map((entry) {
                        return Container(
                          width: 8.w,
                          height: 8.w,
                          margin: EdgeInsets.symmetric(
                              vertical: 8.w, horizontal: 4.w),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.amber.withOpacity(
                                  controller.indexImage.value == entry.key
                                      ? 0.9
                                      : 0.1)),
                        );
                      }).toList(),
                    )),
              ),
            ],
          )),
    );
  }

  Widget buildSmallProductPreview(
      BuildContext context, int index, DetailCarController controller) {
    return GestureDetector(
      onTap: () {
        controller.setDefaultImage(index);
      },
      child: Opacity(
        opacity: controller.indexImage.value == index ? 1 : 0.5,
        child: Container(
          // duration: Duration(seconds: 4),
          margin: EdgeInsets.only(right: 8.w),
          height: 120.w,
          width: 180.w,
          decoration: BoxDecoration(
            color: Colors.white
                .withOpacity(controller.indexImage.value == index ? 1 : 0),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.w),
            child: CachedImage(
              AppUtil()
                  .getImage(key: controller.carModel.value.avatar[index].url),
              defaultUrl: AppSetting.imgLogo,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInfoCar(BuildContext context, DetailCarController controller) {
    final carModel = controller.carModel.value;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
      width: context.width,
      decoration: BoxDecoration(
          color: context.theme.backgroundColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.w), topRight: Radius.circular(24.w))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            carModel.title,
            style: Style().subtitleStyle1,
          ),
          SizedBox(
            height: 8.w,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppUtil.formatMoneyInt(carModel.price),
                style: Style()
                    .primaryStyle
                    .copyWith(color: context.theme.primaryColor),
              ),
              Image.asset(
                AppSetting.icHeartOutline,
                color: context.theme.hintColor,
              )
            ],
          ),
          SizedBox(
            height: 8.w,
          ),
          Row(
            children: [
              Text(DateUtil.formatDate(carModel.createdAt),
                  style: Style().hintStyle.copyWith(fontSize: 15.sp)),
              SizedBox(
                width: 16.w,
              ),
            ],
          ),
          SizedBox(
            height: 16.w,
          ),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 16.w,
              ),
              SizedBox(
                width: 4.w,
              ),
              Text(
                carModel.addressSeller,
                style: Style().bodyStyle1,
              )
            ],
          ),
          GestureDetector(
            onTap: () {
              // Get.to(ReviewProductScreen());
            },
            child: OpenFlutterProductRating(
              rating: 3,
              ratingCount: 5,
              alignment: MainAxisAlignment.start,
            ),
          ),
          Divider(
            color: context.theme.hintColor,
          ),
          Text(
            'contact_info'.tr,
            style: Style().primaryStyle,
          ),
          SizedBox(
            height: 8.w,
          ),
          buildContact(context, controller),
          Divider(
            color: context.theme.hintColor,
          ),
          Text(
            'info'.tr,
            style: Style().primaryStyle,
          ),
          SizedBox(
            height: 4.w,
          ),
          _buildInfo(context,
              widget: Image.asset(
                AppSetting.icLich,
                height: 24.w,
              ),
              title: 'year_info',
              sub: carModel.year.toString()),
          // _buildInfo(context,
          //     widget: Image.asset(
          //       AppSetting.icTinhTrang,
          //       height: 24.w,
          //     ),
          //     title: 'tinhtrang',
          //     sub: AppUtil().),
          _buildInfo(context,
              widget: Icon(Icons.location_on_outlined),
              title: 'location',
              sub: carModel.location),
          _buildInfo(context,
              widget: Icon(Icons.info_outline),
              title: 'Hãng xe',
              sub: carModel.company?.name ?? ''),
          _buildInfo(context,
              widget: Icon(Icons.branding_watermark),
              title: 'Dòng xe',
              sub: carModel.company?.name ?? ''),
          _buildInfo(context,
              widget: Icon(Icons.car_crash),
              title: 'Phiên bản',
              sub: carModel.company?.name ?? ''),
          _buildInfo(context,
              widget: Icon(Icons.color_lens),
              title: 'Màu sắc',
              sub: carModel.color),
          _buildInfo(context,
              widget: Icon(Icons.trip_origin_sharp),
              title: 'Xuất xứ',
              sub: carModel.origin.tr),
          // _buildInfo(context,
          //     widget: Image.asset(
          //       AppSetting.icHaveVideo,
          //       height: 24.w,
          //     ),
          //     title: 'have_video',
          //     sub: carModel.youtobe != ''
          //         ? carModel.video_url
          //         : 'no_have_video'.tr),
          Divider(
            color: context.theme.hintColor,
          ),
          Text(
            'mota'.tr,
            style: Style().primaryStyle,
          ),
          ReadMoreText(
            carModel.description.replaceAll('<br />', ''),
            trimMode: TrimMode.Line,
            trimLines: 3,
            trimExpandedText: 'load_less'.tr,
            trimCollapsedText: 'show_less'.tr,
            style: Style().bodyStyle1,
            moreStyle: Style().primaryStyle.copyWith(
                  color: context.theme.highlightColor,
                  fontFamily: Style.fontRegular,
                  decoration: TextDecoration.underline,
                ),
            lessStyle: Style().primaryStyle.copyWith(
                  color: context.theme.highlightColor,
                  fontFamily: Style.fontRegular,
                  decoration: TextDecoration.underline,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfo(BuildContext context,
      {Widget? widget, String? title, String? sub}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: [
                widget!,
                SizedBox(
                  width: 8.w,
                ),
                Text(
                  title!.tr,
                  style: Style()
                      .normalStyle4
                      .copyWith(fontFamily: Style.fontRegular),
                ),
              ],
            ),
          ),
          Expanded(
            child: Text(
              sub!,
              style: Style().normalStyle4,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildContact(BuildContext context, DetailCarController controller) {
    return Row(
      children: [
        Image.asset(AppSetting.icAccountFilled),
        SizedBox(
          width: 16.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.carModel.value.nameSeller,
              style: Style().subtitleStyle2,
            ),
            GestureDetector(
              onTap: () {
                launch("tel:${controller.carModel.value.phoneSeller}");
              },
              child: Text(
                  'contact_now'.tr + controller.carModel.value.phoneSeller,
                  style: Style().bodyStyle1.copyWith(
                      color: context.theme.highlightColor,
                      decoration: TextDecoration.underline)),
            ),
          ],
        )
      ],
    );
  }

  Widget buildFooter(
      BuildContext context, DetailCarController controller, String role) {
    if (role == 'admin') {
      final status = controller.carModel.value.status;
      if (status == IS_BLOCKED || status == APPROVED || status == PENDING) {
        return Row(
          children: [
            Expanded(
              child: Container(
                  child: RadiusButton(
                isFullWidth: true,
                maxWidth: double.infinity,
                isDisable: controller.carModel.value.status == 'IS_BLOCKED',
                radius: 10.w,
                outsidePadding:
                    EdgeInsets.only(top: 23.w, bottom: 35.w, left: 16.w),
                innerPadding: EdgeInsets.only(
                  top: 16.w,
                  bottom: 16.w,
                  left: 5.w,
                  right: 5.w,
                ),
                isLoading: controller.loading.value,
                indicatorSize: 24.w,
                text: 'Từ chối',
                fontFamily: Style.fontBold,
                fontSize: 17.sp,
                backgroundColor: context.theme.primaryColorDark,
                textColor: context.textTheme.headline4!.color,
                onTap: () {
                  DialogUtil.showConfirmDialog(Get.context!,
                      title: 'Cảnh báo'.tr,
                      description: 'Bạn có chắc chắn từ chối tin đăng này?'.tr,
                      action: () {
                    controller.changeStatus(IS_BLOCKED);
                  });
                },
              )),
            ),
            Expanded(
              child: Container(
                  child: RadiusButton(
                isFullWidth: true,
                maxWidth: double.infinity,
                radius: 10.w,
                isDisable: controller.carModel.value.status == APPROVED,
                outsidePadding: EdgeInsets.only(
                    top: 23.w, bottom: 35.w, left: 16.w, right: 16.w),
                innerPadding: EdgeInsets.only(
                  top: 16.w,
                  bottom: 16.w,
                  left: 5.w,
                  right: 5.w,
                ),
                isLoading: controller.loading.value,
                indicatorSize: 24.w,
                text: 'Duyệt tin',
                onTap: () {
                  DialogUtil.showConfirmDialog(Get.context!,
                      title: 'Cảnh báo'.tr,
                      description: 'Bạn có chắc chắn duyệt tin đăng này?'.tr,
                      action: () {
                    controller.changeStatus(APPROVED);
                  });
                },
                fontFamily: Style.fontBold,
                fontSize: 17.sp,
                backgroundColor: context.theme.primaryColor,
                textColor: context.textTheme.headline4!.color,
              )),
            ),
          ],
        );
      }
      return Container(
          child: RadiusButton(
        isFullWidth: true,
        isDisable: true,
        maxWidth: double.infinity,
        radius: 10.w,
        outsidePadding:
            EdgeInsets.only(top: 23.w, bottom: 35.w, left: 16.w, right: 16.w),
        innerPadding: EdgeInsets.only(
          top: 16.w,
          bottom: 16.w,
          left: 5.w,
          right: 5.w,
        ),
        isLoading: controller.loading.value,
        indicatorSize: 24.w,
        text: AuthUtil.statusText(controller.carModel.value.status),
        fontFamily: Style.fontBold,
        onTap: () {
          // controller.selectEndTime();
        },
        fontSize: 17.sp,
        backgroundColor: context.theme.primaryColor,
        textColor: context.textTheme.headline4!.color,
      ));
    }
    if (controller.userModel.value.id != controller.carModel.value.userId) {
      return Container(
          child: RadiusButton(
        isFullWidth: true,
        isDisable: controller.carModel.value.status != APPROVED,
        maxWidth: double.infinity,
        radius: 10.w,
        outsidePadding:
            EdgeInsets.only(top: 23.w, bottom: 35.w, left: 16.w, right: 16.w),
        innerPadding: EdgeInsets.only(
          top: 16.w,
          bottom: 16.w,
          left: 5.w,
          right: 5.w,
        ),
        isLoading: controller.loading.value,
        indicatorSize: 24.w,
        text: AuthUtil.statusText(controller.carModel.value.status),
        fontFamily: Style.fontBold,
        onTap: () {
          controller.selectEndTime();
        },
        fontSize: 17.sp,
        backgroundColor: context.theme.primaryColor,
        textColor: context.textTheme.headline4!.color,
      ));
    }

    if (controller.userModel.value.id == controller.carModel.value.userId) {
      if (controller.carModel.value.status == CONFIRMING) {
        return Row(
          children: [
            Expanded(
              child: Container(
                  child: RadiusButton(
                isFullWidth: true,
                maxWidth: double.infinity,
                isDisable: controller.carModel.value.status == 'IS_BLOCKED',
                radius: 10.w,
                outsidePadding:
                    EdgeInsets.only(top: 23.w, bottom: 35.w, left: 16.w),
                innerPadding: EdgeInsets.only(
                  top: 16.w,
                  bottom: 16.w,
                  left: 5.w,
                  right: 5.w,
                ),
                isLoading: controller.loading.value,
                indicatorSize: 24.w,
                text: 'Từ chối lịch hẹn',
                fontFamily: Style.fontBold,
                fontSize: 14.sp,
                backgroundColor: context.theme.primaryColorDark,
                textColor: context.textTheme.headline4!.color,
                onTap: () {
                  DialogUtil.showConfirmDialog(Get.context!,
                      title: 'Cảnh báo'.tr,
                      description: 'Bạn có chắc chắn từ chối giao dịch xe này?'
                          .tr, action: () {
                    controller.cancelOrder();
                  });
                },
              )),
            ),
            Expanded(
              child: Container(
                  child: RadiusButton(
                isFullWidth: true,
                maxWidth: double.infinity,
                radius: 10.w,
                isDisable: controller.carModel.value.status == APPROVED,
                outsidePadding: EdgeInsets.only(
                    top: 23.w, bottom: 35.w, left: 16.w, right: 16.w),
                innerPadding: EdgeInsets.only(
                  top: 16.w,
                  bottom: 16.w,
                  left: 5.w,
                  right: 5.w,
                ),
                isLoading: controller.loading.value,
                indicatorSize: 24.w,
                text: 'Xác nhận thanh toán',
                onTap: () {
                  DialogUtil.showConfirmDialog(Get.context!,
                      title: 'Cảnh báo'.tr,
                      description:
                          'Bạn có chắc chắn xác nhận khác hàng đã thanh toán đủ số tiền của xe này ?'
                              .tr, action: () {
                    controller.confirmOrder();
                  });
                },
                fontFamily: Style.fontBold,
                fontSize: 14.sp,
                backgroundColor: context.theme.primaryColor,
                textColor: context.textTheme.headline4!.color,
              )),
            ),
          ],
        );
      }
      return Container(
          child: RadiusButton(
        isFullWidth: true,
        maxWidth: double.infinity,
        isDisable: controller.carModel.value.status == DONE ||
            controller.carModel.value.status == CANCEL ||
            controller.carModel.value.status == IS_BLOCKED,
        radius: 10.w,
        outsidePadding:
            EdgeInsets.only(top: 23.w, bottom: 35.w, left: 16.w, right: 16.w),
        innerPadding: EdgeInsets.only(
          top: 16.w,
          bottom: 16.w,
          left: 5.w,
          right: 5.w,
        ),
        isLoading: controller.loading.value,
        indicatorSize: 24.w,
        text: AuthUtil.textForOwner(controller.carModel.value.status),
        fontFamily: Style.fontBold,
        fontSize: 17.sp,
        backgroundColor: context.theme.primaryColor,
        textColor: context.textTheme.headline4!.color,
        onTap: () {
          DialogUtil.showConfirmDialog(Get.context!,
              title: 'Cảnh báo'.tr,
              description: 'Bạn có chắc chắn huỷ tin đăng này ?'.tr,
              action: () {
            controller.canCelPostchangeStatus(CANCEL);
          });
        },
      ));
    }

    return Container();
  }

  Widget buildButton(BuildContext context,
      {bool isHide = true,
      String? text,
      IconData? icons,
      GestureTapCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        color: isHide != false
            ? context.theme.colorScheme.secondary
            : context.theme.primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icons,
              color: isHide != true
                  ? context.theme.backgroundColor
                  : context.textTheme.headline1!.color,
              size: 24,
            ),
            SizedBox(
              width: 8.w,
            ),
            Text(
              text!.tr,
              style: Style().bodyStyle1.copyWith(
                    color: isHide != true
                        ? context.theme.backgroundColor
                        : context.theme.textTheme.headline1!.color,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
