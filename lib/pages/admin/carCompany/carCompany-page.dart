import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';
import 'package:oke_car_flutter/pages/admin/carCompany/carCompany-controller.dart';
import 'package:oke_car_flutter/pages/dashboard/model/car_company_model.dart';
import 'package:oke_car_flutter/routes/app_pages.dart';
import 'package:oke_car_flutter/utils/app_util.dart';
import 'package:oke_car_flutter/utils/dialog_util.dart';
import 'package:oke_car_flutter/values/setting.dart';
import 'package:oke_car_flutter/widgets/_cachedImage.dart';
import 'package:oke_car_flutter/widgets/custom/customAppBar/custom_app_bar.dart';

import '../../../utils/date_util.dart';
import '../../../values/style.dart';
import '../../../widgets/custom/custom_easy_refresh.dart';
import 'add-company-page.dart';

class CarCompanyPage extends GetView<CarCompanyController> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.theme.primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(
            title: 'Quản lí hãng xe',
            enableBack: false,
            actionButton: GestureDetector(
              onTap: () {
                controller.setAdd();
                Get.bottomSheet(AddCar(),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.w),
                          topRight: Radius.circular(16.w)),
                    ),
                    backgroundColor: context.theme.backgroundColor,
                    isScrollControlled: true);
              },
              child: Container(
                margin: EdgeInsets.only(right: 16.w),
                child: Icon(
                  Icons.add_circle_outline_sharp,
                  color: Style.blackColor,
                ),
              ),
            ),
          ),
          body: CustomEasyRefresh(
            controller: controller.ctrRefresh,
            onRefresh: controller.onRefresh,
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [buildProduct(context)]),
                );
              },
              childCount: 1,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildProduct(BuildContext context) {
    return Obx(
      () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: controller.listFullCar
              .map((element) => buildListView(context, element))
              .toList()),
    );
  }

  Widget buildListView(BuildContext context, CarCompanyModel model) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Get.toNamed(Routes.DETAIL_COMPANY, arguments: model
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0.w),
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(
            width: 1.0.w,
            color: Color.fromRGBO(157, 163, 172, 0.36),
          ),
        )),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.w),
                  border:
                      Border.all(width: 2.w, color: context.theme.cardColor)),
              height: 60.w,
              child: AspectRatio(
                aspectRatio: 1.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.w),
                  child: CachedImage(
                    AppUtil().getImage(key: model.avatar?.url ?? ''),
                    defaultUrl: AppSetting.imgLogo,
                    height: context.width,
                    width: context.width,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tên hãng xe: ' + model.name,
                    style: Style().subtitleStyle2,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                    onTap: () {
                      controller.setEdit(model);
                      Get.bottomSheet(AddCar(),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16.w),
                                topRight: Radius.circular(16.w)),
                          ),
                          backgroundColor: context.theme.backgroundColor,
                          isScrollControlled: true);
                    },
                    child: Icon(Icons.edit)),
                GestureDetector(
                  onTap: () {
                    DialogUtil.showConfirmDialog(
                      Get.context!,
                      title: 'Chú ý'.tr,
                      button: 'Đã hiểu' ,
                      description:
                      'Việc xoá hãng sẽ ảnh hưởng đến đến các dữ liệu khác '.tr,
                    );
                  },
                  child: Icon(
                    Icons.delete,
                    color: context.theme.primaryColorDark,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
