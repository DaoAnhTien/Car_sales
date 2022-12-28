// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:get/get.dart';
// import 'package:oke_car_flutter/pages/dashboard/model/car_model.dart';
// import 'package:oke_car_flutter/pages/product/detail_product/controller/detail_controller.dart';
// import 'package:oke_car_flutter/routes/app_pages.dart';
// import 'package:oke_car_flutter/utils/app_util.dart';
// import 'package:oke_car_flutter/utils/date_util.dart';
// import 'package:oke_car_flutter/values/setting.dart';
// import 'package:oke_car_flutter/values/style.dart';
// import 'package:oke_car_flutter/widgets/_cachedImage.dart';
// import 'package:oke_car_flutter/helpers/extension/responsive.dart';
//
// class RelatedProducts extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Container(
//         padding: EdgeInsets.symmetric(horizontal: 16.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               height: 16.w,
//             ),
//             Text(
//               'Tin liên quan',
//               style: Style().subtitleStyle1,
//             ),
//             Column(
//               children: controller.listAllProduct
//                   .map<Widget>(
//                     (carModel) => buildListView(context, carModel),
//                   )
//                   .toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildListView(BuildContext context, CarModel model) {
//     return GestureDetector(
//       onTap: () {
//         Get.toNamed(Routes.DETAIL_CAR, arguments: {
//           'carId' : model.id.toString()
//         });
//         print("object");
//       },
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: 16.0.w),
//         decoration: BoxDecoration(
//             border: Border(
//           bottom: BorderSide(
//             width: 1.0.w,
//             color: Color.fromRGBO(157, 163, 172, 0.36),
//           ),
//         )),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10.w),
//                   border:
//                       Border.all(width: 2.w, color: context.theme.cardColor)),
//               height: 120.w,
//               child: AspectRatio(
//                 aspectRatio: 1.0,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(10.w),
//                   child: CachedImage(
//                     AppUtil().getImageUrl(key: model.thumbnail),
//                     defaultUrl: AppSetting.imgLogo,
//                     height: context.width,
//                     width: context.width,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               width: 10.w,
//             ),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     model.name,
//                     style: Style().subtitleStyle2,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   SizedBox(
//                     height: 5.w,
//                   ),
//                   Text(
//                     model.infocar.first.namsx.toString() +
//                         ' - ' +
//                         model.infocar.first.tinhtrang,
//                     style: Style()
//                         .bodyStyle1
//                         .copyWith(color: context.theme.hintColor),
//                     maxLines: 2,
//                   ),
//                   SizedBox(height: 5.w),
//                   Text(
//                     model.price > 0
//                         ? AppUtil.formatMoney(model.price)
//                         : 'contact'.tr,
//                     style: Style()
//                         .subtitleStyle1
//                         .copyWith(color: context.theme.primaryColor),
//                     maxLines: 2,
//                   ),
//                   SizedBox(height: 5.w),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         DateUtil.timeAgoSinceDate(model.created_at!),
//                         style: Style().normalStyle3,
//                       ),
//                       SizedBox(
//                         width: 8.w,
//                       ),
//                       Expanded(
//                         child: Text(
//                           model.infocar.first.location,
//                           style: Style()
//                               .normalStyle3
//                               .copyWith(color: context.theme.highlightColor),
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
