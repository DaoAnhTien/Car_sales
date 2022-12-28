import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/widgets/_no_data_view.dart';

class CustomEasyRefresh extends StatelessWidget {
  final Future<void> Function()? onLoading;
  final EasyRefreshController? controller;
  final Future<void> Function()? onRefresh;
  final SliverChildBuilderDelegate? delegate;
  final String? infoText;

  const CustomEasyRefresh({
    this.onLoading,
    this.controller,
    this.onRefresh,
    this.delegate,
    this.infoText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasyRefresh.custom(
      enableControlFinishRefresh: false,
      enableControlFinishLoad: onLoading == null ? false : true,
      onLoad: onLoading,
      controller: controller,
      onRefresh: onRefresh,
      emptyWidget: delegate!.childCount == 0 ? const NoDataView() : null,
      header: ClassicalHeader(
        refreshText: 'pull_to_refresh'.tr,
        refreshReadyText: 'pull_to_refresh_2'.tr,
        refreshingText: 'pull_to_refresh_3'.tr,
        refreshedText: 'pull_to_refresh_4'.tr,
        infoColor: context.theme.hintColor,
        infoText: 'last_update'.tr + '%T',
        textColor: context.theme.hintColor,
      ),
      footer: ClassicalFooter(
        enableInfiniteLoad: false,
        loadText: 'pull_to_load'.tr,
        loadReadyText: 'pull_to_load_2'.tr,
        loadingText: 'pull_to_load_3'.tr,
        loadedText: 'pull_to_load_4'.tr,
        infoText: infoText,
        noMoreText: 'no_more_load'.tr,
        textColor: context.theme.hintColor,
        infoColor: context.theme.hintColor,
      ),
      slivers: <Widget>[
        SliverList(
          delegate: delegate!,
        ),
      ],
    );
  }
}
