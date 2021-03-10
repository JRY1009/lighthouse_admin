import 'package:flutter/cupertino.dart';
import 'package:lighthouse_admin/model/chain_info.dart';
import 'package:lighthouse_admin/mvvm/view_state_model.dart';
import 'package:lighthouse_admin/net/apis.dart';
import 'package:lighthouse_admin/net/dio_util.dart';
import 'package:lighthouse_admin/ui/chaininfo/page/chain_info_page.dart';

class ChainInfoModel extends ViewStateModel {

  List<ChainInfo> chainInfoList = [];

  ChainInfoDS chainInfoDS;

  ChainInfoModel();

  void initDS(BuildContext context, ChainInfoPageState state) {
    chainInfoDS = ChainInfoDS();
    chainInfoDS.state = state;
    chainInfoDS.context = context;
  }

  Future list({bool silent = false}) {
    Map<String, dynamic> params = {
    };

    if (!silent) {
      setBusy();
    }

    return DioUtil.getInstance().requestNetwork(Apis.URL_CHAIN_LIST, "get", params: params,
        cancelToken: cancelToken,
        onSuccess: (data) {

          chainInfoList = ChainInfo.fromJsonList(data) ?? [];

          chainInfoDS.notifyListeners();

          setIdle();
        },
        onError: (errno, msg) {
          chainInfoDS.notifyListeners();
          setError(errno, message: msg);
        });
  }

  Future edit(ChainInfo chainInfo) {
    Map<String, dynamic> params = {
      'id': chainInfo.id,
      'name': chainInfo.name,
      'symbol': chainInfo.symbol,
      'url': chainInfo.url,
      'chain': chainInfo.chain,
      'total_market_value': chainInfo.total_market_value,
      'ratio': chainInfo.ratio,
      'total_supply': chainInfo.total_supply,
      'core_algorithm': chainInfo.core_algorithm,
      'core_algorithm_remark': chainInfo.core_algorithm_remark,
      'consensus_mechanism': chainInfo.consensus_mechanism,
      'consensus_mechanism_remark': chainInfo.consensus_mechanism_remark,
      'start_date': chainInfo.start_date,
      'content': chainInfo.content,
    };

    setBusy();

    return DioUtil.getInstance().requestNetwork(Apis.URL_CHAIN_EDIT, "post", params: params,
        cancelToken: cancelToken,
        onSuccess: (data) {

          int index = chainInfoList.indexWhere((item) => item.id == chainInfo.id);
          if (index > -1) {
            chainInfoList[index] = chainInfo;
          }

          chainInfoDS.notifyListeners();

          setSuccess();
        },
        onError: (errno, msg) {
          chainInfoDS.notifyListeners();
          setError(errno, message: msg);
        });
  }

  Future add(ChainInfo chainInfo) {
    Map<String, dynamic> params = {
      'name': chainInfo.name,
      'symbol': chainInfo.symbol,
      'url': chainInfo.url,
      'chain': chainInfo.chain,
      'total_market_value': chainInfo.total_market_value,
      'ratio': chainInfo.ratio,
      'total_supply': chainInfo.total_supply,
      'core_algorithm': chainInfo.core_algorithm,
      'core_algorithm_remark': chainInfo.core_algorithm_remark,
      'consensus_mechanism': chainInfo.consensus_mechanism,
      'consensus_mechanism_remark': chainInfo.consensus_mechanism_remark,
      'start_date': chainInfo.start_date,
      'content': chainInfo.content,
    };

    setBusy();

    return DioUtil.getInstance().requestNetwork(Apis.URL_CHAIN_ADD, "post", params: params,
        cancelToken: cancelToken,
        onSuccess: (data) {

          chainInfoList.add(chainInfo);

          chainInfoDS.notifyListeners();

          setSuccess();
        },
        onError: (errno, msg) {
          chainInfoDS.notifyListeners();
          setError(errno, message: msg);
        });
  }

  Future change_status(id, status) {
    Map<String, dynamic> params = {
      'id': id,
      'status': status,
    };

    setBusy();

    return DioUtil.getInstance().requestNetwork(Apis.URL_CHAIN_CHANGE_STATUS, "post", params: params,
        cancelToken: cancelToken,
        onSuccess: (data) {

          int index = chainInfoList.indexWhere((item) => item.id == id);
          if (index > -1) {
            chainInfoList[index].yn = status;
          }

          chainInfoDS.notifyListeners();

          setSuccess();
        },
        onError: (errno, msg) {
          chainInfoDS.notifyListeners();
          setError(errno, message: msg);
        });
  }
}
