import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:oke_car_flutter/models/product.model.dart';
import 'package:oke_car_flutter/pages/dashboard/model/car_model.dart';
import 'package:oke_car_flutter/pages/product/product_dashboard/controller/product_controller.dart';
import 'package:oke_car_flutter/pages/product/widget/filter_screen.dart';
import 'package:oke_car_flutter/pages/product/widget/sort_by.dart';
import 'package:oke_car_flutter/routes/app_pages.dart';
import 'package:oke_car_flutter/utils/app_util.dart';
import 'package:oke_car_flutter/utils/date_util.dart';
import 'package:oke_car_flutter/values/setting.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:oke_car_flutter/widgets/_cachedImage.dart';
import 'package:oke_car_flutter/widgets/_no_data_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:oke_car_flutter/helpers/responsive.dart';
import 'package:oke_car_flutter/widgets/custom_app_bar.dart';

class ProductPage extends GetView<ProductController> {
  @override
  Widget build(BuildContext context) {
    return Material(
        color: context.theme.backgroundColor,
        child: Scaffold(
            backgroundColor: context.theme.backgroundColor,
            appBar: CustomAppBar(
              titleColor: context.theme.backgroundColor,
              bgColor: Style.toastErrorBgColor,
              title: 'Tất cả xe'.tr,
              centerTitle: false,
              actionButton: Obx(
                () => IconButton(
                    padding: EdgeInsets.only(top: 0),
                    // onPressed: onChangeViewClicked,
                    icon: Icon(
                      !controller.isShowAction.value
                          ? Icons.view_list
                          : Icons.grid_on_outlined,
                    ),
                    onPressed: () {
                      controller.showAction();
                    }),
              ),
            ),
            body: Obx(() {
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    controller.loading.value &&
                            controller.listAllProduct.isEmpty
                        ? Center(
                            child: Container(
                              margin: EdgeInsets.only(top: 150.w),
                              child: SpinKitThreeBounce(
                                color: context.theme.primaryColor,
                                size: 24,
                              ),
                            ),
                          )
                        : controller.listAllProduct.isEmpty
                            ? Center(child: NoDataView())
                            : Expanded(
                                child: EasyRefresh.custom(
                                  onLoad: () {
                                    return controller.onLoading();
                                  },
                                  enableControlFinishRefresh: false,
                                  enableControlFinishLoad:
                                      controller.loading.value ? false : true,
                                  controller: controller.ctlRefresh,
                                  onRefresh: controller.onRefresh,
                                  header: BezierHourGlassHeader(
                                      color: context.theme.primaryColorDark,
                                      backgroundColor:
                                          context.theme.backgroundColor),

                                  // footer: ClassicalFooter(
                                  //     infoText:
                                  //         '${controller.listAllProduct.length} / ${controller.meta.value.total_size}'),
                                  slivers: [
                                    SliverToBoxAdapter(
                                        child: Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 8.w),
                                      color: context.theme.cardColor,
                                      height: 10.w,
                                    )),
                                    SliverToBoxAdapter(
                                      child: Obx(
                                        () => AnimatedCrossFade(
                                          duration: Duration(milliseconds: 200),
                                          firstChild: _verticalList(context),
                                          secondChild: buildSuggest(context),
                                          crossFadeState:
                                              controller.isShowAction.value
                                                  ? CrossFadeState.showSecond
                                                  : CrossFadeState.showFirst,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                  ],
                ),
              );
            })));
  }

  Widget _verticalList(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: controller.listAllProduct
            .map<Widget>(
              (carModel) => buildListView(context, carModel),
            )
            .toList(),
      ),
    );
  }

  Widget buildSuggest(BuildContext context) {
    return SizedBox(
      child: Container(
        color: context.theme.cardColor,
        child: StaggeredGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            children: controller.listAllProduct
                .map(
                  (element) => _buildItem(context, element),
                )
                .toList()),
      ),
    );
  }

  Widget _buildItem(BuildContext context, ProductModel model) {
    return Container(
      color: context.theme.backgroundColor,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16.w),
      child: SizedBox(
        width: 140.w,
        child: GestureDetector(
          onTap: () {
            Get.toNamed(Routes.DETAIL_CAR, arguments: model);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(4.w),
                      child: CachedImage(
                        AppUtil().getImage(key: model.avatar.first.url),
                        fit: BoxFit.fill,
                      )),
                ),
              ),
              SizedBox(height: 10.w),
              Text(
                model.title,
                style: Style().subtitleStyle2,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 5.w),
              Text(
                model.year.toString() + ' - ' + model.carStatus.tr,
                style:
                    Style().bodyStyle1.copyWith(color: context.theme.hintColor),
                maxLines: 2,
              ),
              SizedBox(height: 5.w),
              model.price < 1000000000
                  ? Text(
                      model.price > 0
                          ? AppUtil.formatMoneyInt(model.price)
                          : 'contact'.tr,
                      style: Style()
                          .subtitleStyle1
                          .copyWith(color: context.theme.primaryColor),
                      maxLines: 2,
                    )
                  : Text(
                      AppUtil.formatMoneyInt(model.price),
                      style: Style()
                          .subtitleStyle1
                          .copyWith(color: context.theme.primaryColor),
                      maxLines: 2,
                    ),
              SizedBox(height: 5.w),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateUtil.formatDate(model.createdAt),
                    style: Style().normalStyle3,
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Expanded(
                    child: Text(
                      model.location,
                      style: Style()
                          .normalStyle3
                          .copyWith(color: context.theme.highlightColor),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListView(BuildContext context, ProductModel model) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.DETAIL_CAR, arguments: model);
      },
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
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.w),
                  border:
                      Border.all(width: 2.w, color: context.theme.cardColor)),
              height: 120.w,
              child: AspectRatio(
                aspectRatio: 1.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.w),
                  child: CachedImage(
                    AppUtil().getImage(key: model.avatar.first.url ?? ''),
                    defaultUrl: AppSetting.imgLogo,
                    height: context.width,
                    width: context.width,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.title,
                    style: Style().subtitleStyle2,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 5.w,
                  ),
                  Text(
                    model.year.toString() + model.carStatus.tr,
                    style: Style()
                        .bodyStyle1
                        .copyWith(color: context.theme.hintColor),
                    maxLines: 2,
                  ),
                  SizedBox(height: 5.w),
                  Text(
                    model.price > 0
                        ? AppUtil.formatMoneyInt(model.price)
                        : 'contact'.tr,
                    style: Style()
                        .subtitleStyle1
                        .copyWith(color: context.theme.primaryColor),
                    maxLines: 2,
                  ),
                  SizedBox(height: 5.w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateUtil.formatDate(model.createdAt),
                        style: Style().normalStyle3,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Expanded(
                        child: Text(
                          model.location,
                          style: Style()
                              .normalStyle3
                              .copyWith(color: context.theme.highlightColor),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [buildFilter(context)],
      ),
    );
  }

  Widget buildFilter(BuildContext context) {
    return Column(
      children: [
        buildAction(context),
      ],
    );
  }

  Widget buildAction(BuildContext context) {
    return Container(
      // color: _theme.primaryColorLight.withAlpha(5),
      height: 32,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[],
      ),
    );
  }

  Widget buildFilterValue(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.w, top: 4.w),
      width: context.width,
      color: context.theme.cardColor,
      child: Wrap(
        children: [
          buildItemValue(context, value: controller.branchSelect.value.name),
          buildItemValue(context, value: controller.subSelect.value.name),
          buildItemValue(context, value: controller.location.value),
          buildItemValue(context, value: controller.colorValue.value.name),
          buildItemValue(context, value: controller.carStatus.value),
          buildItemValue(context, value: controller.year.value),
        ],
      ),
    );
  }

  Widget buildItemValue(BuildContext context, {required String value}) {
    return value != ''
        ? Container(
            margin: EdgeInsets.only(right: 16.w, top: 8.w),
            padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 16.w),
            decoration: BoxDecoration(
                border: Border.all(color: context.theme.highlightColor),
                color: context.theme.primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(24.w)),
            child: Text(
              value.tr,
              style: Style().normalStyle3,
            ),
          )
        : SizedBox();
  }
}
