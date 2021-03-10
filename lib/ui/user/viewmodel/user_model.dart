import 'package:flutter/cupertino.dart';
import 'package:lighthouse_admin/model/user.dart';
import 'package:lighthouse_admin/mvvm/view_state_model.dart';
import 'package:lighthouse_admin/net/apis.dart';
import 'package:lighthouse_admin/net/dio_util.dart';
import 'package:lighthouse_admin/ui/user/page/user_page.dart';

class UserModel extends ViewStateModel {

  int page_size = 10;
  int page_num = 1;
  int count = 0;
  int page_count = 0;
  List<User> userList = [];

  UserDS userDS;

  UserModel();

  void initDS(BuildContext context, UserPageState state) {
    userDS = UserDS();
    userDS.state = state;
    userDS.context = context;
  }

  Future list({String phone, String email, String nick_name, bool silent = false}) {
    Map<String, dynamic> params = {
      'page_size': page_size,
      'page_num': page_num,
      'phone': phone,
      'email': email,
      'nick_name': nick_name,
    };

    if (!silent) {
      setBusy();
    }

    return DioUtil.getInstance().requestNetwork(Apis.URL_ACCOUNT_PAGE, "get", params: params,
        cancelToken: cancelToken,
        onSuccess: (data) {

          this.page_size = data['page_size'] ?? 0;
          this.page_num = data['page_num'] ?? 0;
          this.count = data['count'] ?? 0;
          this.page_count = data['page_count'] ?? 0;

          if (page_num > 1) {
            List<User> moreList = User.fromJsonList(data['records']) ?? [];
            userList.addAll(moreList);
          } else {
            userList = User.fromJsonList(data['records']) ?? [];
          }

          userDS.notifyListeners();

          setIdle();
        },
        onError: (errno, msg) {
          userDS.notifyListeners();
          setError(errno, message: msg);
        });
  }

}
