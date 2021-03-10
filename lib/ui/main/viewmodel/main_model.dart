import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:lighthouse_admin/global/user_event_controller.dart';
import 'package:lighthouse_admin/model/tab_page_data.dart';
import 'package:lighthouse_admin/mvvm/view_state_model.dart';
import 'package:lighthouse_admin/router/routers.dart';

class MainModel extends ViewStateModel {

  String currentMenuId;
  TabController mainTabController;
  List<TabPageData> mainTabPageList = [];

  Disposer userEventDisposer;

  MainModel();

  void listenEvent() {
    if (userEventDisposer != null) {
      userEventDisposer();
    }

    UserEventController userEventController = Get.find<UserEventController>();
    userEventDisposer = userEventController.addListener(() {
      if (userEventController.state == UserEventState.logout) {
        Future.delayed(new Duration(milliseconds: 200), () {
          Get.offAllNamed(Routers.loginPage);
        });
      }
    });

  }

  void openTab(TabPageData tabPageData) {
    currentMenuId = tabPageData.id;

    int index = mainTabPageList.indexWhere((page) => page.id == tabPageData.id);
    if (index > -1) {
      mainTabController?.animateTo(index);

    } else {
      mainTabPageList.add(tabPageData);
      update();
    }
  }

  void closeTab(TabPageData tabPageData) {
    int index = mainTabPageList.indexWhere((page) => page.id == tabPageData.id);
    if (index >= mainTabPageList.length) {
      return;
    }

    mainTabPageList.removeAt(index);

    int length = mainTabPageList.length;
    if (length == 0) {
      currentMenuId = null;

    } else if (currentMenuId == tabPageData.id) {
      mainTabController?.animateTo(0);
      currentMenuId = mainTabPageList.first.id;
    }

    update();
  }
  
  void setCurrentMenuId(String menuId) {
    currentMenuId = menuId;
    update();
  }

  @override
  void onClose() {
    if (userEventDisposer != null) {
      userEventDisposer();
    }
    super.onClose();
  }
}
