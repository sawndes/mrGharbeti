import 'package:flutter/material.dart';

import '../themes/outlined_button_theme.dart';
import '../themes/text_form_field_theme.dart';
import './text_theme.dart';
import './elevated_button_theme.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    // primarySwatch: Colors.lightGreen,
    textTheme: AppTextTheme.lightTextTheme,
    outlinedButtonTheme: AppOutlinedButtonTheme.lightOutinedButtonTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme: TextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    // primarySwatch: Colors.lightGreen,
    textTheme: AppTextTheme.darkTextTheme,
    outlinedButtonTheme: AppOutlinedButtonTheme.darkOutlinedButtonTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.darkElevatedButtonTheme,
    inputDecorationTheme: TextFormFieldTheme.darkInputDecorationTheme,
  );
}
