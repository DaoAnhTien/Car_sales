import 'package:iconsax/iconsax.dart';
import 'package:oke_car_flutter/constants/app_constant.dart';
import 'package:oke_car_flutter/pages/acount/acount_dashboard/controller/acount_controller.dart';
import 'package:oke_car_flutter/pages/acount/acount_dashboard/widget/profile_menu.dart';
import 'package:oke_car_flutter/pages/acount/acount_dashboard/widget/profile_picture.dart';
import 'package:oke_car_flutter/routes/app_pages.dart';
import 'package:oke_car_flutter/utils/dialog_util.dart';
import 'package:oke_car_flutter/values/setting.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';
import 'package:oke_car_flutter/widgets/custom/custom_web.dart';

class AccountPage extends GetView<AccountController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Style.whiteColor,
          body: SingleChildScrollView(
            child: Column(
              children: [buildListItem(context)],
            ),
          )),
    );
  }

  Widget buildListItem(BuildContext context) {
    return Column(
      children: [
        AccountItem(
          context: context,
          title: 'Cài đặt tài khoản',
          icon: Icon(
            Iconsax.user,
            color: context.theme.primaryColor,
          ),
          onClick: () => controller.onGotoProfile(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            height: 0.5.w,
            color: context.theme.hintColor,
          ),
        ),
        AccountItem(
          context: context,
          title: 'Quản lí bài đăng',
          icon: Icon(
            Iconsax.note_1,
            color: context.theme.primaryColor,
          ),
          onClick: () => Get.toNamed(Routes.MyPostView),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            height: 0.5.w,
            color: context.theme.hintColor,
          ),
        ),
        AccountItem(
          context: context,
          title: 'Thống kê',
          icon: Icon(
            Iconsax.chart_1,
            color: context.theme.primaryColor,
          ),
          onClick: () {
            Get.toNamed(Routes.HistoryOrderPage);
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            height: 0.5.w,
            color: context.theme.hintColor,
          ),
        ),
        AccountItem(
          context: context,
          title: 'Đổi mật khẩu',
          icon: Icon(
            Iconsax.lock,
            color: context.theme.primaryColor,
          ),
          onClick: () => Get.toNamed(Routes.CHANGE_PASS),
        ),
        Container(
          height: 8.w,
          color: context.theme.cardColor,
        ),
        AccountItem(
          context: context,
          title: 'Giá xe',
          icon: Icon(
            Iconsax.money_3,
            color: context.theme.primaryColor,
          ),
          onClick: () {
            Get.to(() => CustomWebView(
                  url: 'https://oto.com.vn/bang-gia-xe-o-to',
                  title: 'Giá xe',
                ));
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            height: 0.5.w,
            color: context.theme.hintColor,
          ),
        ),
        AccountItem(
          context: context,
          title: 'Tư vấn trả góp',
          icon: Icon(
            Iconsax.card_coin,
            color: context.theme.primaryColor,
          ),
          onClick: () {
            Get.to(() => CustomWebView(
                  url: 'https://www.carmudi.vn/blog-xe-hoi/bang-tinh-mua-xe-tra-gop/',
                  title: 'Vay trả góp',
                ));
          },
        ),
        Container(
          height: 8.w,
          color: context.theme.cardColor,
        ),
        AccountItem(
          context: context,
          title: 'Điều khoản & điều kiện',
          icon: Icon(
            Iconsax.security,
            color: context.theme.primaryColor,
          ),
          onClick: () {
            Get.to(() => CustomWebView(
                  url: TERM,
                  title: 'Điều khoản & điều kiện',
                ));
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            height: 0.5.w,
            color: context.theme.hintColor,
          ),
        ),
        AccountItem(
          context: context,
          title: 'Giới thiệu',
          icon: Icon(
            Iconsax.subtitle,
            color: context.theme.primaryColor,
          ),
          onClick: () {
            Get.to(() => CustomWebView(
                  url: ABOUT_US,
                  title: 'Giới thiệu',
                ));
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            height: 0.5.w,
            color: context.theme.hintColor,
          ),
        ),
        AccountItem(
          context: context,
          title: 'Hỏi đáp',
          icon: Icon(
            Iconsax.message_question,
            color: context.theme.primaryColor,
          ),
          onClick: () {
            Get.to(() => CustomWebView(url: FAG, title: 'Hỏi đáp'));
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            height: 0.5.w,
            color: context.theme.hintColor,
          ),
        ),
        AccountItem(
          context: context,
          title: 'Liên hệ',
          icon: Icon(
            Icons.phone_outlined,
            color: context.theme.primaryColor,
          ),
          onClick: () {
            Get.to(() => CustomWebView(
                  url: CONTACT,
                  title: 'Liên hệ',
                ));

            // Get.to(() => const AboutUs());
          },
        ),
        Container(
          height: 8.w,
          color: context.theme.cardColor,
        ),
        AccountItem(
          context: context,
          title: 'Đăng xuất',
          icon: Icon(
            Iconsax.logout_1,
            color: context.theme.primaryColor,
          ),
          onClick: () {
            DialogUtil.showConfirmDialog(Get.context!,
                title: 'log_out'.tr,
                description: 'do_you_want_log_out'.tr,
                action: controller.handleLogout);
          },
        ),
      ],
    );
  }
}
