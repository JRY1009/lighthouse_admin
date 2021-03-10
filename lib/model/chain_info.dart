
import 'package:lighthouse_admin/utils/object_util.dart';

class ChainInfo {

  int id;
  String name;
  String symbol;
  String url;
  String chain;
  num total_market_value;
  num ratio;
  num total_supply;
  String core_algorithm;
  String core_algorithm_remark;
  String consensus_mechanism;
  String consensus_mechanism_remark;
  String start_date;
  String content;
  String created_at;
  String updated_at;
  int yn;


  ChainInfo({
    this.id,
    this.name,
    this.symbol,
    this.url,
    this.chain,
    this.total_market_value,
    this.ratio,
    this.total_supply,
    this.core_algorithm,
    this.core_algorithm_remark,
    this.consensus_mechanism,
    this.consensus_mechanism_remark,
    this.start_date,
    this.content,
    this.created_at,
    this.updated_at,
    this.yn,
  });

  ChainInfo.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'] ?? 0;
    name = jsonMap['name'] ?? '';
    symbol = jsonMap['symbol'] ?? '';
    url = jsonMap['url'] ?? '';
    chain = jsonMap['chain'] ?? '';
    total_market_value = jsonMap['total_market_value'] ?? 0;
    ratio = jsonMap['ratio'] ?? 0.0;
    total_supply = jsonMap['total_supply'] ?? 0;
    core_algorithm = jsonMap['core_algorithm'] ?? '';
    core_algorithm_remark = jsonMap['core_algorithm_remark'] ?? '';
    consensus_mechanism = jsonMap['consensus_mechanism'] ?? '';
    consensus_mechanism_remark = jsonMap['consensus_mechanism_remark'] ?? '';
    start_date = jsonMap['start_date'] ?? '';
    content = jsonMap['content'] ?? '';
    created_at = jsonMap['created_at'];
    updated_at = jsonMap['updated_at'];
    yn = jsonMap['yn'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonMap = new Map<String, dynamic>();
    jsonMap['id'] = this.id;
    jsonMap['name'] = this.name;
    jsonMap['symbol'] = this.symbol;
    jsonMap['url'] = this.url;
    jsonMap['chain'] = this.chain;
    jsonMap['total_market_value'] = this.total_market_value;
    jsonMap['ratio'] = this.ratio;
    jsonMap['total_supply'] = this.total_supply;
    jsonMap['core_algorithm'] = this.core_algorithm;
    jsonMap['core_algorithm_remark'] = this.core_algorithm_remark;
    jsonMap['consensus_mechanism'] = this.consensus_mechanism;
    jsonMap['consensus_mechanism_remark'] = this.consensus_mechanism_remark;
    jsonMap['start_date'] = this.start_date;
    jsonMap['content'] = this.content;
    jsonMap['created_at'] = this.created_at;
    jsonMap['updated_at'] = this.updated_at;
    jsonMap['yn'] = this.yn;

    return jsonMap;
  }

  static List<ChainInfo> fromJsonList(List<dynamic> mapList) {
    List<ChainInfo> items = [];

    if (ObjectUtil.isEmptyList(mapList)) {
      return items;
    }

    for(Map<String, dynamic> map in mapList) {
      items.add(ChainInfo.fromJson(map));
    }
    return items;
  }
}
