import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lighthouse_admin/global/rt_account.dart';
import 'package:lighthouse_admin/ui/chaininfo/page/chain_info_page.dart';
import 'package:lighthouse_admin/ui/common/page/not_found_page.dart';
import 'package:lighthouse_admin/ui/exchange/page/exchange_page.dart';
import 'package:lighthouse_admin/ui/friend/page/friend_page.dart';
import 'package:lighthouse_admin/ui/main/page/main_page.dart';
import 'package:lighthouse_admin/ui/milestone/page/milestone_page.dart';
import 'package:lighthouse_admin/ui/mine/page/login_page.dart';
import 'package:lighthouse_admin/ui/mine/page/mine_page.dart';
import 'package:lighthouse_admin/ui/mine/page/setting_page.dart';
import 'package:lighthouse_admin/ui/sms/page/sms_query_page.dart';
import 'package:lighthouse_admin/ui/sms/page/sms_type_page.dart';
import 'package:lighthouse_admin/ui/tag/page/tag_page.dart';
import 'package:lighthouse_admin/ui/user/page/user_page.dart';

class Routers {

  static String mainPage = '/mainPage';
  static String notFoundPage = '/notFoundPage';
  static String settingPage = '/settingPage';
  static String loginPage = '/loginPage';

  static final pages = [
    GetPage(name: Routers.mainPage, page: () => MainPage()),
    GetPage(name: Routers.notFoundPage, page: () => NotFoundPage()),
    GetPage(name: Routers.loginPage, page: () => LoginPage(), transition: Transition.fade),
    GetPage(name: Routers.settingPage, page: () => SettingPage(), transition: Transition.fade),
  ];

  static String accountPage = '/accountPage';
  static String chainPage = '/chainPage';
  static String exchangePage = '/exchangePage';
  static String friendsPage = '/friendsPage';
  static String milestonePage = '/milestonePage';
  static String quoteGlobalPage = '/quoteGlobalPage';
  static String quoteTreemapPage = '/quoteTreemapPage';
  static String smsQueryPage = '/smsQueryPage';
  static String smsTypePage = '/smsTypePage';
  static String tagPage = '/tagPage';
  static String minePage = '/minePage';

  static final Map<String, Widget> mainRouters = {
    accountPage: UserPage(),
    chainPage: ChainInfoPage(),
    exchangePage: ExchangePage(),
    friendsPage: FriendPage(),
    milestonePage: MilestonePage(),
    quoteGlobalPage: Container(color: Colors.cyan, child: Center(child: Text('啥也没有憋瞎点'))),
    quoteTreemapPage: Container(color: Colors.lime, child: Center(child: Text('啥也没有憋瞎点'))),
    smsQueryPage: SmsQueryPage(),
    smsTypePage: SmsTypePage(),
    tagPage: TagPage(),
    minePage: MinePage(),
  };

  static onRoutingCallback(Routing routing) {
    //LogUtil.v('routingCallback ${routing.current}');
  }

  static void loginNamedTo(String path, {dynamic arguments}) {
    Get.toNamed(RTAccount.instance().isLogin() ? path : Routers.loginPage, arguments: arguments);
  }

  static void loginNamedOff(String path, {dynamic arguments}) {
    Get.offNamed(RTAccount.instance().isLogin() ? path : Routers.loginPage, arguments: arguments);
  }
}
