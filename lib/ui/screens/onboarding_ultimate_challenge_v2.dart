import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';

class OnboardingUltimateChallengeV2 extends StatelessWidget {
  const OnboardingUltimateChallengeV2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1A2746),
              Color(0xFF2D3E61),
              Color(0xFF1A2746),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        _buildDot(false, small: true),
                        const SizedBox(width: 8),
                        _buildDot(true, small: false),
                        const SizedBox(width: 8),
                        _buildDot(false, small: true),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/language-selection');
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    _buildFloatingDecoration(30, 100, Color(0xFF8B5CF6), 60, 60),
                    _buildFloatingDecoration(350, 200, Color(0xFFEC4899), 40, 40),
                    _buildFloatingDecoration(60, 550, Color(0xFF10B981), 50, 50),
                    _buildFloatingDecoration(320, 620, Color(0xFFEF4444), 45, 45),
                    _buildSmallDeco(100, 350, Color(0xFFFCD34D)),
                    _buildSmallDeco(300, 480, Color(0xFF3B82F6)),
                    _buildSmallDeco(50, 700, Color(0xFFEC4899)),
                    _buildSmallDeco(340, 280, Color(0xFF10B981)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildProfileCard(
                              name: 'Melissa_lin...',
                              imageRotation: -0.1,
                              borderColor: Color(0xFFFFFFFF),
                            ),
                            const SizedBox(width: 20),
                            _buildProfileCard(
                              name: 'fawazgladi...',
                              imageRotation: 0.08,
                              borderColor: Color(0xFFFFE5B4),
                            ),
                          ],
                        ),
                        const SizedBox(height: 120),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: Color(0xFF2D3E61).withOpacity(0.8),
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'The Ultimate Quiz Challenge',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                              color: Colors.white.withOpacity(0.9),
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            '"Think you\'re a genius ? Prove it\nwith our Challenge quizzes !"',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.7),
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 28),
                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/onboarding-get-ready');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFEF4444),
                                foregroundColor: Colors.white,
                                elevation: 4,
                                shadowColor: Color(0xFFEF4444).withOpacity(0.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(26),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.sports_esports_rounded, size: 20),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Next',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard({
    required String name,
    required double imageRotation,
    required Color borderColor,
  }) {
    return Transform.rotate(
      angle: imageRotation,
      child: Container(
        width: 140,
        height: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: borderColor, width: 4),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFBCAADF),
                      Color(0xFFE8DCFF),
                    ],
                  ),
                ),
                child: Icon(
                  Icons.person_rounded,
                  size: 80,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
              Positioned(
                bottom: 12,
                left: 12,
                right: 12,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          name,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingDecoration(double top, double left, Color color, double width, double height) {
    return Positioned(
      top: top,
      left: left,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(height / 2),
        ),
      ),
    );
  }

  Widget _buildSmallDeco(double top, double left, Color color) {
    return Positioned(
      top: top,
      left: left,
      child: Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: color.withOpacity(0.4),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildDot(bool active, {required bool small}) {
    return Container(
      width: small ? 8 : 32,
      height: 8,
      decoration: BoxDecoration(
        color: active ? Colors.white.withOpacity(0.9) : Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
