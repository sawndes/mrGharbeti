import 'package:flutter/material.dart';

class TextFormFieldTheme {
  TextFormFieldTheme._();
  static InputDecorationTheme lightInputDecorationTheme =
      const InputDecorationTheme(
    // label: Text('Full Name'),
    // prefixIcon: Icon(
    //   Icons.person_outline_rounded,
    //   color: Color(0xFF272727),
    // ),
    prefixIconColor: Color(0xFF272727),
    border: OutlineInputBorder(),
    labelStyle: TextStyle(
      color: Color(0xFF272727),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 2.0,
        color: Color(0xFF272727),
      ),
    ),
  );
  static InputDecorationTheme darkInputDecorationTheme =
      const InputDecorationTheme(
    // label: Text('Full Name'),
    // prefixIcon: Icon(
    //   Icons.person_outline_rounded,
    //   color: Color(0xFF272727),
    // ),
    prefixIconColor: Color(0xFFFFE400),
    border: OutlineInputBorder(),
    labelStyle: TextStyle(
      color: Color(0xFFFFE400),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 2.0,
        color: Color(0xFFFFE400),
      ),
    ),
  );
}
