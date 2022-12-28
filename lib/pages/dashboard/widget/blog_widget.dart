import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/models/blog_model.dart';
import 'package:oke_car_flutter/pages/dashboard/controller/dashboard_controller.dart';
import 'package:oke_car_flutter/pages/dashboard/model/car_company_model.dart';
import 'package:oke_car_flutter/utils/app_util.dart';
import 'package:oke_car_flutter/utils/date_util.dart';
import 'package:oke_car_flutter/values/setting.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:oke_car_flutter/widgets/_cachedImage.dart';
import 'package:oke_car_flutter/widgets/_custom_header.dart';
import 'package:oke_car_flutter/widgets/custom/customAppBar/custom_app_bar.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';
import 'package:oke_car_flutter/widgets/custom/custom_web.dart';

class BlogWidget extends GetView<DashBoardController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        child: Column(
            children: controller.blogs
                .map((element) => buildItem(context, element,
                    controller.blogs.indexWhere((e) => element.id == e.id)))
                .toList()),
      ),
    );
  }

  Widget buildItem(BuildContext context, BlogModel blog, int index) {
    if (index == 0) {
      return Container(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedImage(
              AppUtil().getImage(key: blog.urlToImage),
              defaultUrl: AppSetting.imgLogo,
              height: 200.w,
              width: context.width,
              fit: BoxFit.cover,
              radius: 4,
              boxDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            SizedBox(
              height: 8.w,
            ),
            Text(
              blog.title,
              style: Style().subtitleStyle1,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              blog.description,
              style: Style().subtitleStyle2.copyWith(fontSize: 13.sp),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              DateUtil.formatDate(
                  DateUtil.getDateTimeByMs(blog.publishedAt * 1000),
                  format: DataFormats.ddMMyyyyHHmm),
              style: Style().cardStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 16.w,
            ),
            Container(
              color: context.theme.dividerColor,
              height: 1.w,
            )
          ],
        ),
      );
    }
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Get.to(() =>
            CustomWebView(url: AppUtil().url(key: blog.url), title: ''.tr));
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
                    AppUtil().getImage(key: blog.urlToImage),
                    defaultUrl: AppSetting.imgLogo,
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
                      blog.title,
                      style: Style().subtitleStyle1,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      blog.description,
                      style: Style().subtitleStyle2.copyWith(fontSize: 13.sp),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      DateUtil.formatDate(
                          DateUtil.getDateTimeByMs(blog.publishedAt * 1000),
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
