import 'package:flutter/cupertino.dart';
import 'package:lighthouse_admin/model/sms_type.dart';
import 'package:lighthouse_admin/mvvm/view_state_model.dart';
import 'package:lighthouse_admin/net/apis.dart';
import 'package:lighthouse_admin/net/dio_util.dart';
import 'package:lighthouse_admin/ui/sms/page/sms_type_page.dart';

class SmsTypeModel extends ViewStateModel {

  List<SmsType> smsTypeList = [];

  SmsTypeDS smsTypeDS;

  SmsTypeModel();

  void initDS(BuildContext context, SmsTypePageState state) {
    smsTypeDS = SmsTypeDS();
    smsTypeDS.state = state;
    smsTypeDS.context = context;
  }

  Future list({bool silent = false}) {
    Map<String, dynamic> params = {
    };

    if (!silent) {
      setBusy();
    }

    return DioUtil.getInstance().requestNetwork(Apis.URL_SMS_TYPE, "get", params: params,
        cancelToken: cancelToken,
        onSuccess: (data) {

          smsTypeList = SmsType.fromJsonList(data) ?? [];

          smsTypeDS.notifyListeners();

          setIdle();
        },
        onError: (errno, msg) {
          smsTypeDS.notifyListeners();
          setError(errno, message: msg);
        });
  }

}
