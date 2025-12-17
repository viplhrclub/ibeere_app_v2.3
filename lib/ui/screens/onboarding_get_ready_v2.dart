import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';

class OnboardingGetReadyV2 extends StatelessWidget {
  const OnboardingGetReadyV2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(top: 80, left: 30, child: _buildDecoShape(Color(0xFFFFE5E5), 50, 35)),
            Positioned(top: 180, right: 40, child: _buildDecoShape(Color(0xFFFFF8DC), 55, 40)),
            Positioned(bottom: 280, left: 40, child: _buildDecoShape(Color(0xFFE8F5E9), 45, 38)),
            Positioned(bottom: 200, right: 30, child: _buildDecoShape(Color(0xFFFFE5F3), 50, 42)),
            Positioned(top: 420, left: 100, child: _buildSmallCircle(Color(0xFFFCD34D))),
            Positioned(top: 520, right: 80, child: _buildSmallCircle(Color(0xFF10B981))),
            Positioned(bottom: 450, left: 60, child: _buildSmallCircle(Color(0xFFEC4899))),
            Positioned(bottom: 380, right: 90, child: _buildSmallCircle(Color(0xFF3B82F6))),
            Positioned(
              top: 30,
              left: 24,
              child: Row(
                children: [
                  _buildDot(false, true),
                  const SizedBox(width: 8),
                  _buildDot(false, true),
                  const SizedBox(width: 8),
                  _buildDot(true, false),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 280,
                          height: 280,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                top: 30,
                                left: 60,
                                child: Transform.rotate(
                                  angle: -0.3,
                                  child: Container(
                                    width: 160,
                                    height: 180,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(80),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 30,
                                          offset: Offset(10, 15),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 80,
                                left: 30,
                                child: Transform.rotate(
                                  angle: -0.2,
                                  child: Container(
                                    width: 100,
                                    height: 120,
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFFE8C4FF),
                                          Color(0xFFDDA4FF),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: Color(0xFFD4ADFF), width: 3),
                                    ),
                                    child: Icon(
                                      Icons.image_outlined,
                                      size: 40,
                                      color: Color(0xFFB366FF),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          'Get Ready to Quiz',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF4A5568),
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Text(
                            '"Discover exciting Quiz categories\nand improve your Skill !"',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF6B7280),
                              height: 1.6,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/language-selection');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFEF4444),
                        foregroundColor: Colors.white,
                        elevation: 6,
                        shadowColor: Color(0xFFEF4444).withOpacity(0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(27),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.sports_esports_rounded, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'Get Started',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'ibeere',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF6366F1),
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 16,
                        height: 2,
                        color: Color(0xFF1F2937),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Games',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1F2937),
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        width: 16,
                        height: 2,
                        color: Color(0xFF1F2937),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
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

  Widget _buildSmallCircle(Color color) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: color.withOpacity(0.6),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildDot(bool active, bool small) {
    return Container(
      width: small ? 8 : 32,
      height: 8,
      decoration: BoxDecoration(
        color: active ? Color(0xFF6B7280) : Color(0xFF9CA3AF),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
