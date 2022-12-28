import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:oke_car_flutter/constants/app_constant.dart';
import 'package:oke_car_flutter/models/product.model.dart';
import 'package:oke_car_flutter/models/user_model.dart';
import 'package:oke_car_flutter/pages/search/searchDashboard/controller/search_controller.dart';
import 'package:oke_car_flutter/routes/app_pages.dart';
import 'package:oke_car_flutter/utils/app_util.dart';
import 'package:oke_car_flutter/utils/date_util.dart';
import 'package:oke_car_flutter/values/setting.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:oke_car_flutter/widgets/_cachedImage.dart';
import 'package:oke_car_flutter/widgets/_no_data_view.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';
import 'package:oke_car_flutter/widgets/_title_default_text_field.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart' as blurhash;

class SearchPage extends GetView<SearchController> {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.theme.primaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: context.theme.backgroundColor,
          body: Obx(
            () => GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: controller.resetFocus,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInputSearch(context),
                  Expanded(
                    child: SingleChildScrollView(
                      child: controller.keyword.value == ''
                          ? buildHistorySearch(context)
                          : buildResult(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputSearch(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16.w, left: 16.w, right: 16.w, bottom: 16.w),
      child: Obx(() => TittleDefaultTextField(
            preIcon: Padding(
              padding: EdgeInsets.only(left: 15.0.w),
              child: Icon(
                Icons.search,
                color: context.theme.hintColor,
              ),
            ),
            width: double.infinity,
            radius: 10,
            controller: controller.searchController,
            focusNode: controller.searchFocus,
            textAlign: TextAlign.left,
            hintText: 'Nhập từ khoá'.tr,
            hintColor: context.theme.hintColor,
            innerPadding:
                EdgeInsets.only(top: 7.w, bottom: 7.w, left: 15.w, right: 15.w),
            onChanged: (text) {
              controller.onSearchKeyword(text);
            },
            suffix: controller.keyword.value.isNotEmpty
                ? GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    child: Container(
                      padding: EdgeInsets.only(left: 15.w, right: 12.w),
                      child: Icon(
                        Icons.cancel,
                        color: context.theme.colorScheme.onSecondary,
                        size: 24.w,
                      ),
                    ),
                    onTap: () {
                      controller.searchController.text = '';
                      controller.keyword.value = '';
                    },
                  )
                : null,
          )),
    );
  }

  Widget buildHistorySearch(BuildContext context) {
    return controller.matches.first != ''
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lịch sử tìm kiếm'.tr,
                  style: Style().subtitleStyle1,
                ),
                SizedBox(
                  height: 16.w,
                ),
                Wrap(
                  children: controller.matches
                      .map<Widget>((histories) =>
                          buildItemHistory(context, text: histories))
                      .toList(),
                )
              ],
            ),
          )
        : Center(child: _noHistorySearch(context));
  }

  Widget buildItemHistory(BuildContext context, {String? text}) {
    return text != ''
        ? GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              controller.keyword.value = text!;
              controller.searchController.text = text;
              controller.init();
            },
            child: Container(
                margin: EdgeInsets.only(right: 16.w, bottom: 16.w),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
                decoration: BoxDecoration(
                    color: context.theme.cardColor,
                    borderRadius: BorderRadius.circular(16.w)),
                child: Text(
                  text ?? '',
                  style: Style().bodyStyle1,
                )),
          )
        : const SizedBox();
  }

  Widget buildResult(BuildContext context) {
    return Obx(() {
      final listNFT = controller.listNFT;
      if (listNFT.isEmpty) {
        return const Center(child: NoDataView());
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              buildNFT(context),
              SizedBox(
                height: 24.w,
              ),
            ],
          ),
        ],
      );
    });
  }

  Widget buildNFT(BuildContext context) {
    return Obx(() {
      final listOwning = controller.listNFT;
      // if (controller.loadingNFT.value) {
      //   return Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       ContainerShimmer(
      //         height: 16.w,
      //         width: 200.w,
      //       ),
      //       SizedBox(
      //         height: 8.w,
      //       ),
      //       Column(
      //           children: controller.listSimple
      //               .map((element) => Container(
      //                   margin: EdgeInsets.only(bottom: 10.w),
      //                   child: const ListTileShimmer()))
      //               .toList()),
      //     ],
      //   );
      // }
      if (listOwning.isEmpty) {
        return const SizedBox();
      }
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: listOwning
              .map((element) => buildModel(context, element))
              .toList());
    });
  }

  Widget buildModel(BuildContext context, ProductModel model) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.DETAIL_CAR, arguments: model);
        controller.onSaveHistorySearch(model.title);
      },
      child: Container(
        height: 140.w,
        padding: EdgeInsets.symmetric(vertical: 16.0.w, horizontal: 16.w),
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
                    AppUtil().getImage(key: model.avatar.first.url),
                    defaultUrl: AppSetting.imgNoCar,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    model.year.toString() + ' - ' + model.carStatus,
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

  Widget _noHistorySearch(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10.w, left: 16.w, right: 16.w),
          child: Text(
            'Chưa có lịch sử'.tr,
            style: Style().noteStyle1.copyWith(
                  fontFamily: Style.fontRegular,
                ),
          ),
        ),
      ],
    );
  }

  Widget buildButton(BuildContext context) {
    return Container();
  }
}
