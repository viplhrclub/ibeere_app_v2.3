import 'package:flutter/material.dart';

/// New Ibeere 2.0 Design System Colors
/// Bridging the new Material Design 3 colors with existing theme structure
class IbeereDesignColors {
  // Primary Colors
  static const Color primary = Color(0xFF007AFF); // iOS Blue
  static const Color secondary = Color(0xFF5AC8FA); // Cyan
  static const Color accent = Color(0xFFFF2D55); // Pink/Red
  
  // Status Colors
  static const Color success = Color(0xFF34C759); // Green
  static const Color warning = Color(0xFFFF9500); // Orange
  static const Color error = Color(0xFFFF3B30); // Red
  static const Color info = Color(0xFF00C7FD); // Cyan
  
  // Neutral Colors
  static const Color neutral = Color(0xFF8E8E93);
  static const Color neutralLight = Color(0xFFF2F2F7);
  static const Color neutralMedium = Color(0xFFE5E5EA);
  static const Color neutralDark = Color(0xFF3C3C43);
  
  // Grays
  static const Color gray100 = Color(0xFFF9FAFB);
  static const Color gray200 = Color(0xFFF3F4F6);
  static const Color gray300 = Color(0xFFE5E7EB);
  static const Color gray400 = Color(0xFFD1D5DB);
  static const Color gray500 = Color(0xFF9CA3AF);
  static const Color gray600 = Color(0xFF6B7280);
  static const Color gray700 = Color(0xFF4B5563);
  static const Color gray800 = Color(0xFF1F2937);
  static const Color gray900 = Color(0xFF111827);
  
  // Backgrounds & Surfaces
  static const Color background = Color(0xFFF2F2F7);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF9FAFB);
  
  // Semantic Colors
  static const Color online = Color(0xFF34C759);
  static const Color offline = Color(0xFF8E8E93);
  static const Color pending = Color(0xFFFF9500);
}

/// New Ibeere 2.0 Typography System
class IbeereTypography {
  static const String fontFamily = 'Roboto';
  
  // Font Sizes
  static const double xs = 12;
  static const double sm = 14;
  static const double base = 16;
  static const double lg = 18;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;
  
  // Font Weights
  static const FontWeight light = FontWeight.w300;
  static const FontWeight normal = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semibold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extrabold = FontWeight.w800;
}

/// Spacing System
class IbeereSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;
}

/// Shadow System
class IbeererShadows {
  static const BoxShadow sm = BoxShadow(
    color: Color(0x14000000),
    blurRadius: 2,
    offset: Offset(0, 1),
  );
  
  static const BoxShadow md = BoxShadow(
    color: Color(0x1A000000),
    blurRadius: 4,
    offset: Offset(0, 2),
  );
  
  static const BoxShadow lg = BoxShadow(
    color: Color(0x24000000),
    blurRadius: 8,
    offset: Offset(0, 4),
  );
  
  static const BoxShadow xl = BoxShadow(
    color: Color(0x33000000),
    blurRadius: 16,
    offset: Offset(0, 8),
  );
  
  static const BoxShadow xxl = BoxShadow(
    color: Color(0x42000000),
    blurRadius: 24,
    offset: Offset(0, 12),
  );
}

