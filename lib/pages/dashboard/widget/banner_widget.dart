import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/constants/app_constant.dart';
import 'package:oke_car_flutter/models/user_model.dart';
import 'package:oke_car_flutter/routes/app_pages.dart';
import 'package:oke_car_flutter/utils/app_util.dart';
import 'package:oke_car_flutter/values/setting.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:oke_car_flutter/pages/dashboard/controller/dashboard_controller.dart';
import 'package:oke_car_flutter/widgets/_cachedImage.dart';
import 'package:oke_car_flutter/widgets/custom/custom_web.dart';
import 'package:oke_car_flutter/widgets/flutter_slimmer.dart';

class HeaderWidget extends GetView<DashBoardController> {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildBanner(context), _buildFlashNews(context)],
      ),
    );
  }

  _buildBanner(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 10.w, left: 16.w, right: 16.w),
        child: Stack(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 8),
                viewportFraction: 1,
                aspectRatio: 1,
                enlargeCenterPage: false,
                height: context.width * 0.4,
                onPageChanged: (index, reason) {},
              ),
              items: controller.listBanner
                  .map(
                    (banner) => Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.w),
                          border: Border.all(
                              width: 2, color: context.theme.dividerColor)),
                      margin: EdgeInsets.symmetric(horizontal: 0.w),
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                          child: Image.asset(
                            banner,
                            height: context.width * 0.4,
                            width: context.width,
                            fit: BoxFit.cover,
                          ),
                        ),
                        onTap: () {
                          // AppUtil().goDetailNFT(nft);
                        },
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ));
  }

  _buildFlashNews(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15.w, bottom: 11.w),
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: CarouselSlider(
            options: CarouselOptions(
                scrollDirection: Axis.vertical,
                autoPlay: true,
                viewportFraction: 1.0,
                enlargeCenterPage: true,
                height: 30.w),
            items: controller.text
                .map(
                  (blogs) => GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    child: Text(
                      blogs,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Style().normalStyle1,
                    ),
                  ),
                )
                .toList(),
          )),
          SizedBox(width: 7.w),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.ALL_BLOG);
            },
            behavior: HitTestBehavior.translucent,
            child: const Icon(Icons.read_more),
          ),
        ],
      ),
    );
  }
}
