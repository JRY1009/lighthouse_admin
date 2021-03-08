import 'package:flutter/cupertino.dart';
import 'package:lighthouse_admin/model/friend.dart';
import 'package:lighthouse_admin/mvvm/view_state_model.dart';
import 'package:lighthouse_admin/net/apis.dart';
import 'package:lighthouse_admin/net/dio_util.dart';
import 'package:lighthouse_admin/ui/friend/page/friend_page.dart';
import 'package:lighthouse_admin/utils/object_util.dart';

class FriendModel extends ViewStateModel {

  List<Friend> friendList = [];

  FriendDS friendDS;

  FriendModel();

  void initDS(BuildContext context, FriendPageState state) {
    friendDS = FriendDS();
    friendDS.state = state;
    friendDS.context = context;
  }

  Future list() {

    Map<String, dynamic> params = {
    };

    setBusy();

    return DioUtil.getInstance().requestNetwork(Apis.URL_FRIEND_LIST, "get", params: params,
        cancelToken: cancelToken,
        onSuccess: (data) {

          friendList = Friend.fromJsonList(data) ?? [];

          friendDS.notifyListeners();

          if (ObjectUtil.isEmptyList(friendList)) {
            setEmpty();
          } else {
            setSuccess();
          }
        },
        onError: (errno, msg) {
          friendDS.notifyListeners();
          setError(errno, message: msg);
        });

  }

}
