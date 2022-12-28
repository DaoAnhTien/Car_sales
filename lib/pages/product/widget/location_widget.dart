import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiengviet/tiengviet.dart';
import 'package:oke_car_flutter/constants/app_constant.dart';
import 'package:oke_car_flutter/pages/product/product_dashboard/controller/product_controller.dart';
import 'package:oke_car_flutter/values/setting.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:oke_car_flutter/widgets/_custom_header.dart';
import 'package:oke_car_flutter/widgets/_radius_text_field.dart';
import 'package:oke_car_flutter/widgets/custom/customAppBar/custom_app_bar.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';

class SearchCityPage extends GetView<ProductController> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.theme.backgroundColor,
      child: SafeArea(
        bottom: false,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: CustomAppBar(
              centerTitle: true,
              title: 'location_title'.tr,
              actionButton: GestureDetector(
                onTap: () {
                  controller.location.value = '';
                  Get.back();
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(right: 16.w),
                    child: Text(
                      'all'.tr,
                      textAlign: TextAlign.center,
                      style: Style()
                          .normalStyle1
                          .copyWith(color: context.theme.highlightColor),
                    ),
                  ),
                ),
              ),
            ),
            backgroundColor: context.theme.backgroundColor,
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32.w),
                topRight: Radius.circular(32.w),
              )),
              child: Column(
                children: [
                  RadiusTextField(
                    width: double.infinity,
                    radius: 10,
                    controller: controller.keywordSearchController,
                    focusNode: controller.keywordSearchFocus,
                    bgColor: context.theme.cardColor,
                    hintText: 'search_location'.tr,
                    hintColor: context.textTheme.bodyText2!.color,
                    textColor: context.textTheme.bodyText2!.color,
                    fontSize: 14.sp,
                    shadowColor: Style.transparent,
                    preIcon: Container(
                      margin: EdgeInsets.only(left: 20.w),
                      child: Image.asset(
                        AppSetting.icSearch,
                        width: 16.w,
                        height: 16.w,
                        color: context.textTheme.bodyText2!.color,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    innerPadding: EdgeInsets.only(
                        top: 7.w, bottom: 7.w, left: 20.w, right: 20.w),
                    onChanged: (value) {
                      controller.handleSearchCity(value);
                    },
                  ),
                  SizedBox(height: 12.0.w),
                  Obx(() {
                    final keyword = controller.keyword.value;
                    var citis = LIST_CITY;

                    if (keyword.isNotEmpty || keyword != '') {
                      citis = LIST_CITY
                          .where((element) =>
                              TiengViet.parse(element).toUpperCase().indexOf(
                                  TiengViet.parse(keyword).toUpperCase()) >
                              -1)
                          .toList();
                    }

                    return Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: citis
                              .map<Widget>((city) => cityItem(
                                    city,
                                    context: context,
                                    onTap: () {
                                      controller.setCitySelected(city);
                                      // controller.filterByCity(city);
                                      Navigator.of(context).pop();
                                    },
                                    isSelected:
                                        city == controller.location.value,
                                  ))
                              .toList(),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget cityItem(String city,
      {required BuildContext context,
      GestureTapCallback? onTap,
      bool? isSelected}) {
    return Container(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          // padding: EdgeInsets.all(8.0.w),

          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: isSelected!
                        ? context.theme.highlightColor
                        : context.theme.hintColor,
                    size: 22.w,
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  Expanded(
                    child: Text(
                      city,
                      style: TextStyle(
                          color: context.textTheme.headline1!.color,
                          fontSize: 17.sp,
                          fontFamily: Style.fontDemiBold),
                    ),
                  ),
                  isSelected
                      ? Icon(
                          Icons.check_sharp,
                          color: context.theme.primaryColorLight,
                          size: 22.w,
                        )
                      : SizedBox.shrink(),
                ],
              ),
              Container(
                height: 0.5.w,
                color: context.textTheme.caption!.color,
                margin: EdgeInsets.only(top: 16.w, bottom: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}
