import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/pages/post/post_dashboard/controller/post_controller.dart';
import 'package:oke_car_flutter/utils/app_util.dart';
import 'package:oke_car_flutter/utils/object_util.dart';
import 'package:oke_car_flutter/values/setting.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:oke_car_flutter/widgets/_cachedImage.dart';
import 'package:oke_car_flutter/widgets/_default_text_field.dart';

class UploadImage extends GetView<PostController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => AspectRatio(
                aspectRatio: 1.3,
                child: controller.listCar.isEmpty
                    ? GestureDetector(
                        onTap: controller.uploadMedia,
                        behavior: HitTestBehavior.translucent,
                        child: Container(
                          alignment: Alignment.center,
                          width: context.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: context.theme.cardColor,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image_rounded,
                                size: 64.w,
                              ),
                              Text(
                                'Tải ảnh lên'.tr,
                                style: Style().bodyStyle3,
                              ),
                            ],
                          ),
                        ),
                      )
                    : Stack(
                        children: [
                          CachedImage(
                            AppUtil()
                                .getImage(key: controller.listCar.first.url),
                            defaultUrl: AppSetting.imgLogo,
                            width: context.width,
                            fit: BoxFit.cover,
                            radius: 24,
                          ),
                          Positioned(
                              child: Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                controller
                                    .removeImage(controller.listCar.first);
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 8.w, top: 8.w),
                                padding: EdgeInsets.all(8.w),
                                decoration: BoxDecoration(
                                    color: context.theme.backgroundColor,
                                    borderRadius: BorderRadius.circular(36.w)),
                                child: Icon(
                                  Icons.delete_forever_outlined,
                                  size: 36.w,
                                  color: context.theme.primaryColor,
                                ),
                              ),
                            ),
                          ))
                        ],
                      ),
              ),
            ),
            buildMoreImage(context),
            SizedBox(
              height: 16.w,
            ),
            Text(
              'Link Video ( Youtube)',
              style: Style().bodyStyle2,
            ),
            SizedBox(
              height: 10.w,
            ),
            DefaultTextField(
              width: double.infinity,
              radius: 10,
              hintText: 'vd : https://www.youtube.com/watch?',
              controller: controller.youtubeController,
              focusNode: controller.youtubFocus,
              textInputType: TextInputType.text,
              autoFillHints: [AutofillHints.email],
              onChanged: (text) {
                // controller.onChangeUserName(text);
                // controller.onChangeReferral(text);
              },
            ),
            buildWarning(context)
          ],
        ),
      ),
    );
  }

  Widget buildWarning(BuildContext context) {
    return Container(
      width: context.width,
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.only(top: 16.w),
      decoration: BoxDecoration(
          color: context.theme.cardColor,
          borderRadius: BorderRadius.circular(12.w)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Để bán nhanh hơn, nên đăng',
            style: Style().bodyStyle1,
          ),
          SizedBox(
            height: 8.w,
          ),
          Text(
            'Đăng ít nhất 3 tấm hình',
            style: Style().normalStyle5,
          ),
          Text(
            'Kích thước ảnh nên để 1200 x 800 px',
            style: Style().normalStyle5,
          ),
          Text(
            'Đăng ảnh giấy tờ xe để được duyệt tin nhanh hơn',
            style: Style().normalStyle5,
          ),
          Text(
            'Chụp ảnh chi tiết tay lái, sườn xe',
            style: Style().normalStyle5,
          ),
          SizedBox(
            height: 16.w,
          ),
          Text(
            'Không nên',
            style: Style().bodyStyle1,
          ),
          SizedBox(
            height: 8.w,
          ),
          Text(
            'Không sử dụng các hình ảnh từ internet, copy',
            style: Style().normalStyle5,
          ),
          Text(
            'Không chèn logo, số điện thoại',
            style: Style().normalStyle5,
          ),
        ],
      ),
    );
  }

  Widget buildMoreImage(BuildContext context) {
    return Obx(
      () => controller.listCar.isNotEmpty
          ? Container(
              margin: EdgeInsets.only(top: 16.w),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Row(
                      children: controller.listCar
                          .map((element) => Container(
                                margin: EdgeInsets.only(right: 16.w),
                                child: Stack(
                                  children: [
                                    CachedImage(
                                      AppUtil().getImage(key: element.url),
                                      defaultUrl: AppSetting.imgLogo,
                                      width: 250.w,
                                      height: 150.w,
                                      fit: BoxFit.cover,
                                      radius: 12,
                                    ),
                                    Positioned(
                                        right: 8.w,
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: GestureDetector(
                                            behavior:
                                                HitTestBehavior.translucent,
                                            onTap: () {
                                              controller.removeImage(element);
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  right: 8.w, top: 8.w),
                                              padding: EdgeInsets.all(8.w),
                                              decoration: BoxDecoration(
                                                  color: context
                                                      .theme.backgroundColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          36.w)),
                                              child: Icon(
                                                Icons.delete_forever_outlined,
                                                size: 36.w,
                                                color:
                                                    context.theme.primaryColor,
                                              ),
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                    GestureDetector(
                      onTap: controller.uploadMedia,
                      child: Container(
                        alignment: Alignment.center,
                        width: 250.w,
                        height: 150.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: context.theme.cardColor,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_rounded,
                              size: 32.w,
                            ),
                            Text(
                              'Tải ảnh lên'.tr,
                              style: Style().bodyStyle3,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          : SizedBox(),
    );
  }
}
