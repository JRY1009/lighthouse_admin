
import 'package:lighthouse_admin/utils/object_util.dart';

class SmsQuery {

  int id;
  String content;
  String phone;
  String template;
  String response;
  String remark;
  String created_at;
  String updated_at;
  bool success;


  SmsQuery({
    this.id,
    this.content,
    this.phone,
    this.template,
    this.response,
    this.remark,
    this.created_at,
    this.updated_at,
    this.success,
  });

  SmsQuery.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'] ?? 0;
    content = jsonMap['content'] ?? '';
    phone = jsonMap['phone'] ?? '';
    template = jsonMap['template'] ?? '';
    response = jsonMap['response'] ?? '';
    remark = jsonMap['remark'] ?? '';
    created_at = jsonMap['created_at'];
    updated_at = jsonMap['updated_at'];
    success = jsonMap['success'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonMap = new Map<String, dynamic>();
    jsonMap['id'] = this.id;
    jsonMap['content'] = this.content;
    jsonMap['phone'] = this.phone;
    jsonMap['template'] = this.template;
    jsonMap['response'] = this.response;
    jsonMap['remark'] = this.remark;
    jsonMap['created_at'] = this.created_at;
    jsonMap['updated_at'] = this.updated_at;
    jsonMap['success'] = this.success;

    return jsonMap;
  }

  static List<SmsQuery> fromJsonList(List<dynamic> mapList) {
    List<SmsQuery> items = [];

    if (ObjectUtil.isEmptyList(mapList)) {
      return items;
    }

    for(Map<String, dynamic> map in mapList) {
      items.add(SmsQuery.fromJson(map));
    }
    return items;
  }
}
