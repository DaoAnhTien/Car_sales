// import 'package:oke_car_flutter/utils/screen_util.dart';
// import 'package:oke_car_flutter/values/setting.dart';
// import 'package:oke_car_flutter/values/style.dart';
// import 'package:oke_car_flutter/helpers/responsive.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class BottomNavigation extends StatelessWidget {
//   final int currentIndex;
//   final ValueChanged<int> onTap;
//   final ScreenUtil sI = ScreenUtil.instance;
//
//   BottomNavigation(this.currentIndex, this.onTap);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         decoration: new BoxDecoration(
//           color: context.theme.bottomAppBarColor,
//           boxShadow: [
//             BoxShadow(
//               // color: context.theme.indicatorColorithOpacity(0.3),
//               offset: Offset(0, -0.5),
//               blurRadius: 0,
//               spreadRadius: 0,
//             )
//           ],
//         ),
//         child: Theme(
//           data: context.theme.copyWith(
//             canvasColor: Colors.transparent,
//           ),
//           child: BottomNavigationBar(
//             elevation: 0.0,
//             type: BottomNavigationBarType.fixed,
//             items: _generateListBottomNavItem(context),
//             currentIndex: currentIndex,
//             fixedColor: context.textTheme.headline2?.color,
//             iconSize: 20,
//             onTap: onTap,
//           ),
//         ));
//   }
//
//   List<BottomNavigationBarItem> _generateListBottomNavItem(
//       BuildContext context) {
//     return [
//       _buildBottomNavigationBarItem(context, 'tab_home'.tr,
//           AppSetting.ic_home, AppSetting.ic_home_filled, 0),
//       _buildBottomNavigationBarItem(context, 'tab_cart'.tr,
//           AppSetting.ic_cart, AppSetting.ic_cart_filled, 1),
//       _buildBottomNavigationBarItem(context, 'tab_wallet'.tr,
//           AppSetting.ic_bag, AppSetting.ic_bag_filled, 2),
//       _buildBottomNavigationBarItem(context, 'tab_fav'.tr,
//           AppSetting.ic_heart, AppSetting.ic_heart_filled, 3),
//       _buildBottomNavigationBarItem(context, 'tab_account'.tr,
//           AppSetting.ic_profile, AppSetting.ic_profile_filled, 4),
//     ];
//   }
//
//   BottomNavigationBarItem _buildBottomNavigationBarItem(BuildContext context,
//       String title, String iconUri, String activeIconUri, int idx) {
//     return BottomNavigationBarItem(
//         icon: Container(
//           child: Stack(
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(top: 5, left: 10, right: 10),
//                 child: Image.asset(
//                   iconUri,
//                   height: 24,
//                   width: 24,
//                   // color: context.theme.unselectedWidgetColor,
//                 ),
//               ),
//
//             ],
//           ),
//         ),
//         activeIcon: Stack(
//           children: [
//             Padding(
//               padding: EdgeInsets.only(top: 5, left: 10, right: 10),
//               child: Image.asset(
//                 activeIconUri,
//                 width: 24,
//                 height: 24,
//                 // color: context.theme.accentColor,
//               ),
//             ),
//
//           ],
//         ),
//         // ignore: deprecated_member_use
//         title: Padding(
//           padding: const EdgeInsets.only(top: 3),
//           child: Text(
//             title,
//             style: TextStyle(
//               fontFamily: Style.fontMedium,
//               fontSize: 12,
//               color: currentIndex == idx
//                   ? context.textTheme.headline1?.color
//                   : context.theme.unselectedWidgetColor,
//               letterSpacing: -0.24,
//             ),
//           ),
//         ));
//   }
//
//   _buildDemo(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(2),
//         border: Border.all(
//           color: context.theme.accentColor,
//         ),
//         color: context.theme.accentColor,
//       ),
//       child: Padding(
//         padding: EdgeInsets.only(
//           top: 1,
//           bottom: 2,
//           left: 2,
//           right: 2,
//         ),
//         child: Text(
//           'demo'.tr.toUpperCase(),
//           textAlign: TextAlign.center,
//           style: Style().normalStyle1.copyWith(
//               color: Style.textPrimaryColor,
//               fontSize: 7.sp,
//               letterSpacing: 0.03),
//         ),
//       ),
//     );
//   }
// }
