import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';

class IbeereKaurisStoreCard extends StatelessWidget {
  const IbeereKaurisStoreCard({
    required this.title,
    required this.kaurisAmount,
    required this.price,
    required this.onTap,
    this.isBestValue = false,
    this.isVIP = false,
    super.key,
  });

  final String title;
  final String kaurisAmount;
  final String price;
  final VoidCallback onTap;
  final bool isBestValue;
  final bool isVIP;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [IbeereDesignTokens.cardShadow],
        ),
        child: Column(
          children: [
            if (isBestValue)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: IbeereDesignTokens.primaryPurple,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'BEST VALUE',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            if (isBestValue) const SizedBox(height: 12),
            
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/coin.svg',
                  width: 80,
                  height: 80,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFBBF24),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.circle,
                        color: Color(0xFFFBBF24),
                        size: 60,
                      ),
                    );
                  },
                ),
                if (isVIP)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: IbeereDesignTokens.primaryPurple,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.star,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            
            Text(
              title.toUpperCase(),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: IbeereDesignTokens.textSecondary,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 8),
            
            RichText(
              text: TextSpan(
                text: kaurisAmount,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: IbeereDesignTokens.textPrimary,
                ),
                children: const [
                  TextSpan(
                    text: ' Kauris',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: IbeereDesignTokens.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                price,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: IbeereDesignTokens.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IbeereBalanceCard extends StatelessWidget {
  const IbeereBalanceCard({
    required this.balance,
    required this.onTopUp,
    super.key,
  });

  final String balance;
  final VoidCallback onTopUp;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF5B21B6), Color(0xFF4F46E5), Color(0xFF06B6D4)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 10,
            left: 20,
            child: _buildDecorativeShape(12, IbeereDesignTokens.primaryRed),
          ),
          Positioned(
            top: 20,
            right: 30,
            child: _buildDecorativeShape(8, IbeereDesignTokens.accentYellow),
          ),
          Positioned(
            bottom: 20,
            left: 40,
            child: _buildDecorativeShape(10, IbeereDesignTokens.decorativeGreen),
          ),
          Positioned(
            bottom: 30,
            right: 50,
            child: _buildDecorativeShape(14, Colors.white),
          ),
          Positioned(
            top: 15,
            left: 60,
            child: _buildDecorativeShape(6, IbeereDesignTokens.accentCyan, isTriangle: true),
          ),
          
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: balance,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        children: const [
                          TextSpan(
                            text: ' KAURIS',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Your Balance',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onTopUp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.2),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'TOP UP',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.refresh_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDecorativeShape(double size, Color color, {bool isTriangle = false}) {
    if (isTriangle) {
      return CustomPaint(
        size: Size(size, size),
        painter: _TrianglePainter(color: color.withOpacity(0.3)),
      );
    }
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withOpacity(0.3),
        shape: BoxShape.circle,
      ),
    );
  }
}

class _TrianglePainter extends CustomPainter {
  _TrianglePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
