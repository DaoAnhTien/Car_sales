import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/pages/product/product_dashboard/controller/product_controller.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';
import 'package:oke_car_flutter/pages/product/product_dashboard/model/sort_model.dart';
import 'package:oke_car_flutter/values/style.dart';

class SortScreen extends GetView<ProductController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          SizedBox(height: 8.0.w),
          _buildHeader(context),
          // SizedBox(height: 16.0.w),
          Divider(),
          SizedBox(
            height: 16.w,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: controller.listSort
                    .map<Widget>((carModel) => cityItem(context, carModel))
                    .toList(),
              ),
            ),
          )
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
          child: Text('sort_by'.tr,
              textAlign: TextAlign.center, style: Style().subtitleStyle1),
        ),
        SizedBox(width: 30.0.w),
        // GestureDetector(
        //   behavior: HitTestBehavior.translucent,
        //   onTap: () {
        //     // controller.setDefaultValue(BRANCH);
        //   },
        //   child: Text(
        //     'all'.tr,
        //     style: Style()
        //         .normalStyle1
        //         .copyWith(color: context.theme.highlightColor),
        //   ),
        // )
      ],
    );
  }

  Widget cityItem(BuildContext context, SortModel model) {
    return Container(
      child: GestureDetector(
        onTap: () {
          controller.setSortValue(model);
        },
        child: Container(
          // padding: EdgeInsets.all(8.0.w),

          child: Column(
            children: [
              Row(
                children: [
                  model.title == controller.sortValue.value.title
                      ? Icon(
                          Icons.check_box,
                          color: context.theme.primaryColor,
                          size: 22.w,
                        )
                      : Icon(
                          Icons.check_box_outline_blank,
                          color: context.theme.hintColor,
                          size: 22.w,
                        ),
                  SizedBox(
                    width: 16.w,
                  ),
                  Expanded(
                    child: Text(
                      model.title.tr,
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
