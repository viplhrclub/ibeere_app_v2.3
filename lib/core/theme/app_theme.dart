import 'package:flutter/material.dart';

class IbeereColors {
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
  static const double xxxxl = 40;
  
  // Font Weights
  static const FontWeight light = FontWeight.w300;
  static const FontWeight normal = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semibold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extrabold = FontWeight.w800;
  
  // Line Heights
  static const double lineHeightTight = 1.2;
  static const double lineHeightNormal = 1.5;
  static const double lineHeightRelaxed = 1.75;
  static const double lineHeightLoose = 2;
}

class IbeereSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;
}

class IbeereBorderRadius {
  static const double none = 0;
  static const double xs = 2;
  static const double sm = 4;
  static const double md = 8;
  static const double lg = 12;
  static const double xl = 16;
  static const double xxl = 24;
  static const double full = 999;
}

class IbeereShadows {
  static const BoxShadow sm = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.05),
    blurRadius: 2,
    offset: Offset(0, 1),
  );
  
  static const BoxShadow md = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.1),
    blurRadius: 6,
    offset: Offset(0, 4),
  );
  
  static const BoxShadow lg = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.1),
    blurRadius: 15,
    offset: Offset(0, 10),
  );
  
  static const BoxShadow xl = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.1),
    blurRadius: 25,
    offset: Offset(0, 20),
  );
  
  static const BoxShadow xxl = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.25),
    blurRadius: 50,
    offset: Offset(0, 25),
  );
}

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: IbeereColors.primary,
        secondary: IbeereColors.secondary,
        tertiary: IbeereColors.accent,
        error: IbeereColors.error,
      ),
      scaffoldBackgroundColor: IbeereColors.background,
      
      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: IbeereColors.surface,
        foregroundColor: IbeereColors.gray900,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: _titleTextStyle(),
      ),
      
      // Text Theme
      textTheme: _buildTextTheme(),
      
      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: IbeereColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            vertical: IbeereSpacing.md,
            horizontal: IbeereSpacing.lg,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(IbeereBorderRadius.md),
          ),
          elevation: 0,
          textStyle: const TextStyle(
            fontSize: IbeereTypography.base,
            fontWeight: IbeereTypography.semibold,
          ),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: IbeereColors.primary,
          padding: const EdgeInsets.symmetric(
            vertical: IbeereSpacing.md,
            horizontal: IbeereSpacing.lg,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(IbeereBorderRadius.md),
          ),
          side: const BorderSide(color: IbeereColors.primary),
          textStyle: const TextStyle(
            fontSize: IbeereTypography.base,
            fontWeight: IbeereTypography.semibold,
          ),
        ),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: IbeereColors.gray100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(IbeereBorderRadius.md),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(IbeereBorderRadius.md),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(IbeereBorderRadius.md),
          borderSide: const BorderSide(color: IbeereColors.primary),
        ),
        contentPadding: const EdgeInsets.all(IbeereSpacing.md),
        hintStyle: const TextStyle(
          color: IbeereColors.gray500,
          fontSize: IbeereTypography.base,
        ),
      ),
      
      // Card Theme
      cardTheme: CardThemeData(
        color: IbeereColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(IbeereBorderRadius.lg),
        ),
        shadowColor: IbeereColors.primary.withValues(alpha: 0.1),
      ),
      
      // Chip Theme
      chipTheme: const ChipThemeData(
        backgroundColor: IbeereColors.gray100,
        selectedColor: IbeereColors.primary,
        labelStyle: TextStyle(
          color: IbeereColors.gray900,
          fontSize: IbeereTypography.sm,
        ),
        brightness: Brightness.light,
      ),
    );
  }

  static TextTheme _buildTextTheme() {
    return const TextTheme(
      displayLarge: TextStyle(
        fontSize: IbeereTypography.xxxxl,
        fontWeight: IbeereTypography.bold,
        height: IbeereTypography.lineHeightTight,
        fontFamily: IbeereTypography.fontFamily,
      ),
      displayMedium: TextStyle(
        fontSize: IbeereTypography.xxxl,
        fontWeight: IbeereTypography.bold,
        height: IbeereTypography.lineHeightTight,
        fontFamily: IbeereTypography.fontFamily,
      ),
      displaySmall: TextStyle(
        fontSize: IbeereTypography.xxl,
        fontWeight: IbeereTypography.bold,
        height: IbeereTypography.lineHeightTight,
        fontFamily: IbeereTypography.fontFamily,
      ),
      headlineLarge: TextStyle(
        fontSize: IbeereTypography.xl,
        fontWeight: IbeereTypography.bold,
        height: IbeereTypography.lineHeightNormal,
        fontFamily: IbeereTypography.fontFamily,
      ),
      headlineMedium: TextStyle(
        fontSize: IbeereTypography.lg,
        fontWeight: IbeereTypography.semibold,
        height: IbeereTypography.lineHeightNormal,
        fontFamily: IbeereTypography.fontFamily,
      ),
      headlineSmall: TextStyle(
        fontSize: IbeereTypography.base,
        fontWeight: IbeereTypography.semibold,
        height: IbeereTypography.lineHeightNormal,
        fontFamily: IbeereTypography.fontFamily,
      ),
      titleLarge: TextStyle(
        fontSize: IbeereTypography.lg,
        fontWeight: IbeereTypography.semibold,
        height: IbeereTypography.lineHeightNormal,
        fontFamily: IbeereTypography.fontFamily,
      ),
      titleMedium: TextStyle(
        fontSize: IbeereTypography.base,
        fontWeight: IbeereTypography.semibold,
        height: IbeereTypography.lineHeightNormal,
        fontFamily: IbeereTypography.fontFamily,
      ),
      titleSmall: TextStyle(
        fontSize: IbeereTypography.sm,
        fontWeight: IbeereTypography.semibold,
        height: IbeereTypography.lineHeightNormal,
        fontFamily: IbeereTypography.fontFamily,
      ),
      bodyLarge: TextStyle(
        fontSize: IbeereTypography.base,
        fontWeight: IbeereTypography.normal,
        height: IbeereTypography.lineHeightNormal,
        fontFamily: IbeereTypography.fontFamily,
      ),
      bodyMedium: TextStyle(
        fontSize: IbeereTypography.sm,
        fontWeight: IbeereTypography.normal,
        height: IbeereTypography.lineHeightNormal,
        fontFamily: IbeereTypography.fontFamily,
      ),
      bodySmall: TextStyle(
        fontSize: IbeereTypography.xs,
        fontWeight: IbeereTypography.normal,
        height: IbeereTypography.lineHeightNormal,
        fontFamily: IbeereTypography.fontFamily,
      ),
      labelLarge: TextStyle(
        fontSize: IbeereTypography.base,
        fontWeight: IbeereTypography.semibold,
        height: IbeereTypography.lineHeightNormal,
        fontFamily: IbeereTypography.fontFamily,
      ),
      labelMedium: TextStyle(
        fontSize: IbeereTypography.sm,
        fontWeight: IbeereTypography.medium,
        height: IbeereTypography.lineHeightNormal,
        fontFamily: IbeereTypography.fontFamily,
      ),
      labelSmall: TextStyle(
        fontSize: IbeereTypography.xs,
        fontWeight: IbeereTypography.medium,
        height: IbeereTypography.lineHeightNormal,
        fontFamily: IbeereTypography.fontFamily,
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: IbeereColors.primary,
        secondary: IbeereColors.secondary,
        tertiary: IbeereColors.accent,
        error: IbeereColors.error,
        surface: Color(0xFF1F1F1F),
      ),
      scaffoldBackgroundColor: const Color(0xFF121212),
      
      // AppBar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1F1F1F),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: IbeereTypography.lg,
          fontWeight: IbeereTypography.semibold,
          color: Colors.white,
          fontFamily: IbeereTypography.fontFamily,
        ),
      ),
      
      // Text Theme
      textTheme: _buildDarkTextTheme(),
      
      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: IbeereColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            vertical: IbeereSpacing.md,
            horizontal: IbeereSpacing.lg,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(IbeereBorderRadius.md),
          ),
          elevation: 0,
          textStyle: const TextStyle(
            fontSize: IbeereTypography.base,
            fontWeight: IbeereTypography.semibold,
          ),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: IbeereColors.primary,
          padding: const EdgeInsets.symmetric(
            vertical: IbeereSpacing.md,
            horizontal: IbeereSpacing.lg,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(IbeereBorderRadius.md),
          ),
          side: const BorderSide(color: IbeereColors.primary),
          textStyle: const TextStyle(
            fontSize: IbeereTypography.base,
            fontWeight: IbeereTypography.semibold,
          ),
        ),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF2A2A2A),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(IbeereBorderRadius.md),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(IbeereBorderRadius.md),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(IbeereBorderRadius.md),
          borderSide: const BorderSide(color: IbeereColors.primary),
        ),
        contentPadding: const EdgeInsets.all(IbeereSpacing.md),
        hintStyle: const TextStyle(
          color: IbeereColors.gray500,
          fontSize: IbeereTypography.base,
        ),
      ),
      
      // Card Theme
      cardTheme: CardThemeData(
        color: const Color(0xFF1F1F1F),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(IbeereBorderRadius.lg),
        ),
        shadowColor: IbeereColors.primary.withValues(alpha: 0.1),
      ),
      
      // Chip Theme
      chipTheme: const ChipThemeData(
        backgroundColor: Color(0xFF2A2A2A),
        selectedColor: IbeereColors.primary,
        labelStyle: TextStyle(
          color: Colors.white,
          fontSize: IbeereTypography.sm,
        ),
        brightness: Brightness.dark,
      ),
    );
  }

  static TextTheme _buildDarkTextTheme() {
    return const TextTheme(
      displayLarge: TextStyle(
        fontSize: IbeereTypography.xxxxl,
        fontWeight: IbeereTypography.bold,
        height: IbeereTypography.lineHeightTight,
        fontFamily: IbeereTypography.fontFamily,
        color: Colors.white,
      ),
      displayMedium: TextStyle(
        fontSize: IbeereTypography.xxxl,
        fontWeight: IbeereTypography.bold,
        height: IbeereTypography.lineHeightTight,
        fontFamily: IbeereTypography.fontFamily,
        color: Colors.white,
      ),
      displaySmall: TextStyle(
        fontSize: IbeereTypography.xxl,
        fontWeight: IbeereTypography.bold,
        height: IbeereTypography.lineHeightTight,
        fontFamily: IbeereTypography.fontFamily,
        color: Colors.white,
      ),
      headlineLarge: TextStyle(
        fontSize: IbeereTypography.xl,
        fontWeight: IbeereTypography.bold,
        height: IbeereTypography.lineHeightNormal,
        fontFamily: IbeereTypography.fontFamily,
        color: Colors.white,
      ),
      headlineMedium: TextStyle(
        fontSize: IbeereTypography.lg,
        fontWeight: IbeereTypography.semibold,
        height: IbeereTypography.lineHeightNormal,
        fontFamily: IbeereTypography.fontFamily,
        color: Colors.white,
      ),
      headlineSmall: TextStyle(
        fontSize: IbeereTypography.base,
        fontWeight: IbeereTypography.semibold,
        height: IbeereTypography.lineHeightNormal,
        fontFamily: IbeereTypography.fontFamily,
        color: Colors.white,
      ),
      titleLarge: TextStyle(
        fontSize: IbeereTypography.lg,
        fontWeight: IbeereTypography.semibold,
        height: IbeereTypography.lineHeightNormal,
        fontFamily: IbeereTypography.fontFamily,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        fontSize: IbeereTypography.base,
        fontWeight: IbeereTypography.semibold,
        height: IbeereTypography.lineHeightNormal,
        fontFamily: IbeereTypography.fontFamily,
        color: Colors.white,
      ),
      titleSmall: TextStyle(
        fontSize: IbeereTypography.sm,
        fontWeight: IbeereTypography.semibold,
        height: IbeereTypography.lineHeightNormal,
        fontFamily: IbeereTypography.fontFamily,
        color: Colors.white,
      ),
      bodyLarge: TextStyle(
        fontSize: IbeereTypography.base,
        fontWeight: IbeereTypography.normal,
        height: IbeereTypography.lineHeightNormal,
        fontFamily: IbeereTypography.fontFamily,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontSize: IbeereTypography.sm,
        fontWeight: IbeereTypography.normal,
        height: IbeereTypography.lineHeightNormal,
        fontFamily: IbeereTypography.fontFamily,
        color: Colors.white,
      ),
      bodySmall: TextStyle(
        fontSize: IbeereTypography.xs,
        fontWeight: IbeereTypography.normal,
        height: IbeereTypography.lineHeightNormal,
        fontFamily: IbeereTypography.fontFamily,
        color: Colors.white,
      ),
      labelLarge: TextStyle(
        fontSize: IbeereTypography.base,
        fontWeight: IbeereTypography.semibold,
        height: IbeereTypography.lineHeightNormal,
        fontFamily: IbeereTypography.fontFamily,
        color: Colors.white,
      ),
      labelMedium: TextStyle(
        fontSize: IbeereTypography.sm,
        fontWeight: IbeereTypography.medium,
        height: IbeereTypography.lineHeightNormal,
        fontFamily: IbeereTypography.fontFamily,
        color: Colors.white,
      ),
      labelSmall: TextStyle(
        fontSize: IbeereTypography.xs,
        fontWeight: IbeereTypography.medium,
        height: IbeereTypography.lineHeightNormal,
        fontFamily: IbeereTypography.fontFamily,
        color: Colors.white,
      ),
    );
  }

  static TextStyle _titleTextStyle() {
    return const TextStyle(
      fontSize: IbeereTypography.lg,
      fontWeight: IbeereTypography.semibold,
      color: IbeereColors.gray900,
      fontFamily: IbeereTypography.fontFamily,
    );
  }
}

