import 'package:flutter/cupertino.dart';
import 'package:lighthouse_admin/model/sms_query.dart';
import 'package:lighthouse_admin/model/user.dart';
import 'package:lighthouse_admin/mvvm/view_state_model.dart';
import 'package:lighthouse_admin/net/apis.dart';
import 'package:lighthouse_admin/net/dio_util.dart';
import 'package:lighthouse_admin/ui/sms/page/sms_query_page.dart';
import 'package:lighthouse_admin/ui/user/page/user_page.dart';

class SmsQueryModel extends ViewStateModel {

  int page_size = 10;
  int page_num = 1;
  int count = 0;
  int page_count = 0;
  List<SmsQuery> smsQueryList = [];

  SmsQueryDS smsQueryDS;

  SmsQueryModel();

  void initDS(BuildContext context, SmsQueryPageState state) {
    smsQueryDS = SmsQueryDS();
    smsQueryDS.state = state;
    smsQueryDS.context = context;
  }

  Future list({bool silent = false}) {
    Map<String, dynamic> params = {
      'page_size': page_size,
      'page_num': page_num,
    };

    if (!silent) {
      setBusy();
    }

    return DioUtil.getInstance().requestNetwork(Apis.URL_SMS_PAGE, "get", params: params,
        cancelToken: cancelToken,
        onSuccess: (data) {

          this.page_size = data['page_size'] ?? 0;
          this.page_num = data['page_num'] ?? 0;
          this.count = data['count'] ?? 0;
          this.page_count = data['page_count'] ?? 0;

          if (page_num > 1) {
            List<SmsQuery> moreList = SmsQuery.fromJsonList(data['records']) ?? [];
            smsQueryList.addAll(moreList);
          } else {
            smsQueryList = SmsQuery.fromJsonList(data['records']) ?? [];
          }

          smsQueryDS.notifyListeners();

          setIdle();
        },
        onError: (errno, msg) {
          smsQueryDS.notifyListeners();
          setError(errno, message: msg);
        });
  }

}
