
import 'package:lighthouse_admin/utils/object_util.dart';

class User {

  int id;
  String email;
  String phone;
  String nick_name;
  String head_ico;
  String password;
  String remark;
  String created_at;
  String updated_at;
  int yn;


  User({
    this.id,
    this.email,
    this.phone,
    this.nick_name,
    this.head_ico,
    this.password,
    this.remark,
    this.created_at,
    this.updated_at,
    this.yn,
  });

  User.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'] ?? 0;
    email = jsonMap['email'] ?? '';
    phone = jsonMap['phone'] ?? '';
    nick_name = jsonMap['nick_name'] ?? '';
    head_ico = jsonMap['head_ico'] ?? '';
    password = jsonMap['password'] ?? '';
    remark = jsonMap['remark'] ?? '';
    created_at = jsonMap['created_at'];
    updated_at = jsonMap['updated_at'];
    yn = jsonMap['yn'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonMap = new Map<String, dynamic>();
    jsonMap['id'] = this.id;
    jsonMap['email'] = this.email;
    jsonMap['phone'] = this.phone;
    jsonMap['nick_name'] = this.nick_name;
    jsonMap['head_ico'] = this.head_ico;
    jsonMap['password'] = this.password;
    jsonMap['remark'] = this.remark;
    jsonMap['created_at'] = this.created_at;
    jsonMap['updated_at'] = this.updated_at;
    jsonMap['yn'] = this.yn;

    return jsonMap;
  }

  static List<User> fromJsonList(List<dynamic> mapList) {
    List<User> items = [];

    if (ObjectUtil.isEmptyList(mapList)) {
      return items;
    }

    for(Map<String, dynamic> map in mapList) {
      items.add(User.fromJson(map));
    }
    return items;
  }
}
