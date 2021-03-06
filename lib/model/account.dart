import 'package:lighthouse_admin/utils/object_util.dart';

class AccountEntity {

  String token;
  Account admin_info;
  String expire_time;

  AccountEntity({
    this.token,
    this.admin_info,
    this.expire_time,
  });

  AccountEntity.fromJson(Map<String, dynamic> jsonMap) {
    token = jsonMap['token'];
    expire_time = jsonMap['expire_time'];

    if (ObjectUtil.isNotEmpty(jsonMap['admin_info'])) {
      admin_info = Account.fromJson(jsonMap['admin_info']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonMap = new Map<String, dynamic>();
    jsonMap['token'] = this.token;
    jsonMap['expire_time'] = this.expire_time;

    if (this.admin_info != null) {
      jsonMap['admin_info'] = this.admin_info.toJson();
    }

    return jsonMap;
  }
}

class Account {

  //{"id":1,"email":"legend9999@126.com","phone":"13581696593","created_at":"2021-01-09 11:12:41","updated_at":"2021-01-09 11:12:42"}
  int id;
  String email;
  String phone;
  String created_at;
  String updated_at;

  String token;

  Account({
    this.id,
    this.email,
    this.phone,
    this.created_at,
    this.updated_at,
    this.token,
  });

  Account.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    email = jsonMap['email'];
    phone = jsonMap['phone'];
    created_at = jsonMap['created_at'];
    updated_at = jsonMap['updated_at'];
    token = jsonMap['token'];
    //photos = Media.fromJsonList(jsonMap['pic']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonMap = new Map<String, dynamic>();
    jsonMap['id'] = this.id;
    jsonMap['email'] = this.email;
    jsonMap['phone'] = this.phone;
    jsonMap['created_at'] = this.created_at;
    jsonMap['updated_at'] = this.updated_at;
    jsonMap['token'] = this.token;
    //jsonMap['pic'] = this.photos?.map((v) => v.toJson()).toList();

    return jsonMap;
  }


  Account.fromLocalJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    email = jsonMap['email'];
    phone = jsonMap['phone'];
    token = jsonMap['token'];
  }

  Map<String, dynamic> toLocalJson() {
    final Map<String, dynamic> jsonMap = new Map<String, dynamic>();
    jsonMap['id'] = this.id;
    jsonMap['email'] = this.email;
    jsonMap['phone'] = this.phone;
    jsonMap['token'] = this.token;

    return jsonMap;
  }
}
