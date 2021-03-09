
import 'package:lighthouse_admin/utils/object_util.dart';

class Friend {

  int id;
  int category;
  String name;
  String url;
  String created_at;
  String updated_at;
  int yn;

  String get category_text => _getCategory();

  String _getCategory() {
    String text = '';
    if (category == 1) {
      text = 'bitcoin';
    } else if (category == 2) {
      text = 'ethereum';
    }
    return text;
  }


  Friend({
    this.id,
    this.category,
    this.name,
    this.url,
    this.created_at,
    this.updated_at,
    this.yn,
  });

  Friend.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'] ?? 0;
    category = jsonMap['category'] ?? 0;
    name = jsonMap['name'] ?? '';
    url = jsonMap['url'] ?? '';
    created_at = jsonMap['created_at'];
    updated_at = jsonMap['updated_at'];
    yn = jsonMap['yn'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonMap = new Map<String, dynamic>();
    jsonMap['id'] = this.id;
    jsonMap['category'] = this.category;
    jsonMap['name'] = this.name;
    jsonMap['url'] = this.url;
    jsonMap['created_at'] = this.created_at;
    jsonMap['updated_at'] = this.updated_at;
    jsonMap['yn'] = this.yn;

    return jsonMap;
  }

  static List<Friend> fromJsonList(List<dynamic> mapList) {
    List<Friend> items = [];

    if (ObjectUtil.isEmptyList(mapList)) {
      return items;
    }

    for(Map<String, dynamic> map in mapList) {
      items.add(Friend.fromJson(map));
    }
    return items;
  }
}
