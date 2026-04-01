import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: Colors.white, // Cyan accent
    scaffoldBackgroundColor: const Color(0xFF0A2540), // Deep Navy
    cardColor: const Color(0xFF132F4A),
    textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
  );

  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: const Color(0xFF132F4A),
    scaffoldBackgroundColor: const Color(0xFFF8FAFC),
    cardColor: Colors.white,
    textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme),
  );
}
