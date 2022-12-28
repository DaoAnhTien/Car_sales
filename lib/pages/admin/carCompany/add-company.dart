import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';
import 'package:oke_car_flutter/pages/admin/carCompany/carCompany-controller.dart';

import '../../../utils/object_util.dart';
import '../../../values/style.dart';
import '../../../widgets/_cachedImage.dart';

class ModalUploadReceipt extends GetView<CarCompanyController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32.w),
            topRight: Radius.circular(32.w),
          )),

      child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'upload_receipt_deposit'.tr,
                style: TextStyle(
                  color: context.theme.primaryColor,
                  fontSize: 16.sp,
                  fontFamily: Style.fontBold,
                ),
              ),
              GestureDetector(
                child: Container(
                  margin: EdgeInsets.all(20.w),
                  child: Obx(() {
                    // if (ObjectUtil.isNotEmpty(
                    //     controller.imgReceipt.value.url)) {
                    //   return CachedImage(
                    //     controller.imageService
                    //         .getImageUrl(controller.imgReceipt.value.url),
                    //     defaultUrl: AppSetting.icWalletFilled,
                    //     width: 232.w,
                    //     height: 247.w,
                    //     fit: BoxFit.cover,
                    //   );
                    // }

                    return DottedBorder(
                      padding: EdgeInsets.all(60.w),
                      borderType: BorderType.RRect,
                      dashPattern: [4, 4],
                      radius: Radius.circular(8.w),
                      color: Color.fromRGBO(17, 112, 223, 1.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                           Icons.drive_folder_upload,
                            color: context.theme.primaryColor,
                          ),
                          Text(
                            'upload_plus'.tr,
                            style: TextStyle(
                              color: context.theme.primaryColor,
                              fontSize: 14.sp,
                              fontFamily: Style.fontBold,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),

            ]),
      ),
    );
  }
}
