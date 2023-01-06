import 'package:flutter/material.dart';

class AppElevatedButtonTheme {
  AppElevatedButtonTheme._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      shape: const RoundedRectangleBorder(),
      primary: Colors.black87,
      onPrimary: Colors.white,
      side: const BorderSide(color: Colors.black87),
      padding: const EdgeInsets.symmetric(vertical: 15),
    ),
  );
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      shape: const RoundedRectangleBorder(),
      primary: Colors.white,
      onPrimary: Colors.black,
      side: BorderSide(color: Colors.white),
      padding: EdgeInsets.symmetric(vertical: 15),
    ),
  );
}
