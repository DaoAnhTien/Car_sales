import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/models/product.model.dart';
import 'package:oke_car_flutter/pages/myNews/controller/my_post_controller.dart';
import 'package:oke_car_flutter/pages/myNews/model/my_post_model.dart';
import 'package:oke_car_flutter/routes/app_pages.dart';
import 'package:oke_car_flutter/utils/app_util.dart';
import 'package:oke_car_flutter/utils/auth_util.dart';
import 'package:oke_car_flutter/utils/date_util.dart';
import 'package:oke_car_flutter/values/setting.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:oke_car_flutter/widgets/_cachedImage.dart';
import 'package:oke_car_flutter/widgets/_custom_header.dart';
import 'package:oke_car_flutter/widgets/custom/custom_easy_refresh.dart';
import 'package:oke_car_flutter/widgets/custom/custom_indicator.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';

class MyPostView extends GetView<MyPostController> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: CustomHeaderWidget(
            title: 'Quản lí bài đăng',
          ),
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: Obx(() {
            final listBlog = controller.listPost;
            final loading = controller.loading.value;
            if (loading && listBlog.isEmpty) {
              return Center(
                child: CustomIndicator(),
              );
            }

            return CustomEasyRefresh(
              controller: controller.ctlRefresh,
              onRefresh: controller.onRefresh,
              // infoText:
              // 'show'.tr + ': ${listBlog.length}/ ${metaList.total_size}',
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return buildItem(context, listBlog[index], index);
                },
                childCount: listBlog.length,
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget buildItem(BuildContext context, ProductModel model, int index) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Get.toNamed(Routes.DETAIL_CAR, arguments: model);
      },
      child: Container(
        margin: EdgeInsets.only(top: index == 0 ? 10.w : 0),
        padding: EdgeInsets.symmetric(vertical: 10.0.w, horizontal: 16.w),
        child: SizedBox(
          height: 100.w,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AspectRatio(
                aspectRatio: 1.0,
                child: Container(
                  width: 100.w,
                  height: 100.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: context.theme.cardColor,
                  ),
                  child: CachedImage(
                    AppUtil().getImage(key: model.avatar.first.url),
                    defaultUrl: AppSetting.imgNoCar,
                    height: 100.w,
                    width: 100.w,
                    fit: BoxFit.cover,
                    radius: 4,
                    boxDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.title,
                      style: Style().subtitleStyle1,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Trạng thái: ',
                          style: Style().normalStyle4,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          AuthUtil.owner(model.status),
                          style: Style()
                              .normalStyle4
                              .copyWith(color: AuthUtil.status(model.status)),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Text(
                      'Ngày đăng tin: ' +
                          DateUtil.formatDate(model.createdAt,
                              format: DataFormats.ddMMyyyyHHmm),
                      style: Style().cardStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
