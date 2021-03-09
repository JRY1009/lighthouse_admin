// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `灯塔后台管理系统`
  String get appName {
    return Intl.message(
      '灯塔后台管理系统',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Page not found`
  String get notFoundPage {
    return Intl.message(
      'Page not found',
      name: 'notFoundPage',
      desc: '',
      args: [],
    );
  }

  /// `登录`
  String get login {
    return Intl.message(
      '登录',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `欢迎登录`
  String get welcomeLogin {
    return Intl.message(
      '欢迎登录',
      name: 'welcomeLogin',
      desc: '',
      args: [],
    );
  }

  /// `密码登录`
  String get pwdLogin {
    return Intl.message(
      '密码登录',
      name: 'pwdLogin',
      desc: '',
      args: [],
    );
  }

  /// `请输入账户密码`
  String get pwdLoginTips {
    return Intl.message(
      '请输入账户密码',
      name: 'pwdLoginTips',
      desc: '',
      args: [],
    );
  }

  /// `欢迎注册`
  String get welcomeRegist {
    return Intl.message(
      '欢迎注册',
      name: 'welcomeRegist',
      desc: '',
      args: [],
    );
  }

  /// `退出登录`
  String get logout {
    return Intl.message(
      '退出登录',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `确定要退出当前账号吗？`
  String get logoutConfirm {
    return Intl.message(
      '确定要退出当前账号吗？',
      name: 'logoutConfirm',
      desc: '',
      args: [],
    );
  }

  /// `账号`
  String get loginAccount {
    return Intl.message(
      '账号',
      name: 'loginAccount',
      desc: '',
      args: [],
    );
  }

  /// `请输入账号`
  String get loginAccountHint {
    return Intl.message(
      '请输入账号',
      name: 'loginAccountHint',
      desc: '',
      args: [],
    );
  }

  /// `账号不能为空!`
  String get loginAccountError {
    return Intl.message(
      '账号不能为空!',
      name: 'loginAccountError',
      desc: '',
      args: [],
    );
  }

  /// `密码`
  String get password {
    return Intl.message(
      '密码',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `请输入密码`
  String get passwordHint {
    return Intl.message(
      '请输入密码',
      name: 'passwordHint',
      desc: '',
      args: [],
    );
  }

  /// `密码不能为空!`
  String get passwordError {
    return Intl.message(
      '密码不能为空!',
      name: 'passwordError',
      desc: '',
      args: [],
    );
  }

  /// `验证码`
  String get verifyCode {
    return Intl.message(
      '验证码',
      name: 'verifyCode',
      desc: '',
      args: [],
    );
  }

  /// `获取验证码`
  String get getVerifyCode {
    return Intl.message(
      '获取验证码',
      name: 'getVerifyCode',
      desc: '',
      args: [],
    );
  }

  /// `请输入验证码`
  String get verifyCodeHint {
    return Intl.message(
      '请输入验证码',
      name: 'verifyCodeHint',
      desc: '',
      args: [],
    );
  }

  /// `秒后重发`
  String get verifyRetry {
    return Intl.message(
      '秒后重发',
      name: 'verifyRetry',
      desc: '',
      args: [],
    );
  }

  /// `已发送验证码`
  String get verifySended {
    return Intl.message(
      '已发送验证码',
      name: 'verifySended',
      desc: '',
      args: [],
    );
  }

  /// `没有账号？`
  String get noAccount {
    return Intl.message(
      '没有账号？',
      name: 'noAccount',
      desc: '',
      args: [],
    );
  }

  /// `点此注册`
  String get clickRegister {
    return Intl.message(
      '点此注册',
      name: 'clickRegister',
      desc: '',
      args: [],
    );
  }

  /// `搜索`
  String get search {
    return Intl.message(
      '搜索',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `关闭`
  String get close {
    return Intl.message(
      '关闭',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `加载中...`
  String get loading {
    return Intl.message(
      '加载中...',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `登录中...`
  String get logingin {
    return Intl.message(
      '登录中...',
      name: 'logingin',
      desc: '',
      args: [],
    );
  }

  /// `首页`
  String get home {
    return Intl.message(
      '首页',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `菜单`
  String get menu {
    return Intl.message(
      '菜单',
      name: 'menu',
      desc: '',
      args: [],
    );
  }

  /// `设置`
  String get setting {
    return Intl.message(
      '设置',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `我的`
  String get mine {
    return Intl.message(
      '我的',
      name: 'mine',
      desc: '',
      args: [],
    );
  }

  /// `账号`
  String get menuAccount {
    return Intl.message(
      '账号',
      name: 'menuAccount',
      desc: '',
      args: [],
    );
  }

  /// `链信息`
  String get menuChain {
    return Intl.message(
      '链信息',
      name: 'menuChain',
      desc: '',
      args: [],
    );
  }

  /// `交易所`
  String get menuExchange {
    return Intl.message(
      '交易所',
      name: 'menuExchange',
      desc: '',
      args: [],
    );
  }

  /// `友情链接`
  String get menuFriends {
    return Intl.message(
      '友情链接',
      name: 'menuFriends',
      desc: '',
      args: [],
    );
  }

  /// `里程碑`
  String get menuMileStone {
    return Intl.message(
      '里程碑',
      name: 'menuMileStone',
      desc: '',
      args: [],
    );
  }

  /// `行情`
  String get menuQuote {
    return Intl.message(
      '行情',
      name: 'menuQuote',
      desc: '',
      args: [],
    );
  }

  /// `全球行情`
  String get menuQuoteGlobal {
    return Intl.message(
      '全球行情',
      name: 'menuQuoteGlobal',
      desc: '',
      args: [],
    );
  }

  /// `热力图`
  String get menuQuoteTreemap {
    return Intl.message(
      '热力图',
      name: 'menuQuoteTreemap',
      desc: '',
      args: [],
    );
  }

  /// `短信`
  String get menuSms {
    return Intl.message(
      '短信',
      name: 'menuSms',
      desc: '',
      args: [],
    );
  }

  /// `标签`
  String get menuTag {
    return Intl.message(
      '标签',
      name: 'menuTag',
      desc: '',
      args: [],
    );
  }

  /// `必填`
  String get tableRequried {
    return Intl.message(
      '必填',
      name: 'tableRequried',
      desc: '',
      args: [],
    );
  }

  /// `Id`
  String get tableId {
    return Intl.message(
      'Id',
      name: 'tableId',
      desc: '',
      args: [],
    );
  }

  /// `名称`
  String get tableName {
    return Intl.message(
      '名称',
      name: 'tableName',
      desc: '',
      args: [],
    );
  }

  /// `类型`
  String get tableCategory {
    return Intl.message(
      '类型',
      name: 'tableCategory',
      desc: '',
      args: [],
    );
  }

  /// `Url地址`
  String get tableUrl {
    return Intl.message(
      'Url地址',
      name: 'tableUrl',
      desc: '',
      args: [],
    );
  }

  /// `创建时间`
  String get tableCreateAt {
    return Intl.message(
      '创建时间',
      name: 'tableCreateAt',
      desc: '',
      args: [],
    );
  }

  /// `修改时间`
  String get tableUpdateAt {
    return Intl.message(
      '修改时间',
      name: 'tableUpdateAt',
      desc: '',
      args: [],
    );
  }

  /// `操作`
  String get tableOperate {
    return Intl.message(
      '操作',
      name: 'tableOperate',
      desc: '',
      args: [],
    );
  }

  /// `状态`
  String get tableYn {
    return Intl.message(
      '状态',
      name: 'tableYn',
      desc: '',
      args: [],
    );
  }

  /// `已开启`
  String get tableYes {
    return Intl.message(
      '已开启',
      name: 'tableYes',
      desc: '',
      args: [],
    );
  }

  /// `已关闭`
  String get tableNo {
    return Intl.message(
      '已关闭',
      name: 'tableNo',
      desc: '',
      args: [],
    );
  }

  /// `取消`
  String get cancel {
    return Intl.message(
      '取消',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `保存`
  String get save {
    return Intl.message(
      '保存',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `保存成功`
  String get saved {
    return Intl.message(
      '保存成功',
      name: 'saved',
      desc: '',
      args: [],
    );
  }

  /// `刷新`
  String get refresh {
    return Intl.message(
      '刷新',
      name: 'refresh',
      desc: '',
      args: [],
    );
  }

  /// `查询`
  String get query {
    return Intl.message(
      '查询',
      name: 'query',
      desc: '',
      args: [],
    );
  }

  /// `重置`
  String get reset {
    return Intl.message(
      '重置',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `增加`
  String get add {
    return Intl.message(
      '增加',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `修改`
  String get edit {
    return Intl.message(
      '修改',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `修改`
  String get modify {
    return Intl.message(
      '修改',
      name: 'modify',
      desc: '',
      args: [],
    );
  }

  /// `修改成功`
  String get modified {
    return Intl.message(
      '修改成功',
      name: 'modified',
      desc: '',
      args: [],
    );
  }

  /// `删除`
  String get delete {
    return Intl.message(
      '删除',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `确定删除`
  String get confirmDelete {
    return Intl.message(
      '确定删除',
      name: 'confirmDelete',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}