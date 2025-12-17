import 'package:flutter/cupertino.dart';
import 'package:flutterquiz/ui/screens/splash_screen.dart';

/// Splash Screen - Variant 2
/// Screenshot: 01_splash_screen_2
class SplashScreenVariant2 extends StatelessWidget {
  const SplashScreenVariant2({super.key});

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }

  static Route<dynamic> route() {
    return CupertinoPageRoute(
      builder: (_) => const SplashScreenVariant2(),
    );
  }
}

