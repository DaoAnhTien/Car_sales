import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:oke_car_flutter/values/style.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class CustomWebView extends StatefulWidget {
  final String url;
  final String? title;

  CustomWebView({
    required this.url,
    this.title,
  });

  @override
  _CustomWebViewState createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
    ),
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
      limitsNavigationsToAppBoundDomains: false,
    ),
  );

  String url = "";
  String title = '';
  double progress = 0;
  bool isCanBack = false;
  final urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    url = widget.url;
    print('hosting');
    print(url);
  }

  @override
  void dispose() {
    super.dispose();
  }

  canGoBack() async {
    final bool? isBack = await webViewController?.canGoBack();
    setState(() {
      isCanBack = isBack == true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: context.theme.backgroundColor,
      home: WillPopScope(
        onWillPop: () => canGoBack(),
        child: Scaffold(
            backgroundColor: context.theme.backgroundColor,
            appBar: AppBar(
              backgroundColor: Style.toastErrorBgColor,
              elevation: 0.0,
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: Style.whiteColor,
                  ),
                  onPressed: () {
                    if (isCanBack) {
                      webViewController?.goBack();
                    } else {
                      Get.back();
                    }
                  }),
              title: Text(
                title,
                textAlign: TextAlign.left,
                style: Style().subtitleStyle1.copyWith(color: Style.whiteColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              actions: [
                isCanBack
                    ? IconButton(
                        onPressed: () => Get.back(),
                        icon: Icon(
                          Icons.close,
                          color: context.theme.iconTheme.color,
                        ),
                      )
                    : SizedBox.shrink()
              ],
            ),
            body: SafeArea(
                child: Stack(
              children: [
                InAppWebView(
                  key: webViewKey,
                  initialUrlRequest: URLRequest(url: Uri.parse(url)),
                  initialOptions: options,
                  onWebViewCreated: (controller) {
                    webViewController = controller;
                  },
                  onLoadStart: (controller, url) {
                    setState(() {
                      this.url = url.toString();
                      urlController.text = this.url;
                    });
                  },
                  androidOnPermissionRequest:
                      (controller, origin, resources) async {
                    return PermissionRequestResponse(
                        resources: resources,
                        action: PermissionRequestResponseAction.GRANT);
                  },
                  shouldOverrideUrlLoading:
                      (controller, navigationAction) async {
                    var uri = navigationAction.request.url!;

                    if (![
                      "http",
                      "https",
                      "file",
                      "chrome",
                      "data",
                      "javascript",
                      "about"
                    ].contains(uri.scheme)) {
                      if (await canLaunch(url)) {
                        // Launch the App
                        await launch(url);
                        // and cancel the request
                        return NavigationActionPolicy.CANCEL;
                      }
                    }

                    return NavigationActionPolicy.ALLOW;
                  },
                  onLoadStop: (controller, url) async {
                    final String webTitle =
                        await webViewController?.getTitle() ??
                            widget.title ??
                            '';
                    setState(() {
                      this.url = url.toString();
                      this.title =
                          webTitle.isNotEmpty ? webTitle : widget.title ?? '';
                      urlController.text = this.url;
                    });
                  },
                  onTitleChanged: (controller, String? title) async {
                    final String webTitle =
                        await webViewController?.getTitle() ??
                            widget.title ??
                            '';
                    setState(() {
                      this.title = title ?? webTitle;
                    });
                  },
                  onLoadError: (controller, url, code, message) {},
                  onProgressChanged: (controller, progress) {
                    setState(() {
                      this.progress = progress / 100;
                      urlController.text = this.url;
                    });
                  },
                  onUpdateVisitedHistory:
                      (controller, url, androidIsReload) async {
                    setState(() {
                      this.url = url.toString();
                      urlController.text = this.url;
                      canGoBack();
                    });
                  },
                  onConsoleMessage: (controller, consoleMessage) {
                    print(consoleMessage);
                  },
                ),
                progress < 1.0
                    ? LinearProgressIndicator(value: progress)
                    : Container(),
                progress < 1.0
                    ? Center(
                        child: SpinKitThreeBounce(
                          color: context.theme.primaryColor,
                          size: 24,
                        ),
                      )
                    : Container(),
              ],
            ))),
      ),
    );
  }
}
