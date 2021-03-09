
import 'package:lighthouse_admin/utils/object_util.dart';

class Tag {

  int id;
  String name;
  String remark;
  String created_at;
  String updated_at;
  int yn;

  Tag({
    this.id,
    this.name,
    this.remark,
    this.created_at,
    this.updated_at,
    this.yn,
  });

  Tag.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'] ?? 0;
    name = jsonMap['name'] ?? '';
    remark = jsonMap['remark'] ?? '';
    created_at = jsonMap['created_at'];
    updated_at = jsonMap['updated_at'];
    yn = jsonMap['yn'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonMap = new Map<String, dynamic>();
    jsonMap['id'] = this.id;
    jsonMap['name'] = this.name;
    jsonMap['remark'] = this.remark;
    jsonMap['created_at'] = this.created_at;
    jsonMap['updated_at'] = this.updated_at;
    jsonMap['yn'] = this.yn;

    return jsonMap;
  }

  static List<Tag> fromJsonList(List<dynamic> mapList) {
    List<Tag> items = [];

    if (ObjectUtil.isEmptyList(mapList)) {
      return items;
    }

    for(Map<String, dynamic> map in mapList) {
      items.add(Tag.fromJson(map));
    }
    return items;
  }
}
