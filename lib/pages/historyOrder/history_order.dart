import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/helpers/responsive.dart';
import 'package:oke_car_flutter/pages/historyOrder/history_order_controller.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:oke_car_flutter/widgets/_custom_header.dart';
import 'package:oke_car_flutter/widgets/custom/custom_easy_refresh.dart';
import 'package:oke_car_flutter/widgets/custom/custom_indicator.dart';

import 'widget/bought_widget.dart';
import 'widget/buying_widget.dart';
import 'widget/selled_widget.dart';
import 'widget/selling_widget.dart';

class HistoryOrderPage extends GetView<HistoryOrderController> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: CustomHeaderWidget(
            title: 'Thống kê',
          ),
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: Column(
            children: [
              buildHeader(context),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15.w),
                      child: SellingWidget(),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15.w),
                      child: BuyingWidget(),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15.w),
                      child: SelledWidget(),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15.w),
                      child: BoughtWidget(),
                    ),

                  ],
                  controller: controller.tabController,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.all(0.0),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 0.0.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0.w, color: context.theme.cardColor),
        ),
      ),
      child: TabBar(
        controller: controller.tabController,
        isScrollable: false,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: context.theme.textTheme.headline1!.color,
        indicatorColor: context.theme.primaryColor,
        indicatorWeight: 3.0.sp,
        unselectedLabelColor: context.theme.hintColor,
        labelStyle: Style().bodyStyle1,
        unselectedLabelStyle: Style().bodyStyle1,
        labelPadding: EdgeInsets.symmetric(vertical: 5.0.w, horizontal: 16.w),
        tabs: [
          Tab(text: 'Đang bán'.tr),
          Tab(text: 'Đang mua'.tr),
          Tab(text: 'Đã bán'.tr),
          Tab(text: 'Đã mua'.tr),
        ],
      ),
    );
  }
}
