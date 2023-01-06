import 'package:flutter/material.dart';

class AppOutlinedButtonTheme {
  AppOutlinedButtonTheme._();

  static final lightOutinedButtonTheme = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
    shape: const RoundedRectangleBorder(),
    primary: Colors.black87,
    side: BorderSide(color: Colors.black87),
    padding: EdgeInsets.symmetric(vertical: 15),
  ));
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
    shape: const RoundedRectangleBorder(),
    primary: Colors.white,
    side: BorderSide(color: Colors.white),
    padding: EdgeInsets.symmetric(vertical: 15),
  ));
}
