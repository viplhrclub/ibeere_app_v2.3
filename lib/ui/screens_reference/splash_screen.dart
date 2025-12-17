import 'package:flutter/material.dart';
import '../../core/theme/design_tokens.dart';

/// Ibeere Splash Screen
/// 
/// Initial landing screen with logo and branding
/// Displays animated splash with app name and tagline
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _navigateToNext();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(begin: Offset(0, 0.3), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
        );

    _animationController.forward();
  }

  void _navigateToNext() {
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        // Navigate to next screen - replace with your navigation logic
        // Navigator.of(context).pushReplacementNamed('/onboarding');
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.primary,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo/Icon Container
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      Icons.quiz_rounded,
                      size: 60,
                      color: DesignTokens.primary,
                    ),
                  ),
                ),
                SizedBox(height: DesignTokens.spaceXl),
                
                // App Name
                Text(
                  'Ibeere',
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeXxxl,
                    fontWeight: DesignTokens.fontWeightBold,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(height: DesignTokens.spaceMd),
                
                // Tagline
                Text(
                  'Master Your Knowledge',
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeLg,
                    fontWeight: DesignTokens.fontWeightLight,
                    color: Colors.white.withOpacity(0.8),
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
