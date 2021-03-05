
import 'package:lighthouse_admin/model/account.dart';

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
    return _activeAccount != null;
  }

  void logout() {
    if (_activeAccount != null) {

      _activeAccount.token = '';
      _activeAccount = null;
    }
  }

  Account loadAccount() {
    return null;
  }
}
