import 'dart:convert';

import 'package:lighthouse_admin/ui/common/widget/treemenu/tree_data.dart';

class MenuData extends TreeData {
  String id;
  String parentId;
  bool checked;
  String name;
  String url;

  MenuData({
    this.id,
    this.parentId,
    this.checked,
    this.name,
    this.url,
  }) : super(id, parentId);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'parentId': parentId,
      'checked': checked,
      'name': name,
      'url': url,
    };
  }

  factory MenuData.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return MenuData(
      id: map['id'],
      parentId: map['parentId'],
      checked: map['checked'],
      name: map['name'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MenuData.fromJson(String source) => MenuData.fromMap(json.decode(source));
}
