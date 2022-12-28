import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/constants/app_constant.dart';
import 'package:oke_car_flutter/models/product.model.dart';
import 'package:oke_car_flutter/pages/dashboard/controller/dashboard_controller.dart';
import 'package:oke_car_flutter/pages/dashboard/model/car_model.dart';
import 'package:oke_car_flutter/routes/app_pages.dart';
import 'package:oke_car_flutter/utils/app_util.dart';
import 'package:oke_car_flutter/utils/date_util.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:oke_car_flutter/widgets/_cachedImage.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';
import 'package:oke_car_flutter/widgets/flutter_slimmer.dart';

class LatestWidget extends GetView<DashBoardController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Obx(() {
        if (controller.loadingListLatest.value &&
            controller.listLatestPost.isEmpty) {
          return Row(
            children: listSimple.map((e) => PlayStoreShimmer()).toList(),
          );
        }
        return Row(
          children: controller.listLatestPost
              .map<Widget>(
                (carModel) => buildItem(context, carModel),
              )
              .toList(),
        );
      }),
    );
  }

  Widget buildItem(BuildContext context, ProductModel model) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.DETAIL_CAR, arguments: model);
      },
      child: Container(
        margin: EdgeInsets.only(left: 16.w),
        child: SizedBox(
          width: 140,
          child: GestureDetector(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Hero(
                    tag: model.id.toString(),
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
                ),
                SizedBox(height: 5.w),
                Text(
                  model.year.toString() +
                      ' - ' +
                      model.carStatus,
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
                      DateUtil.formatDate(model.createdAt, format: DataFormats.ddMMyyyy),
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
      ),
    );
  }
}
