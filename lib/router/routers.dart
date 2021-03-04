import 'package:flutter/material.dart';
import 'package:lighthouse_admin/global/rt_account.dart';
import 'package:lighthouse_admin/ui/common/page/not_found_page.dart';


class Routers {

  static String notFoundPage = '/notFoundPage';
  static String registerPage = '/registerPage';
  static String loginPage = '/loginPage';

  static Map<String, Widget> layoutRoutesData = {
  };

  static Map<String, Widget> routesData = {
    loginPage: Container(color: Colors.yellow),
    registerPage: Container(),
    '/': Container(),
    notFoundPage: NotFoundPage(),
  };

  static List<String> unloginRouters = ['/register'];

  static Map<String, WidgetBuilder> routes = routesData.map((key, value) {
    return MapEntry(key, (context) => value);
  });

  static onGenerateRoute(RouteSettings settings) {
    String name = settings.name;
    if (!routes.containsKey(name)) {
      name = Routers.notFoundPage;
    } else if (!RTAccount.instance().isLogin() && !unloginRouters.contains(name)) {
      name = Routers.loginPage;
    }

    return MaterialPageRoute(builder: routes[name], settings: settings);
  }
}
