import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lighthouse_admin/global/rt_account.dart';
import 'package:lighthouse_admin/ui/common/page/not_found_page.dart';
import 'package:lighthouse_admin/ui/mine/page/login_page.dart';
import 'package:lighthouse_admin/ui/mine/page/setting_page.dart';
import 'package:lighthouse_admin/utils/log_util.dart';

class Routers {

  static String initial = '/';
  static String notFoundPage = '/notFoundPage';
  static String settingPage = '/settingPage';
  static String loginPage = '/loginPage';

  static final pages = [
    GetPage(name: Routers.initial, page: () => Container()),
    GetPage(name: Routers.notFoundPage, page: () => NotFoundPage()),
    GetPage(name: Routers.loginPage, page: () => LoginPage(), transition: Transition.fade),
    GetPage(name: Routers.settingPage, page: () => SettingPage(), transition: Transition.fade),
  ];

  static onRoutingCallback(Routing routing) {
    LogUtil.v('routingCallback ${routing.current}');
  }

  static void loginNamedTo(String path, {dynamic arguments}) {
    Get.toNamed(RTAccount.instance().isLogin() ? path : Routers.loginPage, arguments: arguments);
  }

  static void loginNamedOff(String path, {dynamic arguments}) {
    Get.offNamed(RTAccount.instance().isLogin() ? path : Routers.loginPage, arguments: arguments);
  }
}
