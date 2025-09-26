import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  /// Main Poppins text style with customizable parameters
  static TextStyle poppins({
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w400,
    Color color = Colors.white,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  /// Oxygen text style for descriptions
  static TextStyle oxygen({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
    Color color = Colors.white,
  }) {
    return GoogleFonts.oxygen(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }
}
