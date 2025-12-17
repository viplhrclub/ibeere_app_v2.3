import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/app_theme.dart';

/// Design Tokens for Ibeere 2.0 UI
/// 
/// This file provides easy access to all design system values
/// including colors, typography, spacing, and other dimensions.
class DesignTokens {
  DesignTokens._(); // Private constructor to prevent instantiation

  // ============ COLORS ============
  static Color get primary => IbeereColors.primary;
  static Color get secondary => IbeereColors.secondary;
  static Color get accent => IbeereColors.accent;
  static Color get success => IbeereColors.success;
  static Color get error => IbeereColors.error;
  static Color get warning => IbeereColors.warning;
  static Color get info => IbeereColors.info;
  static Color get background => IbeereColors.background;
  static Color get surface => IbeereColors.surface;
  static Color get neutral => const Color(0xFF808080);

  // ============ TYPOGRAPHY ============
  static const double fontSizeXs = IbeereTypography.xs;
  static const double fontSizeSm = IbeereTypography.sm;
  static const double fontSizeBase = IbeereTypography.base;
  static const double fontSizeLg = IbeereTypography.lg;
  static const double fontSizeXl = IbeereTypography.xl;
  static const double fontSizeXxl = IbeereTypography.xxl;
  static const double fontSizeXxxl = IbeereTypography.xxxl;
  static const double fontSizeXxxxl = 48; // Extra large font for special cases

  static const FontWeight fontWeightLight = IbeereTypography.light;
  static const FontWeight fontWeightNormal = IbeereTypography.normal;
  static const FontWeight fontWeightRegular = IbeereTypography.normal;
  static const FontWeight fontWeightMedium = IbeereTypography.medium;
  static const FontWeight fontWeightSemibold = IbeereTypography.semibold;
  static const FontWeight fontWeightBold = IbeereTypography.bold;

  // ============ LINE HEIGHT ============
  static const double lineHeightRelaxed = 1.5;

  // ============ SPACING ============
  static const double spaceXs = IbeereSpacing.xs;
  static const double spaceSm = IbeereSpacing.sm;
  static const double spaceMd = IbeereSpacing.md;
  static const double spaceLg = IbeereSpacing.lg;
  static const double spaceXl = IbeereSpacing.xl;
  static const double spaceXxl = IbeereSpacing.xxl;
  static const double spaceXxxl = IbeereSpacing.xxxl;

  // ============ BORDER RADIUS ============
  static const double radiusXs = IbeereBorderRadius.xs;
  static const double radiusSm = IbeereBorderRadius.sm;
  static const double radiusMd = IbeereBorderRadius.md;
  static const double radiusLg = IbeereBorderRadius.lg;
  static const double radiusXl = IbeereBorderRadius.xl;
  static const double radiusXxl = IbeereBorderRadius.xxl;
  static const double radiusFull = IbeereBorderRadius.full;

  // ============ SHADOWS ============
  static const BoxShadow shadowSm = IbeereShadows.sm;
  static const BoxShadow shadowMd = IbeereShadows.md;
  static const BoxShadow shadowLg = IbeereShadows.lg;
  static const BoxShadow shadowXl = IbeereShadows.xl;
  static const BoxShadow shadowXxl = IbeereShadows.xxl;

  // ============ COMMON DIMENSIONS ============
  static const double buttonHeight = 48;
  static const double buttonHeightSmall = 40;
  static const double buttonHeightLarge = 56;
  
  static const double iconSizeSmall = 16;
  static const double iconSizeMedium = 24;
  static const double iconSizeLarge = 32;
  static const double iconSizeXl = 48;

  static const double appBarHeight = 56;
  static const double bottomNavHeight = 56;
  
  // ============ COMMON PADDINGS ============
  static const EdgeInsets paddingXs = EdgeInsets.all(4);
  static const EdgeInsets paddingSm = EdgeInsets.all(8);
  static const EdgeInsets paddingMd = EdgeInsets.all(12);
  static const EdgeInsets paddingLg = EdgeInsets.all(16);
  static const EdgeInsets paddingXl = EdgeInsets.all(24);

  static const EdgeInsets paddingHorizontalSm = EdgeInsets.symmetric(horizontal: 8);
  static const EdgeInsets paddingHorizontalMd = EdgeInsets.symmetric(horizontal: 12);
  static const EdgeInsets paddingHorizontalLg = EdgeInsets.symmetric(horizontal: 16);
  static const EdgeInsets paddingHorizontalXl = EdgeInsets.symmetric(horizontal: 24);

  static const EdgeInsets paddingVerticalSm = EdgeInsets.symmetric(vertical: 8);
  static const EdgeInsets paddingVerticalMd = EdgeInsets.symmetric(vertical: 12);
  static const EdgeInsets paddingVerticalLg = EdgeInsets.symmetric(vertical: 16);
  static const EdgeInsets paddingVerticalXl = EdgeInsets.symmetric(vertical: 24);
}

