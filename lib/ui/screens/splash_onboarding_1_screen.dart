import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';
import 'package:flutterquiz/ui/widgets/ibeere_v2_buttons.dart';

class SplashOnboarding1Screen extends StatelessWidget {
  const SplashOnboarding1Screen({super.key});

  static const String routeName = '/splash-onboarding-1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IbeereDesignTokens.backgroundLight,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(top: 40, right: -30, child: _DecorativeCircle(color: Color(0xFFEC4899).withOpacity(0.1), size: 120)),
            Positioned(top: 120, left: 30, child: _DecorativeSquare(color: Color(0xFF8B5CF6).withOpacity(0.1), size: 60)),
            Positioned(bottom: 200, right: 40, child: _DecorativeTriangle(color: Color(0xFFFBBF24).withOpacity(0.1), size: 70)),
            Positioned(bottom: 150, left: -20, child: _DecorativeCircle(color: Color(0xFF10B981).withOpacity(0.1), size: 100)),
            
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('1/3', style: TextStyle(color: IbeereDesignTokens.textSecondary, fontSize: 14)),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/phone-login'),
                        child: Text('Skip', style: TextStyle(color: IbeereDesignTokens.primaryPurple, fontSize: 14, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 80),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            color: IbeereDesignTokens.primaryPurple.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.quiz, size: 80, color: IbeereDesignTokens.primaryPurple),
                        ),
                        const SizedBox(height: 48),
                        Text(
                          'Test Your Knowledge',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: IbeereDesignTokens.textPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Challenge yourself with thousands of\nquestions across multiple categories',
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
                    text: 'Next',
                    onPressed: () => Navigator.pushNamed(context, '/splash-onboarding-2'),
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

class _DecorativeTriangle extends StatelessWidget {
  final Color color;
  final double size;
  const _DecorativeTriangle({required this.color, required this.size});
  @override
  Widget build(BuildContext context) => CustomPaint(size: Size(size, size), painter: _TrianglePainter(color));
}

class _TrianglePainter extends CustomPainter {
  final Color color;
  _TrianglePainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color..style = PaintingStyle.fill;
    final path = Path()..moveTo(size.width / 2, 0)..lineTo(size.width, size.height)..lineTo(0, size.height)..close();
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
