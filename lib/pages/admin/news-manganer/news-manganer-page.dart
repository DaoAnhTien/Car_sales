import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';
import 'package:oke_car_flutter/pages/admin/news-manganer/news-manganer-controller.dart';

import '../../../models/product.model.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/app_util.dart';
import '../../../utils/auth_util.dart';
import '../../../utils/date_util.dart';
import '../../../values/setting.dart';
import '../../../values/style.dart';
import '../../../widgets/_cachedImage.dart';
import '../../../widgets/custom/custom_easy_refresh.dart';

class NewsManganerPage extends GetView<NewsManganerController> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: CustomEasyRefresh(
            controller: controller.ctrRefresh,
            onRefresh: controller.onRefresh,
            onLoading: controller.onLoading,
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 16.w,
                        ),
                        buildProduct(context)
                      ]),
                );
              },
              childCount: 1,
            )),
      ),
    );
  }

  Widget buildProduct(BuildContext context) {
    return Obx(
      () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: controller.listLatestPost
              .map((element) => buildListView(context, element))
              .toList()),
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
                  ),
                  SizedBox(
                    height: 12.w,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AuthUtil.status(model.status)),
                    child: Text(
                      AuthUtil.owner(model.status),
                      style: Style().textStyle(
                        fontFamily: Style.fontMedium,
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

// void _buildIntervalFilter(BuildContext context) {
//   controller.menuFilterUser = PopupMenu(
//     items: AppUtil.map<MenuItemProvider>(FILTER_BY_STATUS, (index, item) {
//       return MenuItem(
//         key: item,
//         title: item.toString().tr,
//         textStyle: const TextStyle(
//           color: Style.blackColor,
//         ),
//       );
//     }).toList(),
//     itemWidth: 300.w,
//     itemHeight: 65.w,
//     selected: controller.filterUserRole.value,
//     onClickMenu: controller.onIntervalFilter,
//     onDismiss: controller.onDismiss,
//     maxColumn: 1,
//     backgroundColor: context.theme.cardColor,
//     highlightColor: context.theme.backgroundColor,
//     lineColor: context.theme.dividerColor,
//     context: context,
//   );
//   controller.menuFilterUser!.show(widgetKey: controller.keyIntervalFilter);
// }

}
