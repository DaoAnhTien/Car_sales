import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
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

class FullCarWidget extends GetView<DashBoardController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: CustomHeaderWidget(
        title: 'car_price'.trArgs([
          DateUtil.formatDate(DateTime.now(), format: DataFormats.MMMMyyyy)
        ]),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [buildList(context)],
        ),
      ),
    );
  }

  Widget buildList(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          color: context.theme.backgroundColor,
          // child: StaggeredGridView.countBuilder(
          //   shrinkWrap: true,
          //   crossAxisCount: 3,
          //   itemCount: controller.listFullCar.length,
          //   itemBuilder: (BuildContext context, int index) =>
          //       _buildCatelogy(context, controller.listFullCar[index]),
          //   staggeredTileBuilder: (int index) =>
          //       StaggeredTile.count(1, index.isEven ? 0.9.w : 0.9.w),
          //   mainAxisSpacing: 8,
          //   crossAxisSpacing: 8,
          //   addAutomaticKeepAlives: true,
          //   scrollDirection: Axis.vertical,
          //   physics: BouncingScrollPhysics(),
          // ),
        ),
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
        padding: EdgeInsets.symmetric(horizontal: 3.0.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                constraints: BoxConstraints(
                  maxHeight: 36.w,
                  maxWidth: 36.w,
                  minHeight: 36.w,
                  minWidth: 36.w,
                ),
                alignment: Alignment.center,
                // child: CachedImage(
                //   AppUtil().getImageUrl(key: carCompanyModel.icon),
                //   defaultUrl: AppSetting.imgLogo,
                // )
            ),
            SizedBox(height: 12.0.w),
            Text(
              carCompanyModel.name,
              textAlign: TextAlign.center,
              style: Style()
                  .bodyStyle1
                  .copyWith(fontSize: 11.sp, letterSpacing: 0.07.sp),
            )
          ],
        ),
      ),
    );
  }
}
