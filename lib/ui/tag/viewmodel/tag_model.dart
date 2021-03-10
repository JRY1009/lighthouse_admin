import 'package:flutter/cupertino.dart';
import 'package:lighthouse_admin/model/tag.dart';
import 'package:lighthouse_admin/mvvm/view_state_model.dart';
import 'package:lighthouse_admin/net/apis.dart';
import 'package:lighthouse_admin/net/dio_util.dart';
import 'package:lighthouse_admin/ui/tag/page/tag_page.dart';

class TagModel extends ViewStateModel {

  List<Tag> tagList = [];

  TagDS tagDS;

  TagModel();

  void initDS(BuildContext context, TagPageState state) {
    tagDS = TagDS();
    tagDS.state = state;
    tagDS.context = context;
  }

  Future list({bool silent = false}) {
    if (!silent) {
      setBusy();
    }

    return DioUtil.getInstance().requestNetwork(Apis.URL_TAG_LIST, "get", params: {},
        cancelToken: cancelToken,
        onSuccess: (data) {

          tagList = Tag.fromJsonList(data) ?? [];

          tagDS.notifyListeners();

          setIdle();
        },
        onError: (errno, msg) {
          tagDS.notifyListeners();
          setError(errno, message: msg);
        });
  }

  Future edit(Tag tag) {
    Map<String, dynamic> params = {
      'id': tag.id,
      'name': tag.name,
      'remark': tag.remark,
    };

    setBusy();

    return DioUtil.getInstance().requestNetwork(Apis.URL_TAG_EDIT, "post", params: params,
        cancelToken: cancelToken,
        onSuccess: (data) {

          int index = tagList.indexWhere((item) => item.id == tag.id);
          if (index > -1) {
            tagList[index] = tag;
          }

          tagDS.notifyListeners();

          setSuccess();
        },
        onError: (errno, msg) {
          tagDS.notifyListeners();
          setError(errno, message: msg);
        });
  }

  Future add(Tag tag) {
    Map<String, dynamic> params = {
      'name': tag.name,
      'remark': tag.remark,
    };

    setBusy();

    return DioUtil.getInstance().requestNetwork(Apis.URL_TAG_ADD, "post", params: params,
        cancelToken: cancelToken,
        onSuccess: (data) {

          tagList.add(tag);

          tagDS.notifyListeners();

          setSuccess();
        },
        onError: (errno, msg) {
          tagDS.notifyListeners();
          setError(errno, message: msg);
        });
  }

  Future change_status(id, status) {
    Map<String, dynamic> params = {
      'id': id,
      'status': status,
    };

    setBusy();

    return DioUtil.getInstance().requestNetwork(Apis.URL_TAG_CHANGE_STATUS, "post", params: params,
        cancelToken: cancelToken,
        onSuccess: (data) {

          int index = tagList.indexWhere((item) => item.id == id);
          if (index > -1) {
            tagList[index].yn = status;
          }

          tagDS.notifyListeners();

          setSuccess();
        },
        onError: (errno, msg) {
          tagDS.notifyListeners();
          setError(errno, message: msg);
        });
  }
}
