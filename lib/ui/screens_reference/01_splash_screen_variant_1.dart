import 'package:flutter/material.dart';
import '../../core/theme/design_tokens.dart';
import '../widgets/ibeere_buttons.dart';
import '../widgets/ibeere_cards.dart';
import '../widgets/ibeere_navigation.dart';

/// Splash Screen - Variant 1
/// Displays app splash/launch screen with logo and branding
class SplashScreenVariant1 extends StatelessWidget {
  const SplashScreenVariant1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.quiz,
              size: 80,
              color: DesignTokens.primary,
            ),
            const SizedBox(height: 24),
            Text(
              'Ibeere',
              style: TextStyle(
                fontSize: DesignTokens.fontSizeXxxl,
                fontWeight: DesignTokens.fontWeightBold,
                color: DesignTokens.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Learn & Compete',
              style: TextStyle(
                fontSize: DesignTokens.fontSizeLg,
                color: DesignTokens.neutral,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
