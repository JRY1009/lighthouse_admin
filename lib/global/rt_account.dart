
import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lighthouse_admin/global/user_event_controller.dart';
import 'package:lighthouse_admin/model/account.dart';
import 'package:lighthouse_admin/utils/object_util.dart';
import 'package:lighthouse_admin/utils/sp_util.dart';

class RTAccount {

  static RTAccount _instance;

  static RTAccount instance() {
    if (_instance == null) {
      _instance = new RTAccount();
    }
    return _instance;
  }

  Account _activeAccount;

  Account getActiveAccount() => _activeAccount;

  setActiveAccount(Account account) {
    _activeAccount = account;
  }

  bool isLogin() {
    if (_activeAccount == null) {
      _activeAccount = loadAccount();
    }

    return !ObjectUtil.isEmptyString(_activeAccount?.token);
  }

  void logout() {
    if (_activeAccount != null) {

      _activeAccount.token = '';
      saveAccount();

      _activeAccount = null;
    }

    Get.find<UserEventController>().fireUserEvent(null, UserEventState.logout);
  }

  Account loadAccount() {
    String jsonString = GetStorage().read(SPUtil.key_latest_account);

    if (ObjectUtil.isEmptyString(jsonString)) {
      return null;
    }

    Map<String, dynamic> jsonMap = json.decode(jsonString);
    if (jsonMap == null) {
      return null;
    } else {
      return Account.fromLocalJson(jsonMap);
    }
  }

  saveAccount() async {
    await GetStorage().write(
        SPUtil.key_latest_account,
        json.encode(_activeAccount.toLocalJson())
    );
  }

}
