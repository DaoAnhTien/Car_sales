import 'dart:async';
import 'package:flutter/cupertino.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/constants/config_constant.dart';
import 'package:oke_car_flutter/controllers/theme_controller.dart';
import 'package:oke_car_flutter/i18n/translation_service.dart';
import 'package:oke_car_flutter/models/banner_model.dart';
import 'package:oke_car_flutter/models/config_model.dart';
import 'package:oke_car_flutter/models/image_model.dart';
import 'package:oke_car_flutter/models/store_model.dart';
import 'package:oke_car_flutter/models/user_model.dart';
import 'package:oke_car_flutter/repositories/authenticate_client.dart';
import 'package:oke_car_flutter/routes/app_pages.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:path_provider/path_provider.dart';
import 'package:statusbarz/statusbarz.dart';
import 'controllers/life_cycle_controller.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(ConfigModelAdapter());
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(BannerModelAdapter());
  Hive.registerAdapter(ImageModelAdapter());
  Hive.registerAdapter(StoreModelAdapter());
  //
  await Hive.openBox<ConfigModel>(BOX_CONFIG);
  await Hive.openBox<UserModel>(BOX_USER);
  await Hive.openBox<BannerModel>(BOX_SYSTEM_BANNER);
  // //
  Get.put(LifeCycleController());
  Get.lazyPut<ThemeController>(
      () => ThemeController(client: AuthenticateClient()));

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    await ThemeController.to.getThemeMode();

    runApp(
      OverlaySupport(
        child: StatusbarzCapturer(
          child: GetMaterialApp(
              title: 'Tin Bán Xe',
              theme: Style.lightTheme,
              darkTheme: Style.lightTheme,
              themeMode: ThemeController.to.themeMode,
              debugShowCheckedModeBanner: false,
              defaultTransition: Transition.rightToLeft,
              locale: TranslationService.locale,
              fallbackLocale: TranslationService.fallbackLocale,
              translations: TranslationService(),
              initialRoute: AppPages.INITIAL,
              getPages: AppPages.routes,
              navigatorObservers: kDebugMode
                  ? [
                      Statusbarz.instance.observer,
                    ]
                  : [
                      Statusbarz.instance.observer,
                    ],
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                DefaultCupertinoLocalizations.delegate,
              ],
              supportedLocales: [
                const Locale('vi'),
              ],
              onReady: () {
                // FcmService().configureSelectNotificationSubject(
                //     Get.context!, () {});
              },
              onDispose: () async {
                // await Hive.box(BOX_USER).close();
                // await Hive.box(BOX_CONFIG).close();
                // await Hive.box(BOX_SYSTEM_CONFIG).close();
                await Hive.close();
              }),
        ),
      ),
    );
  });
}
