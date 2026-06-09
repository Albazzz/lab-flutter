import 'package:flutter/material.dart';

class AppleDesign {
  static const Color primary = Color(0xFF0066CC);
  static const Color ink = Color(0xFF1D1D1F);
  static const Color canvas = Color(0xFFFFFFFF);
  static const Color canvasParchment = Color(0xFFF5F5F7);
  static const Color hairline = Color(0xFFE0E0E0);
  static const Color bodyMuted = Color(0xFF7A7A7A);
  
  static const TextStyle heroDisplay = TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 56,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.28,
    color: ink,
    height: 1.07,
  );

  static const TextStyle displayLg = TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 40,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    color: ink,
    height: 1.1,
  );

  static const TextStyle body = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 17,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.374,
    color: ink,
    height: 1.47,
  );

  static const TextStyle bodyStrong = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 17,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.374,
    color: ink,
    height: 1.24,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.224,
    color: ink,
    height: 1.43,
  );

  static const double spacingSm = 12.0;
  static const double spacingMd = 17.0;
  static const double spacingLg = 24.0;
  static const double spacingXl = 32.0;
  static const double spacingSection = 80.0;

  static const double roundedSm = 8.0;
  static const double roundedLg = 18.0;
  static const double roundedPill = 9999.0;
}
