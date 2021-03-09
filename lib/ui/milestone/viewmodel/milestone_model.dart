import 'package:flutter/cupertino.dart';
import 'package:lighthouse_admin/model/milestone.dart';
import 'package:lighthouse_admin/mvvm/view_state_model.dart';
import 'package:lighthouse_admin/net/apis.dart';
import 'package:lighthouse_admin/net/dio_util.dart';
import 'package:lighthouse_admin/ui/milestone/page/milestone_page.dart';

class MilestoneModel extends ViewStateModel {

  List<Milestone> milestoneList = [];

  MilestoneDS milestoneDS;

  MilestoneModel();

  void initDS(BuildContext context, MilestonePageState state) {
    milestoneDS = MilestoneDS();
    milestoneDS.state = state;
    milestoneDS.context = context;
  }

  Future list({bool silent = false}) {
    Map<String, dynamic> params = {
    };

    if (!silent) {
      setBusy();
    }

    return DioUtil.getInstance().requestNetwork(Apis.URL_MILESTONE_LIST, "get", params: params,
        cancelToken: cancelToken,
        onSuccess: (data) {

          milestoneList = Milestone.fromJsonList(data) ?? [];

          milestoneDS.notifyListeners();

          setIdle();
        },
        onError: (errno, msg) {
          milestoneDS.notifyListeners();
          setError(errno, message: msg);
        });
  }

  Future edit(Milestone milestone) {
    Map<String, dynamic> params = {
      'id': milestone.id,
      'date': milestone.date,
      'tag': milestone.tag,
      'content': milestone.content,
    };

    setBusy();

    return DioUtil.getInstance().requestNetwork(Apis.URL_MILESTONE_EDIT, "post", params: params,
        cancelToken: cancelToken,
        onSuccess: (data) {

          int index = milestoneList.indexWhere((item) => item.id == milestone.id);
          if (index > -1) {
            milestoneList[index] = milestone;
          }

          milestoneDS.notifyListeners();

          setSuccess();
        },
        onError: (errno, msg) {
          milestoneDS.notifyListeners();
          setError(errno, message: msg);
        });
  }

  Future add(Milestone milestone) {
    Map<String, dynamic> params = {
      'date': milestone.date,
      'tag': milestone.tag,
      'content': milestone.content,
    };

    setBusy();

    return DioUtil.getInstance().requestNetwork(Apis.URL_MILESTONE_ADD, "post", params: params,
        cancelToken: cancelToken,
        onSuccess: (data) {

          milestoneList.add(milestone);

          milestoneDS.notifyListeners();

          setSuccess();
        },
        onError: (errno, msg) {
          milestoneDS.notifyListeners();
          setError(errno, message: msg);
        });
  }

  Future change_status(id, status) {
    Map<String, dynamic> params = {
      'id': id,
      'status': status,
    };

    setBusy();

    return DioUtil.getInstance().requestNetwork(Apis.URL_MILESTONE_CHANGE_STATUS, "post", params: params,
        cancelToken: cancelToken,
        onSuccess: (data) {

          int index = milestoneList.indexWhere((item) => item.id == id);
          if (index > -1) {
            milestoneList[index].yn = status;
          }

          milestoneDS.notifyListeners();

          setSuccess();
        },
        onError: (errno, msg) {
          milestoneDS.notifyListeners();
          setError(errno, message: msg);
        });
  }
}
