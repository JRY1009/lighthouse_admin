
import 'package:lighthouse_admin/utils/object_util.dart';

class Exchange {

  int id;
  String name;
  String ico;
  String url;
  String remark;
  String created_at;
  String updated_at;
  int yn;


  Exchange({
    this.id,
    this.ico,
    this.name,
    this.url,
    this.remark,
    this.created_at,
    this.updated_at,
    this.yn,
  });

  Exchange.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'] ?? 0;
    ico = jsonMap['ico'] ?? '';
    name = jsonMap['name'] ?? '';
    url = jsonMap['url'] ?? '';
    remark = jsonMap['remark'] ?? '';
    created_at = jsonMap['created_at'];
    updated_at = jsonMap['updated_at'];
    yn = jsonMap['yn'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonMap = new Map<String, dynamic>();
    jsonMap['id'] = this.id;
    jsonMap['ico'] = this.ico;
    jsonMap['name'] = this.name;
    jsonMap['url'] = this.url;
    jsonMap['remark'] = this.remark;
    jsonMap['created_at'] = this.created_at;
    jsonMap['updated_at'] = this.updated_at;
    jsonMap['yn'] = this.yn;

    return jsonMap;
  }

  static List<Exchange> fromJsonList(List<dynamic> mapList) {
    List<Exchange> items = [];

    if (ObjectUtil.isEmptyList(mapList)) {
      return items;
    }

    for(Map<String, dynamic> map in mapList) {
      items.add(Exchange.fromJson(map));
    }
    return items;
  }
}
