import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';
import 'package:oke_car_flutter/pages/historyOrder/history_order_controller.dart';
import 'package:oke_car_flutter/utils/app_util.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:oke_car_flutter/widgets/_no_data_view.dart';
import 'package:oke_car_flutter/widgets/custom/custom_easy_refresh.dart';
import 'package:oke_car_flutter/widgets/custom/custom_indicator.dart';

import 'order_item.dart';

class SellingWidget extends GetView<HistoryOrderController> {
  const SellingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final listSelling = controller.listSellingOrder;
      final loading = controller.loading.value;
      if (loading && listSelling.isEmpty) {
        return CustomIndicator();
      }

      if(listSelling.isEmpty) {
        return NoDataView();
      }

      return CustomEasyRefresh(
        controller: controller.ctlRefresh,
        onRefresh: controller.onRefresh,
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Column(children: [
              totalPrice(context),
              buildProcessMint(context)]);
          },
          childCount: 1,
        ),
      );
    });
  }

  Widget buildProcessMint(BuildContext context) {
    return Column(
        children: controller.listSellingOrder
            .map((element) => OrderItem(order: element))
            .toList());
  }

  Widget totalPrice(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Tổng tiền : ',
            style: Style().bodyStyle1,
          ),
          Text(AppUtil.formatMoneyInt(controller.totalListSell() ?? 0),
              style: Style()
                  .titleStyle2
                  .copyWith(color: context.theme.primaryColorDark))
        ],
      ),
    );
  }
}
