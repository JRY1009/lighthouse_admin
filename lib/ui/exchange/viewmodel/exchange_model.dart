import 'package:flutter/cupertino.dart';
import 'package:lighthouse_admin/model/exchange.dart';
import 'package:lighthouse_admin/mvvm/view_state_model.dart';
import 'package:lighthouse_admin/net/apis.dart';
import 'package:lighthouse_admin/net/dio_util.dart';
import 'package:lighthouse_admin/ui/exchange/page/exchange_page.dart';

class ExchangeModel extends ViewStateModel {

  List<Exchange> exchangeList = [];

  ExchangeDS exchangeDS;

  ExchangeModel();

  void initDS(BuildContext context, ExchangePageState state) {
    exchangeDS = ExchangeDS();
    exchangeDS.state = state;
    exchangeDS.context = context;
  }

  Future list({bool silent = false}) {
    Map<String, dynamic> params = {
    };

    if (!silent) {
      setBusy();
    }

    return DioUtil.getInstance().requestNetwork(Apis.URL_EXCHANGE_LIST, "get", params: params,
        cancelToken: cancelToken,
        onSuccess: (data) {

          exchangeList = Exchange.fromJsonList(data) ?? [];

          exchangeDS.notifyListeners();

          setIdle();
        },
        onError: (errno, msg) {
          exchangeDS.notifyListeners();
          setError(errno, message: msg);
        });
  }

  Future edit(Exchange exchange) {
    Map<String, dynamic> params = {
      'id': exchange.id,
      'name': exchange.name,
      'ico': exchange.ico,
      'url': exchange.url,
      'remark': exchange.remark,
    };

    setBusy();

    return DioUtil.getInstance().requestNetwork(Apis.URL_EXCHANGE_EDIT, "post", params: params,
        cancelToken: cancelToken,
        onSuccess: (data) {

          int index = exchangeList.indexWhere((item) => item.id == exchange.id);
          if (index > -1) {
            exchangeList[index] = exchange;
          }

          exchangeDS.notifyListeners();

          setSuccess();
        },
        onError: (errno, msg) {
          exchangeDS.notifyListeners();
          setError(errno, message: msg);
        });
  }

  Future add(Exchange exchange) {
    Map<String, dynamic> params = {
      'name': exchange.name,
      'ico': exchange.ico,
      'url': exchange.url,
      'remark': exchange.remark,
    };

    setBusy();

    return DioUtil.getInstance().requestNetwork(Apis.URL_EXCHANGE_ADD, "post", params: params,
        cancelToken: cancelToken,
        onSuccess: (data) {

          exchangeList.add(exchange);

          exchangeDS.notifyListeners();

          setSuccess();
        },
        onError: (errno, msg) {
          exchangeDS.notifyListeners();
          setError(errno, message: msg);
        });
  }

  Future change_status(id, status) {
    Map<String, dynamic> params = {
      'id': id,
      'status': status,
    };

    setBusy();

    return DioUtil.getInstance().requestNetwork(Apis.URL_EXCHANGE_CHANGE_STATUS, "post", params: params,
        cancelToken: cancelToken,
        onSuccess: (data) {

          int index = exchangeList.indexWhere((item) => item.id == id);
          if (index > -1) {
            exchangeList[index].yn = status;
          }

          exchangeDS.notifyListeners();

          setSuccess();
        },
        onError: (errno, msg) {
          exchangeDS.notifyListeners();
          setError(errno, message: msg);
        });
  }
}
