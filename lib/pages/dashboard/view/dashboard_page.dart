import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:oke_car_flutter/pages/dashboard/controller/dashboard_controller.dart';
import 'package:oke_car_flutter/pages/dashboard/model/car_company_model.dart';
import 'package:oke_car_flutter/pages/dashboard/widget/banner_widget.dart';
import 'package:oke_car_flutter/pages/dashboard/widget/blog_widget.dart';
import 'package:oke_car_flutter/pages/dashboard/widget/full_car_widget.dart';
import 'package:oke_car_flutter/pages/dashboard/widget/latest_widget.dart';
import 'package:oke_car_flutter/pages/dashboard/widget/show_room_widget.dart';
import 'package:oke_car_flutter/pages/dashboard/widget/title_widget.dart';
import 'package:oke_car_flutter/pages/dashboard/widget/user_app_bar.dart';
import 'package:oke_car_flutter/pages/dashboard/widget/vip_car_widget.dart';
import 'package:oke_car_flutter/routes/app_pages.dart';
import 'package:oke_car_flutter/utils/app_util.dart';
import 'package:oke_car_flutter/utils/date_util.dart';
import 'package:oke_car_flutter/utils/dialog_util.dart';
import 'package:oke_car_flutter/values/setting.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:oke_car_flutter/widgets/_cachedImage.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';

import '../../../widgets/custom/custom_easy_refresh.dart';

class DashBoardPage extends GetView<DashBoardController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      color: context.theme.primaryColor,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: context.theme.backgroundColor,
          body: Column(
            children: [
              HomeAppBar(),
              Expanded(
                child: CustomEasyRefresh(
                  controller: controller.ctrRefresh,
                  onRefresh: controller.onRefresh,
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HeaderWidget(),
                          Container(
                            height: 10,
                            color: context.theme.dividerColor,
                          ),
                          TitleWidget(
                            onTap: controller.goViewAll,
                            sub: 'Xem tất cả',
                            title: 'latest_post'.tr,
                            image: Image.asset(
                              AppSetting.icGiftNew,
                              width: 36.w,
                            ),
                          ),
                          LatestWidget(),
                          Container(
                            height: 10,
                            margin: EdgeInsets.only(top: 4.w),
                            color: context.theme.dividerColor,
                          ),
                          TitleWidget(
                            onTap: controller.goViewAll,
                            title: 'Hãng xe bán chạy nhất'.tr,
                          ),
                          buildList(context),
                          Container(
                            height: 10,
                            margin: EdgeInsets.only(top: 4.w),
                            color: context.theme.dividerColor,
                          ),
                          TitleWidget(
                            onTap: controller.goViewAll,
                            title: 'Xe bán nổi bật'.tr,
                          ),
                          VipCarWidget()
                        ],
                      );
                    },
                    childCount: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildList(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              color: context.theme.backgroundColor,
              child: StaggeredGrid.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  children: controller.listCarModel
                      .map(
                        (element) => _buildCatelogy(context, element),
                      )
                      .toList())),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.w),
          child: GestureDetector(
            onTap: () {
              Get.to(() => FullCarWidget());
            },
            child: Text(
              'more'.tr,
              style: Style().primaryStyle.copyWith(
                    decoration: TextDecoration.underline,
                  ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildCatelogy(BuildContext context, CarCompanyModel carCompanyModel) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        // controller.openPriceWeb(carCompanyModel.slug);
      },
      child: Container(
        decoration: BoxDecoration(
            color: context.theme.backgroundColor,
            borderRadius: BorderRadius.circular(8.w),
            border: Border.all(width: 0.5.w, color: context.theme.hintColor)),
        padding: EdgeInsets.symmetric(horizontal: 3.0.w, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                constraints: BoxConstraints(
                  maxHeight: 70.w,
                  maxWidth: 70.w,
                  minHeight: 70.w,
                  minWidth: 70.w,
                ),
                alignment: Alignment.center,
                child: CachedImage(
                  AppUtil().getImage(key: carCompanyModel.avatar?.url ?? ''),
                  defaultUrl: AppSetting.imgLogo,
                )),
            SizedBox(height: 12.0.w),
            Text(
              carCompanyModel.name,
              textAlign: TextAlign.center,
              style: Style()
                  .titleStyle2
                  .copyWith(fontSize: 11.sp, letterSpacing: 0.07.sp),
            )
          ],
        ),
      ),
    );
  }
}
