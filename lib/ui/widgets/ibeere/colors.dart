// lib/ui/widgets/ibeere/colors.dart
// Ibeere 2.0 Design System - Color Palette

import 'package:flutter/material.dart';

/// Centralized color palette for Ibeere 2.0 design system
class IbeereColors {
  // Private constructor to prevent instantiation
  IbeereColors._();

  // ============ Primary Colors ============
  static const Color primary = Color(0xFF007AFF);      // iOS Blue
  static const Color primaryLight = Color(0xFF00B4FF); // Light Blue
  static const Color primaryDark = Color(0xFF0051BA);  // Dark Blue

  // ============ Secondary Colors ============
  static const Color secondary = Color(0xFF5AC8FA);    // Cyan
  static const Color secondaryLight = Color(0xFF8FE1FF);
  static const Color secondaryDark = Color(0xFF0099CC);

  // ============ Accent Colors ============
  static const Color accent = Color(0xFFFF2D55);       // Pink/Red
  static const Color accentLight = Color(0xFFFF6B7A);
  static const Color accentDark = Color(0xFFCC1F44);

  // ============ Semantic Colors ============
  static const Color success = Color(0xFF34C759);
  static const Color warning = Color(0xFFFF9500);
  static const Color error = Color(0xFFFF3B30);
  static const Color info = Color(0xFF00C7FD);

  // ============ Neutral Colors (Grayscale) ============
  static const Color white = Color(0xFFFFFFFF);
  static const Color gray50 = Color(0xFFF9FAFB);
  static const Color gray100 = Color(0xFFF3F4F6);
  static const Color gray200 = Color(0xFFE5E7EB);
  static const Color gray300 = Color(0xFFD1D5DB);
  static const Color gray400 = Color(0xFF9CA3AF);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray600 = Color(0xFF4B5563);
  static const Color gray700 = Color(0xFF374151);
  static const Color gray800 = Color(0xFF1F2937);
  static const Color gray900 = Color(0xFF111827);
  static const Color black = Color(0xFF000000);

  // ============ Surface & Background ============
  static const Color surface = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF2F2F7);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color divider = Color(0xFFE5E7EB);

  // ============ State Colors ============
  static const Color disabled = Color(0xFFCBCBD1);
  static const Color overlay = Color(0x00000033); // 20% opacity black
  static const Color shadowColor = Color(0x1A000000);

  /// Get semi-transparent version of a color
  static Color withOpacity(Color color, double opacity) {
    return color.withValues(alpha: opacity);
  }
}

