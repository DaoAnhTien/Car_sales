import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/helpers/responsive.dart';
import 'package:oke_car_flutter/pages/historyOrder/order_model.dart';
import 'package:oke_car_flutter/utils/app_util.dart';
import 'package:oke_car_flutter/utils/auth_util.dart';
import 'package:oke_car_flutter/utils/date_util.dart';
import 'package:oke_car_flutter/values/setting.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:oke_car_flutter/widgets/_cachedImage.dart';

class OrderItem extends StatelessWidget {
  final OrderModel order;

  OrderItem({required this.order});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        // Get.toNamed(Router)
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0.w),
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
                    AppUtil()
                        .getImage(key: order.product?.avatar.first.url ?? ''),
                    defaultUrl: AppSetting.imgNoCar,
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
                      order.product?.title ?? '',
                      style: Style().subtitleStyle1,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Giá bán: ',
                          style: Style().normalStyle4,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          AppUtil.formatMoneyInt(order.product?.price ?? 0),
                          style: Style().normalStyle4.copyWith(
                              color: AuthUtil.status(order.orderStatus)),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Text(
                      'Ngày xem xe ' +
                          DateUtil.formatDate(order.bookingDate,
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
