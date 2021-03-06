import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lighthouse_admin/generated/l10n.dart';
import 'package:lighthouse_admin/global/user_event_controller.dart';
import 'package:lighthouse_admin/mvvm/base_page.dart';
import 'package:lighthouse_admin/router/routers.dart';
import 'package:lighthouse_admin/ui/main/viewmodel/main_model.dart';
import 'package:lighthouse_admin/ui/main/widget/main_appbar.dart';
import 'package:lighthouse_admin/utils/log_util.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with BasePageMixin<MainPage> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  MainModel _mainModel = Get.put(MainModel());

  @override
  void initState() {
    super.initState();

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

    return Scaffold(
      key: scaffoldKey,
      drawer: Container(width: 200, height: double.infinity, color: Colors.red),
      endDrawer: Container(width: 200, height: double.infinity, color: Colors.yellow),
      body: Container(),
      appBar: MainAppBar(
        context,
        openMenu: () {
          scaffoldKey.currentState.openDrawer();
        },
        openSetting: () {
          scaffoldKey.currentState.openEndDrawer();
        },
        openMine: () {

        },
      ),
    );
  }

}
