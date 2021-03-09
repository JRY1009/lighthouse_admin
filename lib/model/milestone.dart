
import 'package:lighthouse_admin/utils/object_util.dart';

class Milestone {

  int id;
  String tag;
  String date;
  String content;
  String created_at;
  String updated_at;
  int yn;

  Milestone({
    this.id,
    this.tag,
    this.date,
    this.content,
    this.created_at,
    this.updated_at,
    this.yn,
  });

  Milestone.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'] ?? 0;
    tag = jsonMap['tag'] ?? '';
    date = jsonMap['date'] ?? '';
    content = jsonMap['content'] ?? '';
    created_at = jsonMap['created_at'];
    updated_at = jsonMap['updated_at'];
    yn = jsonMap['yn'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonMap = new Map<String, dynamic>();
    jsonMap['id'] = this.id;
    jsonMap['tag'] = this.tag;
    jsonMap['date'] = this.date;
    jsonMap['content'] = this.content;
    jsonMap['created_at'] = this.created_at;
    jsonMap['updated_at'] = this.updated_at;
    jsonMap['yn'] = this.yn;

    return jsonMap;
  }

  static List<Milestone> fromJsonList(List<dynamic> mapList) {
    List<Milestone> items = [];

    if (ObjectUtil.isEmptyList(mapList)) {
      return items;
    }

    for(Map<String, dynamic> map in mapList) {
      items.add(Milestone.fromJson(map));
    }
    return items;
  }
}
