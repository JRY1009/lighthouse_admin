import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:lighthouse_admin/global/user_event_controller.dart';
import 'package:lighthouse_admin/mvvm/view_state_model.dart';
import 'package:lighthouse_admin/router/routers.dart';
import 'package:lighthouse_admin/utils/log_util.dart';

class MainModel extends ViewStateModel {

  String currentMenuId;

  Disposer userEventDisposer;

  MainModel();

  void listenEvent() {
    if (userEventDisposer != null) {
      userEventDisposer();
    }

    UserEventController userEventController = Get.find<UserEventController>();
    userEventDisposer = userEventController.addListener(() {
      LogUtil.v('UserEventController in MainModel');

      if (userEventController.state == UserEventState.logout) {
        Get.offAllNamed(Routers.loginPage);
      }
    });
  }

  @override
  void onClose() {
    if (userEventDisposer != null) {
      userEventDisposer();
    }
    super.onClose();
  }
}
