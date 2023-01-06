import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextTheme {
  AppTextTheme._();
  static TextTheme lightTextTheme = TextTheme(
    headline1: GoogleFonts.montserrat(
      fontSize: 28.0,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    headline2: GoogleFonts.montserrat(
      fontSize: 24.0,
      fontWeight: FontWeight.w700,
      color: Colors.black87,
    ),
    headline3: GoogleFonts.poppins(
      fontSize: 24.0,
      fontWeight: FontWeight.w700,
      color: Colors.black87,
    ),
    headline4: GoogleFonts.poppins(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.black87,
    ),
    headline6: GoogleFonts.poppins(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      color: Colors.black87,
    ),
    bodyText1: GoogleFonts.poppins(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: Colors.black87,
    ),
    bodyText2: GoogleFonts.poppins(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: Colors.black87,
    ),
  );
  static TextTheme darkTextTheme = TextTheme(
    headline1: GoogleFonts.montserrat(
      fontSize: 28.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headline2: GoogleFonts.montserrat(
      fontSize: 24.0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    headline3: GoogleFonts.poppins(
      fontSize: 24.0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    headline4: GoogleFonts.poppins(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    headline6: GoogleFonts.poppins(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    bodyText1: GoogleFonts.poppins(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
    bodyText2: GoogleFonts.poppins(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
  );
}
