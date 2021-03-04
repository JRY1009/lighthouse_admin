// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_CN locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh_CN';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "getVerifyCode" : MessageLookupByLibrary.simpleMessage("获取验证码"),
    "login" : MessageLookupByLibrary.simpleMessage("登录"),
    "loginAccount" : MessageLookupByLibrary.simpleMessage("账号"),
    "loginAccountError" : MessageLookupByLibrary.simpleMessage("账号不能为空!"),
    "loginAccountHint" : MessageLookupByLibrary.simpleMessage("请输入账号"),
    "logout" : MessageLookupByLibrary.simpleMessage("退出登录"),
    "logoutConfirm" : MessageLookupByLibrary.simpleMessage("确定要退出当前账号吗？"),
    "notFoundPage" : MessageLookupByLibrary.simpleMessage("页面不存在"),
    "password" : MessageLookupByLibrary.simpleMessage("密码"),
    "passwordError" : MessageLookupByLibrary.simpleMessage("密码不能为空!"),
    "passwordHint" : MessageLookupByLibrary.simpleMessage("请输入密码"),
    "pwdLogin" : MessageLookupByLibrary.simpleMessage("密码登录"),
    "pwdLoginTips" : MessageLookupByLibrary.simpleMessage("请输入账户密码"),
    "search" : MessageLookupByLibrary.simpleMessage("搜索"),
    "verifyCode" : MessageLookupByLibrary.simpleMessage("验证码"),
    "verifyCodeHint" : MessageLookupByLibrary.simpleMessage("请输入验证码"),
    "verifyRetry" : MessageLookupByLibrary.simpleMessage("秒后重发"),
    "verifySended" : MessageLookupByLibrary.simpleMessage("已发送验证码"),
    "welcomeLogin" : MessageLookupByLibrary.simpleMessage("欢迎登录"),
    "welcomeRegist" : MessageLookupByLibrary.simpleMessage("欢迎注册")
  };
}
