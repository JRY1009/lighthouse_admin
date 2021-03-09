import 'package:flutter/cupertino.dart';
import 'package:lighthouse_admin/model/friend.dart';
import 'package:lighthouse_admin/mvvm/view_state_model.dart';
import 'package:lighthouse_admin/net/apis.dart';
import 'package:lighthouse_admin/net/dio_util.dart';
import 'package:lighthouse_admin/ui/friend/page/friend_page.dart';

class FriendModel extends ViewStateModel {

  List<Friend> friendList = [];

  FriendDS friendDS;

  FriendModel();

  void initDS(BuildContext context, FriendPageState state) {
    friendDS = FriendDS();
    friendDS.state = state;
    friendDS.context = context;
  }

  Future list({bool silent = false}) {
    Map<String, dynamic> params = {
    };

    if (!silent) {
      setBusy();
    }

    return DioUtil.getInstance().requestNetwork(Apis.URL_FRIEND_LIST, "get", params: params,
        cancelToken: cancelToken,
        onSuccess: (data) {

          friendList = Friend.fromJsonList(data) ?? [];

          friendDS.notifyListeners();

          setIdle();
        },
        onError: (errno, msg) {
          friendDS.notifyListeners();
          setError(errno, message: msg);
        });
  }

  Future edit(Friend friend) {
    Map<String, dynamic> params = {
      'id': friend.id,
      'name': friend.name,
      'category': friend.category,
      'url': friend.url,
    };

    setBusy();

    return DioUtil.getInstance().requestNetwork(Apis.URL_FRIEND_EDIT, "post", params: params,
        cancelToken: cancelToken,
        onSuccess: (data) {

          int index = friendList.indexWhere((item) => item.id == friend.id);
          if (index > -1) {
            friendList[index] = friend;
          }

          friendDS.notifyListeners();

          setSuccess();
        },
        onError: (errno, msg) {
          friendDS.notifyListeners();
          setError(errno, message: msg);
        });
  }

  Future add(Friend friend) {
    Map<String, dynamic> params = {
      'name': friend.name,
      'category': friend.category,
      'url': friend.url,
    };

    setBusy();

    return DioUtil.getInstance().requestNetwork(Apis.URL_FRIEND_ADD, "post", params: params,
        cancelToken: cancelToken,
        onSuccess: (data) {

          friendList.add(friend);

          friendDS.notifyListeners();

          setSuccess();
        },
        onError: (errno, msg) {
          friendDS.notifyListeners();
          setError(errno, message: msg);
        });
  }

  Future change_status(id, status) {
    Map<String, dynamic> params = {
      'id': id,
      'status': status,
    };

    setBusy();

    return DioUtil.getInstance().requestNetwork(Apis.URL_FRIEND_CHANGE_STATUS, "post", params: params,
        cancelToken: cancelToken,
        onSuccess: (data) {

          int index = friendList.indexWhere((item) => item.id == id);
          if (index > -1) {
            friendList[index].yn = status;
          }

          friendDS.notifyListeners();

          setSuccess();
        },
        onError: (errno, msg) {
          friendDS.notifyListeners();
          setError(errno, message: msg);
        });
  }
}
