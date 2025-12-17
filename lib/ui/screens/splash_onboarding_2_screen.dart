import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';
import 'package:flutterquiz/ui/widgets/ibeere_v2_buttons.dart';

class SplashOnboarding2Screen extends StatelessWidget {
  const SplashOnboarding2Screen({super.key});

  static const String routeName = '/splash-onboarding-2';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E3A8A),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(top: 50, right: 20, child: _DecorativeCircle(color: Colors.white.withOpacity(0.05), size: 100)),
            Positioned(top: 150, left: -30, child: _DecorativeCircle(color: Colors.white.withOpacity(0.05), size: 140)),
            Positioned(bottom: 180, right: -40, child: _DecorativeCircle(color: Colors.white.withOpacity(0.05), size: 160)),
            
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('2/3', style: TextStyle(color: Colors.white70, fontSize: 14)),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/phone-login'),
                        child: Text('Skip', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _ProfileCard(Icons.person, Color(0xFFEC4899)),
                            const SizedBox(width: 20),
                            Column(
                              children: [
                                Icon(Icons.bolt, color: Color(0xFFFBBF24), size: 32),
                                const SizedBox(height: 8),
                                Text('VS', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const SizedBox(width: 20),
                            _ProfileCard(Icons.person, Color(0xFF8B5CF6)),
                          ],
                        ),
                        const SizedBox(height: 60),
                        Text(
                          'Ultimate Quiz Challenge',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Compete with friends and players\nworldwide in real-time battles',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
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
                    onPressed: () => Navigator.pushNamed(context, '/splash-onboarding-3'),
                    variant: IbeereButtonVariant.white,
                    icon: Icons.arrow_forward,
                  ),
                  const SizedBox(height: 20),
                  Text('Ibeere', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
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

class _ProfileCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  const _ProfileCard(this.icon, this.color);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: Offset(0, 4))],
      ),
      child: Icon(icon, size: 40, color: color),
    );
  }
}
