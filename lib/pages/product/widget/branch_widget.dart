import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiengviet/tiengviet.dart';
import 'package:oke_car_flutter/constants/app_constant.dart';
import 'package:oke_car_flutter/pages/dashboard/model/car_company_model.dart';
import 'package:oke_car_flutter/pages/product/product_dashboard/controller/product_controller.dart';
import 'package:oke_car_flutter/utils/app_util.dart';
import 'package:oke_car_flutter/values/setting.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:oke_car_flutter/widgets/_cachedImage.dart';
import 'package:oke_car_flutter/widgets/_radius_text_field.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';

class BrandWidget extends GetView<ProductController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          SizedBox(height: 8.0.w),
          _buildHeader(context),
          // SizedBox(height: 16.0.w),
          Divider(),
          RadiusTextField(
            width: double.infinity,
            radius: 10,
            controller: controller.branchController,
            focusNode: controller.branchFocus,
            bgColor: context.theme.cardColor,
            hintText: 'branch_place_holder'.tr,
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
            innerPadding:
                EdgeInsets.only(top: 7.w, bottom: 7.w, left: 20.w, right: 20.w),
            onChanged: (value) {
              controller.handleSearchBranch(value);
            },
          ),
          SizedBox(
            height: 16.w,
          ),
          Obx(() {
            final keyword = controller.keywordBranch.value;
            List<CarCompanyModel> branch = controller.listFullCar;

            if (keyword.isNotEmpty || keyword != '') {
              branch = branch
                  .where((element) =>
                      TiengViet.parse(element.name)
                          .toUpperCase()
                          .indexOf(TiengViet.parse(keyword).toUpperCase()) >
                      -1)
                  .toList();
            }
            return Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: branch
                      .map<Widget>((carModel) => cityItem(context, carModel))
                      .toList(),
                ),
              ),
            );
          })
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () => Get.back()),
        Expanded(
          child: Text('branch_select'.tr,
              textAlign: TextAlign.center, style: Style().subtitleStyle1),
        ),
        SizedBox(width: 10.0.w),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            controller.setDefaultValue(BRANCH);
          },
          child: Text(
            'all'.tr,
            style: Style()
                .normalStyle1
                .copyWith(color: context.theme.highlightColor),
          ),
        )
      ],
    );
  }

  Widget cityItem(BuildContext context, CarCompanyModel model) {
    return Container(
      child: GestureDetector(
        onTap: () {
          controller.selectBranch(model);
        },
        child: Container(
          // padding: EdgeInsets.all(8.0.w),

          child: Column(
            children: [
              Row(
                children: [
                  // CachedImage(
                  //   AppUtil().getImageUrl(
                  //     key: model.icon,
                  //   ),
                  //   defaultUrl: AppSetting.imgLogo,
                  //   width: 24.w,
                  //   height: 24.w,
                  // ),
                  SizedBox(
                    width: 16.w,
                  ),
                  Expanded(
                    child: Text(
                      model.name,
                      style: TextStyle(
                          color: context.textTheme.headline1!.color,
                          fontSize: 17.sp,
                          fontFamily: Style.fontDemiBold),
                    ),
                  ),
                  model == controller.branchSelect.value
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
