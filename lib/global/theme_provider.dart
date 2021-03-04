
import 'dart:ui';

import 'package:flutter/material.dart';

class ThemeProvider {

  static getThemeData(Color themeColor) {
    return ThemeData(
      primaryColor: themeColor,
      iconTheme: IconThemeData(color: themeColor),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: themeColor,
      ),
      buttonTheme: ButtonThemeData(buttonColor: themeColor),
    );
  }
}