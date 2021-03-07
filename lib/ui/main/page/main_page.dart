import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lighthouse_admin/generated/l10n.dart';
import 'package:lighthouse_admin/model/tab_page_data.dart';
import 'package:lighthouse_admin/mvvm/base_page.dart';
import 'package:lighthouse_admin/router/routers.dart';
import 'package:lighthouse_admin/ui/main/viewmodel/main_model.dart';
import 'package:lighthouse_admin/ui/main/widget/main_appbar.dart';
import 'package:lighthouse_admin/ui/main/widget/main_center.dart';
import 'package:lighthouse_admin/ui/main/widget/main_menu.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with BasePageMixin<MainPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TabPageData _initPage;

  MainModel _mainModel = Get.put(MainModel());

  @override
  void initState() {
    super.initState();

    _initPage = TabPageData(id: '101', url: Routers.accountPage, name: S.current.menuAccount);

    initViewModel();
  }

  void initViewModel() {
    _mainModel.listenEvent();
  }

  void _jump2Register() {
    Get.offNamed(Routers.settingPage);
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<MainModel>(
        builder: (_) {
          Widget mainMenu = MainMenu(
              onMenuSelect: (tabPageData) => _mainModel.openTab(tabPageData)
          );

          return Scaffold(
            key: _scaffoldKey,
            drawer: mainMenu,
            endDrawer: Container(width: 200, height: double.infinity, color: Colors.yellow),
            appBar: MainAppBar(context,
              openMenu: () => _scaffoldKey.currentState.openDrawer(),
              openSetting: () => _scaffoldKey.currentState.openEndDrawer(),
              openMine: () {},
            ),
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                mainMenu,
                MainCenter(initPage: _initPage),
              ],
            ),
          );
        });
  }

}
