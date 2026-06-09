import 'package:flutter/material.dart';

class AppleColors {
  static const Color primary = Color(0xFF0066CC);
  static const Color primaryFocus = Color(0xFF0071E3);
  static const Color ink = Color(0xFF1D1D1F);
  static const Color body = Color(0xFF1D1D1F);
  static const Color bodyMuted = Color(0xFFCCCCCC);
  static const Color canvas = Color(0xFFFFFFFF);
  static const Color canvasParchment = Color(0xFFF5F5F7);
  static const Color dividerSoft = Color(0xFFF0F0F0);
  static const Color hairline = Color(0xFFE0E0E0);
  static const Color onPrimary = Color(0xFFFFFFFF);
}

class AppleSpacing {
  static const double xxs = 4.0;
  static const double xs = 8.0;
  static const double sm = 12.0;
  static const double md = 17.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  static const double section = 80.0;
}

class AppleRadius {
  static const double xs = 5.0;
  static const double sm = 8.0;
  static const double md = 11.0;
  static const double lg = 18.0;
  static const BorderRadius pill = BorderRadius.all(Radius.circular(9999.0));
}

class AppleTypography {
  static const TextStyle heroDisplay = TextStyle(
    color: AppleColors.ink,
    fontSize: 56,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.28,
    height: 1.07,
  );

  static const TextStyle displayLg = TextStyle(
    color: AppleColors.ink,
    fontSize: 40,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.1,
  );

  static const TextStyle tagline = TextStyle(
    color: AppleColors.ink,
    fontSize: 21,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.231,
    height: 1.19,
  );

  static const TextStyle bodyStrong = TextStyle(
    color: AppleColors.ink,
    fontSize: 17,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.374,
    height: 1.24,
  );

  static const TextStyle body = TextStyle(
    color: AppleColors.ink,
    fontSize: 17,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.374,
    height: 1.47,
  );

  static const TextStyle caption = TextStyle(
    color: AppleColors.ink,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.224,
    height: 1.43,
  );

  static const TextStyle captionStrong = TextStyle(
    color: AppleColors.ink,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.224,
    height: 1.29,
  );
}
