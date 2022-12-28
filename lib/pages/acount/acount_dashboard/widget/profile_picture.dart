import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:oke_car_flutter/pages/acount/acount_dashboard/controller/acount_controller.dart';
import 'package:oke_car_flutter/values/setting.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:oke_car_flutter/widgets/_cachedImage.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';

class ProfilePic extends GetView<AccountController> {
  @override
  Widget build(BuildContext context) {
    // String img = controller.user.value.image;
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey,
          // child: ClipOval(
          //     child: CachedImage(
          //   "https://oke_car_flutter.vn/" + img,
          //   defaultUrl: AppSetting.imgProfile,
          //   width: context.width,
          //   fit: BoxFit.cover,
          // )
          // ),
        ),
        SizedBox(
          width: 16.w,
        ),
        Text(
          controller.user.value.email,
          style: Style().subtitleStyle1,
        )
      ],
    );
  }
}
