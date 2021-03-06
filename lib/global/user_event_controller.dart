import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lighthouse_admin/model/account.dart';

enum UserEventState {
  login,
  logout,
  userme,
}

class UserEventController extends GetxController {

  Account account;
  UserEventState state;

  fireUserEvent(Account account, UserEventState state) {
    this.account = account;
    this.state = state;
    update();
  }
}
