import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:lighthouse_admin/generated/l10n.dart';
import 'package:lighthouse_admin/global/theme_provider.dart';
import 'package:lighthouse_admin/router/routers.dart';
import 'package:lighthouse_admin/ui/common/page/not_found_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Lighthouse Admin',
      builder: BotToastInit(),
      enableLog: false,
      navigatorObservers: [BotToastNavigatorObserver()],
      theme: ThemeProvider.getThemeData(Colors.blue),
      localizationsDelegates: [
        S.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      initialRoute: Routers.loginPage,
      unknownRoute: GetPage(name: Routers.notFoundPage, page: () => NotFoundPage()),
      getPages: Routers.pages,
      routingCallback: (routing) => Routers.onRoutingCallback(routing),
    );
  }
}
