import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts{

  static  TextStyle poppinsTextStyle(
    {required double fontSize,
    required Color fontColor,
    required FontWeight fontWeight}) {
  return GoogleFonts.poppins(
      fontSize: fontSize, color: fontColor, fontWeight: fontWeight);
}
}


