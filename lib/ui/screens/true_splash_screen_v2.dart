import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';

class TrueSplashScreenV2 extends StatefulWidget {
  const TrueSplashScreenV2({super.key});

  @override
  State<TrueSplashScreenV2> createState() => _TrueSplashScreenV2State();
}

class _TrueSplashScreenV2State extends State<TrueSplashScreenV2>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/onboarding-ultimate');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFC),
      body: Stack(
        children: [
          Positioned(
            top: 120,
            left: 30,
            child: _buildDecoShape(Color(0xFFFFE5E5), 50, 30),
          ),
          Positioned(
            top: 200,
            right: 40,
            child: _buildDecoShape(Color(0xFFE8EDFF), 40, 40),
          ),
          Positioned(
            bottom: 250,
            left: 50,
            child: _buildDecoShape(Color(0xFFFFF5E5), 45, 35),
          ),
          Positioned(
            bottom: 180,
            right: 30,
            child: _buildDecoShape(Color(0xFFE8F5E9), 55, 45),
          ),
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeAnimation.value,
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              top: -10,
                              left: -30,
                              child: Icon(Icons.play_arrow, color: Color(0xFF6366F1), size: 20),
                            ),
                            Positioned(
                              top: 15,
                              right: -25,
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: Color(0xFFEC4899),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: -15,
                              right: -20,
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFCD34D),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                            Text(
                              'ibeere',
                              style: TextStyle(
                                fontSize: 56,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF6366F1),
                                letterSpacing: -1,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 20,
                              height: 2,
                              decoration: BoxDecoration(
                                color: Color(0xFF1F2937),
                                borderRadius: BorderRadius.circular(1),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Games',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1F2937),
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 20,
                              height: 2,
                              decoration: BoxDecoration(
                                color: Color(0xFF1F2937),
                                borderRadius: BorderRadius.circular(1),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDecoShape(Color color, double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color.withOpacity(0.6),
        borderRadius: BorderRadius.circular(height / 2),
      ),
    );
  }
}
