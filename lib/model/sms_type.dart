
import 'package:lighthouse_admin/utils/object_util.dart';

class SmsType {

  int value;
  String desc;

  SmsType({
    this.value,
    this.desc,
  });

  SmsType.fromJson(Map<String, dynamic> jsonMap) {
    value = jsonMap['value'] ?? 0;
    desc = jsonMap['desc'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonMap = new Map<String, dynamic>();
    jsonMap['value'] = this.value;
    jsonMap['desc'] = this.desc;

    return jsonMap;
  }

  static List<SmsType> fromJsonList(List<dynamic> mapList) {
    List<SmsType> items = [];

    if (ObjectUtil.isEmptyList(mapList)) {
      return items;
    }

    for(Map<String, dynamic> map in mapList) {
      items.add(SmsType.fromJson(map));
    }
    return items;
  }
}
