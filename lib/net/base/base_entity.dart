
import 'package:lighthouse_admin/net/apis.dart';
import 'package:lighthouse_admin/net/base/entry_factory.dart';
import 'package:lighthouse_admin/utils/object_util.dart';

class BaseEntity<T> {

  String errno;
  String msg;
  T data;

  BaseEntity({this.errno, this.msg, this.data});

  BaseEntity.fromJson(Map<String, dynamic> jsonMap) {
    errno = jsonMap[Apis.ERRNO] as String;
    msg = jsonMap[Apis.MESSAGE] as String;

    if (jsonMap.containsKey('data') && !ObjectUtil.isEmpty(jsonMap['data'])) {
      data = EntityFactory.generateOBJ<T>(jsonMap['data']);
    }
  }

}