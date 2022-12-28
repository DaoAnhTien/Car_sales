// import 'package:flutter/services.dart';
// import 'package:oke_car_flutter/pages/acount/acount_dashboard/controller/acount_controller.dart';
// import 'package:oke_car_flutter/pages/acount/acount_dashboard/widget/profile_picture.dart';
// import 'package:oke_car_flutter/values/style.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:oke_car_flutter/widgets/_radius_button.dart';
// import 'package:oke_car_flutter/widgets/_title_default_text_field.dart';
// import 'package:oke_car_flutter/helpers/extension/responsive.dart';
// import 'package:oke_car_flutter/widgets/custom/customAppBar/custom_app_bar.dart';
//
// class InformationPage extends GetView<AccountController> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(),
//       backgroundColor: Style.whiteColor,
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(height: 10.w,),
//             ProfilePic(),
//             SizedBox(height: 20.w,),
//             Obx(() => TittleDefaultTextField(
//                   width: double.infinity,
//                   radius: 10,
//                   controller: controller.usernameController,
//                   focusNode: controller.usernameFocus,
//                   title: 'user_name'.tr,
//                   textInputType: TextInputType.text,
//                   autoFillHints: [AutofillHints.email],
//                   errorMsg: controller.userValid.value
//                       ? null
//                       : controller.userErrorMsg.value,
//                   outsidePadding: EdgeInsets.only(bottom: 16.w),
//                   onChanged: (text) {
//                     // controller.onChangeUserName(text);
//                     // controller.onChangeReferral(text);
//                   },
//                 )),
//             Row(
//               children: [
//                 Expanded(
//                   child: Obx(() => TittleDefaultTextField(
//                         width: double.infinity,
//                         radius: 10,
//                         controller: controller.firstnameController,
//                         focusNode: controller.firstnameFocus,
//                         title: 'sur_name'.tr,
//                         textInputType: TextInputType.text,
//                         autoFillHints: [AutofillHints.email],
//                         errorMsg: controller.userValid.value
//                             ? null
//                             : controller.userErrorMsg.value,
//                         outsidePadding: EdgeInsets.only(bottom: 16.w),
//                         onChanged: (text) {
//                           // controller.onChangeUserName(text);
//                           // controller.onChangeReferral(text);
//                         },
//                       )),
//                 ),
//                 SizedBox(width: 15.w),
//                 Expanded(
//                   child: Obx(() => TittleDefaultTextField(
//                         width: double.infinity,
//                         radius: 10,
//                         controller: controller.lastnameController,
//                         focusNode: controller.lastnameFocus,
//                         title: 'name'.tr,
//                         textInputType: TextInputType.text,
//                         autoFillHints: [AutofillHints.email],
//                         errorMsg: controller.userValid.value
//                             ? null
//                             : controller.userErrorMsg.value,
//                         outsidePadding: EdgeInsets.only(bottom: 16.w),
//                         onChanged: (text) {
//                           // controller.onChangeUserName(text);
//                           // controller.onChangeReferral(text);
//                         },
//                       )),
//                 )
//               ],
//             ),
//             Obx(() => TittleDefaultTextField(
//                   width: double.infinity,
//                   radius: 10,
//                   controller: controller.phoneController,
//                   focusNode: controller.phoneFocus,
//                   title: 'phone_number'.tr,
//                   textInputType: TextInputType.text,
//                   autoFillHints: [AutofillHints.email],
//                   errorMsg: controller.phoneValid.value
//                       ? null
//                       : controller.phoneErrorMsg.value,
//                   outsidePadding: EdgeInsets.only(bottom: 16.w),
//                   onChanged: (text) {
//                     // controller.onChangeUserName(text);
//                     // controller.onChangeReferral(text);
//                   },
//                 )),
//             Obx(() => TittleDefaultTextField(
//               width: double.infinity,
//               radius: 10,
//               controller: controller.addressController,
//               focusNode: controller.addressFocus,
//               title: 'address'.tr,
//               textInputType: TextInputType.text,
//               autoFillHints: [AutofillHints.email],
//               errorMsg: controller.addressValid.value
//                   ? null
//                   : controller.addressErrorMsg.value,
//               outsidePadding: EdgeInsets.only(bottom: 16.w),
//               onChanged: (text) {
//                 // controller.onChangeUserName(text);
//                 // controller.onChangeReferral(text);
//               },
//             )),
//             buildButtonUpdateUser(context),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildButtonUpdateUser(BuildContext context) {
//     return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
//       SizedBox(height: 16.w),
//       Obx(() => RadiusButton(
//           isFullWidth: true,
//           // isDisable: !controller.isValid(),
//           maxWidth: double.infinity,
//           radius: 24.w,
//           outsidePadding: EdgeInsets.only(
//             top: 23.w,
//             bottom: 20.w,
//           ),
//           innerPadding: controller.loading.value
//               ? EdgeInsets.only(
//               top: 14.w, bottom: 14.w, left: 20.w, right: 20.w)
//               : EdgeInsets.only(
//             top: 16.w,
//             bottom: 16.w,
//             left: 5.w,
//             right: 5.w,
//           ),
//           isLoading: controller.loading.value,
//           indicatorSize: 24.w,
//           text: 'btn_update_user'.tr,
//           fontFamily: Style.fontDemiBold,
//           fontSize: 17.sp,
//           backgroundColor: context.theme.primaryColor,
//           textColor: context.textTheme.button!.color,
//           // onTap: controller.onUpdateUser,
//         ),
//       ),
//     ]);
//   }
// }
