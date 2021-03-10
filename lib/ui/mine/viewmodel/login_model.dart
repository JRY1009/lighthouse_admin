import 'package:get/get.dart';
import 'package:lighthouse_admin/global/rt_account.dart';
import 'package:lighthouse_admin/global/user_event_controller.dart';
import 'package:lighthouse_admin/model/account.dart';
import 'package:lighthouse_admin/mvvm/view_state_model.dart';
import 'package:lighthouse_admin/net/apis.dart';
import 'package:lighthouse_admin/net/dio_util.dart';
import 'package:lighthouse_admin/utils/object_util.dart';

class LoginModel extends ViewStateModel {

  AccountEntity loginResult;

  LoginModel();

  Future login(email, password) {

    Map<String, dynamic> params = {
      'email': email,
      'password': password,
    };

    setBusy();

    return DioUtil.getInstance().requestNetwork(Apis.URL_LOGIN, "post", params: params,
        cancelToken: cancelToken,
        onSuccess: (data) {

          loginResult = AccountEntity.fromJson(data);
          loginResult.admin_info.token = loginResult.token;

          RTAccount.instance().setActiveAccount(loginResult.admin_info);
          RTAccount.instance().saveAccount();

          setSuccess();

          Get.find<UserEventController>().fireUserEvent(loginResult.admin_info, UserEventState.login);
        },
        onError: (errno, msg) {
          loginResult = null;
          setError(errno, message: msg);
        });

  }

  Future tokenDelay() {

    Account account = RTAccount.instance().loadAccount();
    if (ObjectUtil.isEmpty(account?.token)) {
      return Future.value(0);
    }

    setBusy();

    return DioUtil.getInstance().requestNetwork(Apis.URL_TOKEN_DELAY, "post", params: {},
        cancelToken: cancelToken,
        onSuccess: (data) {

          Account result = Account.fromJson(data);
          result.token = account?.token;

          RTAccount.instance().setActiveAccount(result);
          RTAccount.instance().saveAccount();

          setSuccess();

          Get.find<UserEventController>().fireUserEvent(loginResult.admin_info, UserEventState.userme);
        },
        onError: (errno, msg) {
          loginResult = null;
          setError(errno, message: msg);
        });

  }
}
