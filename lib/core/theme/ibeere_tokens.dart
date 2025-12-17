import 'package:flutter/material.dart';

class IbeereDesignTokens {
  static const primaryPurple = Color(0xFF6366F1);
  static const primaryPink = Color(0xFFEC4899);
  static const primaryRed = Color(0xFFEF4444);
  
  static const backgroundLight = Color(0xFFF8F9FA);
  static const backgroundWhite = Color(0xFFFFFFFF);
  static const cardBackground = Color(0xFFFFFFFF);
  
  static const textPrimary = Color(0xFF1E293B);
  static const textSecondary = Color(0xFF64748B);
  static const textTertiary = Color(0xFF94A3B8);
  
  static const accentYellow = Color(0xFFFBBF24);
  static const accentGreen = Color(0xFF10B981);
  static const accentCyan = Color(0xFF06B6D4);
  
  static const decorativePink = Color(0xFFFFB6C1);
  static const decorativePurple = Color(0xFFD8B4FE);
  static const decorativeYellow = Color(0xFFFEF3C7);
  static const decorativeGreen = Color(0xFFBBF7D0);
  
  static const borderRadius = 20.0;
  static const borderRadiusLarge = 24.0;
  static const borderRadiusSmall = 12.0;
  static const borderRadiusButton = 28.0;
  
  static const spacing4 = 4.0;
  static const spacing8 = 8.0;
  static const spacing12 = 12.0;
  static const spacing16 = 16.0;
  static const spacing20 = 20.0;
  static const spacing24 = 24.0;
  static const spacing32 = 32.0;
  static const spacing48 = 48.0;
  
  static const cardElevation = 2.0;
  static const buttonElevation = 4.0;
  
  static const shadowColor = Color(0x1A000000);
  
  static BoxShadow get cardShadow => BoxShadow(
        color: shadowColor,
        blurRadius: 12,
        offset: const Offset(0, 4),
      );
  
  static BoxShadow get buttonShadow => BoxShadow(
        color: shadowColor,
        blurRadius: 16,
        offset: const Offset(0, 6),
      );
  
  static LinearGradient get primaryGradient => const LinearGradient(
        colors: [primaryPurple, primaryPink],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
  
  static const fontWeightRegular = FontWeight.w400;
  static const fontWeightMedium = FontWeight.w500;
  static const fontWeightSemiBold = FontWeight.w600;
  static const fontWeightBold = FontWeight.w700;
  
  static const fontSizeSmall = 12.0;
  static const fontSizeBody = 14.0;
  static const fontSizeMedium = 16.0;
  static const fontSizeLarge = 18.0;
  static const fontSizeTitle = 24.0;
  static const fontSizeHeading = 32.0;
}

class IbeereDecorativeShapes extends StatelessWidget {
  const IbeereDecorativeShapes({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 100,
          left: 20,
          child: _buildShape(
            color: IbeereDesignTokens.decorativePink,
            size: 40,
            shape: BoxShape.circle,
          ),
        ),
        Positioned(
          top: 150,
          right: 30,
          child: _buildShape(
            color: IbeereDesignTokens.decorativeYellow,
            size: 30,
            shape: BoxShape.circle,
          ),
        ),
        Positioned(
          bottom: 200,
          left: 40,
          child: _buildShape(
            color: IbeereDesignTokens.decorativeGreen,
            size: 20,
            shape: BoxShape.circle,
          ),
        ),
        Positioned(
          bottom: 150,
          right: 50,
          child: Transform.rotate(
            angle: 0.785,
            child: _buildShape(
              color: IbeereDesignTokens.decorativePurple,
              size: 25,
              shape: BoxShape.rectangle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildShape({
    required Color color,
    required double size,
    required BoxShape shape,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withOpacity(0.3),
        shape: shape,
      ),
    );
  }
}
