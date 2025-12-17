import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';
import 'package:flutterquiz/ui/widgets/ibeere_v2_buttons.dart';

class SplashOnboarding3Screen extends StatelessWidget {
  const SplashOnboarding3Screen({super.key});

  static const String routeName = '/splash-onboarding-3';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IbeereDesignTokens.backgroundLight,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(top: 60, right: 20, child: _DecorativeCircle(color: Color(0xFF10B981).withOpacity(0.1), size: 90)),
            Positioned(top: 140, left: -20, child: _DecorativeSquare(color: Color(0xFFEC4899).withOpacity(0.1), size: 70)),
            Positioned(bottom: 160, right: 30, child: _DecorativeDiamond(color: Color(0xFFFBBF24).withOpacity(0.1), size: 60)),
            
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('3/3', style: TextStyle(color: IbeereDesignTokens.textSecondary, fontSize: 14)),
                      const SizedBox(width: 40),
                    ],
                  ),
                  const SizedBox(height: 80),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 180,
                          height: 180,
                          decoration: BoxDecoration(
                            color: Color(0xFF10B981).withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.play_circle_filled, size: 100, color: Color(0xFF10B981)),
                        ),
                        const SizedBox(height: 48),
                        Text(
                          'Get Ready to Quiz!',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: IbeereDesignTokens.textPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Win coins, unlock badges and\nclimb the leaderboard',
                          style: TextStyle(
                            fontSize: 16,
                            color: IbeereDesignTokens.textSecondary,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  IbeereButton(
                    text: 'Get Started',
                    onPressed: () => Navigator.pushReplacementNamed(context, '/phone-login'),
                    icon: Icons.arrow_forward,
                  ),
                  const SizedBox(height: 20),
                  Image.asset('assets/images/ibeere_logo.png', height: 40, errorBuilder: (_, __, ___) => Text('Ibeere', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: IbeereDesignTokens.primaryPurple))),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DecorativeCircle extends StatelessWidget {
  final Color color;
  final double size;
  const _DecorativeCircle({required this.color, required this.size});
  @override
  Widget build(BuildContext context) => Container(width: size, height: size, decoration: BoxDecoration(color: color, shape: BoxShape.circle));
}

class _DecorativeSquare extends StatelessWidget {
  final Color color;
  final double size;
  const _DecorativeSquare({required this.color, required this.size});
  @override
  Widget build(BuildContext context) => Container(width: size, height: size, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)));
}

class _DecorativeDiamond extends StatelessWidget {
  final Color color;
  final double size;
  const _DecorativeDiamond({required this.color, required this.size});
  @override
  Widget build(BuildContext context) => Transform.rotate(angle: 0.785398, child: Container(width: size, height: size, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8))));
}
