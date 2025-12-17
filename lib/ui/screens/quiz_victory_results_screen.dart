import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';

class QuizVictoryResultsScreen extends StatelessWidget {
  const QuizVictoryResultsScreen({super.key});

  static const String routeName = '/quiz-victory-results';

  @override
  Widget build(BuildContext context) {
    const userName = 'Melissa';
    const userLevel = 38;
    const userKauris = 45000;
    const userPoints = 1500000;
    const correctAnswers = 3;
    const wrongAnswers = 2;
    const totalQuestions = 5;
    const coinsEarned = 1200;

    return Scaffold(
      backgroundColor: IbeereDesignTokens.backgroundLight,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(top: 60, right: 30, child: _DecorativeCircle(color: Color(0xFFEC4899).withOpacity(0.12), size: 50)),
            Positioned(top: 180, left: 40, child: _DecorativeCircle(color: Color(0xFF06B6D4).withOpacity(0.12), size: 45)),
            Positioned(bottom: 250, right: 60, child: _DecorativeSquare(color: Color(0xFFFBBF24).withOpacity(0.12), size: 30)),
            Positioned(bottom: 400, left: 50, child: _DecorativeTriangle(color: Color(0xFFEF4444).withOpacity(0.12), size: 35)),
            Positioned(top: 350, right: 100, child: _DecorativeCircle(color: Color(0xFF10B981).withOpacity(0.12), size: 55)),
            SingleChildScrollView(
              child: Column(
                children: [
                  _buildUserHeader(),
                  const SizedBox(height: 40),
                  Text(
                    'VICTORY',
                    style: TextStyle(
                      color: Color(0xFF5B6B8C),
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Congratulation',
                    style: TextStyle(
                      color: IbeereDesignTokens.textSecondary,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 40),
                  _buildScoreCircle(correctAnswers, wrongAnswers, totalQuestions, coinsEarned),
                  const SizedBox(height: 50),
                  _buildDoubleCoinsButton(),
                  const SizedBox(height: 32),
                  _buildActionButtons(context),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 8)],
            ),
            child: Center(
              child: Text(
                '38',
                style: TextStyle(
                  color: Color(0xFF5B6B8C),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: IbeereDesignTokens.accentCyan,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 10)],
            ),
            child: Icon(Icons.person, color: Colors.white, size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Melissa',
                  style: TextStyle(
                    color: IbeereDesignTokens.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '45k Kauris  |  1500k Points',
                  style: TextStyle(
                    color: IbeereDesignTokens.textSecondary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreCircle(int correct, int wrong, int total, int coins) {
    return Container(
      width: 280,
      height: 280,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 240,
            height: 240,
            child: CustomPaint(
              painter: _ScoreCirclePainter(correct, wrong, total),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '500',
                style: TextStyle(
                  color: Color(0xFF5B6B8C),
                  fontSize: 56,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                'POINTS',
                style: TextStyle(
                  color: IbeereDesignTokens.textTertiary,
                  fontSize: 14,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          Positioned(
            top: 40,
            left: 20,
            child: _buildScoreLabel('$correct/$total', IbeereDesignTokens.primaryRed),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: _buildScoreLabel('$correct/$total', IbeereDesignTokens.accentGreen),
          ),
          Positioned(
            bottom: 20,
            child: _buildScoreLabel('$coins', IbeereDesignTokens.accentYellow),
          ),
          Positioned(
            bottom: 160,
            left: 80,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: IbeereDesignTokens.accentGreen,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 50,
            child: Text('Correct', style: TextStyle(color: IbeereDesignTokens.accentGreen, fontSize: 13, fontWeight: FontWeight.w600)),
          ),
          Positioned(
            bottom: 160,
            right: 80,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: IbeereDesignTokens.primaryRed,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 100,
            right: 50,
            child: Text('Wrong', style: TextStyle(color: IbeereDesignTokens.primaryRed, fontSize: 13, fontWeight: FontWeight.w600)),
          ),
          Positioned(
            bottom: 70,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: IbeereDesignTokens.accentYellow,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            child: Text('Coins', style: TextStyle(color: IbeereDesignTokens.accentYellow, fontSize: 13, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreLabel(String text, Color color) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildDoubleCoinsButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      width: double.infinity,
      height: 68,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [IbeereDesignTokens.primaryRed, Color(0xFFDC2626)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(34),
        boxShadow: [BoxShadow(color: IbeereDesignTokens.primaryRed.withOpacity(0.4), blurRadius: 20, offset: Offset(0, 8))],
      ),
      child: Stack(
        children: [
          Positioned(top: 15, right: 80, child: Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), shape: BoxShape.circle))),
          Positioned(bottom: 20, left: 100, child: _DecorativeSquare(color: Colors.white.withOpacity(0.2), size: 12)),
          Positioned(top: 12, left: 60, child: Container(width: 10, height: 10, decoration: BoxDecoration(color: Colors.white.withOpacity(0.25), shape: BoxShape.circle))),
          Positioned(bottom: 18, right: 120, child: _DecorativeTriangle(color: Colors.white.withOpacity(0.15), size: 14)),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(34),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.play_arrow, color: Colors.white, size: 32),
                    const SizedBox(width: 12),
                    Text(
                      'Double Coins x2',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildActionButton(Icons.replay, 'Play again !', () {})),
              const SizedBox(width: 16),
              Expanded(child: _buildActionButton(Icons.refresh, 'Review Quiz', () => Navigator.pushNamed(context, '/review-quiz'))),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildActionButton(Icons.share, 'Share score', () {})),
              const SizedBox(width: 16),
              Expanded(child: _buildActionButton(Icons.home_outlined, 'Back home', () => Navigator.pushNamed(context, '/home'))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: Offset(0, 2))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Color(0xFF5B6B8C), size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: Color(0xFF5B6B8C),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScoreCirclePainter extends CustomPainter {
  final int correct;
  final int wrong;
  final int total;

  _ScoreCirclePainter(this.correct, this.wrong, this.total);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final strokeWidth = 24.0;

    final correctAngle = (correct / total) * 360;
    final wrongAngle = (wrong / total) * 360;
    final coinsAngle = 360 - correctAngle - wrongAngle;

    final paintGreen = Paint()
      ..color = Color(0xFF10B981)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final paintRed = Paint()
      ..color = Color(0xFFEF4444)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final paintYellow = Paint()
      ..color = Color(0xFFFBBF24)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final rectGreen = Rect.fromCircle(center: center, radius: radius - strokeWidth / 2);
    canvas.drawArc(rectGreen, -90 * (3.14159 / 180), correctAngle * (3.14159 / 180), false, paintGreen);

    final rectRed = Rect.fromCircle(center: center, radius: radius - strokeWidth / 2);
    canvas.drawArc(rectRed, (-90 + correctAngle) * (3.14159 / 180), wrongAngle * (3.14159 / 180), false, paintRed);

    final rectYellow = Rect.fromCircle(center: center, radius: radius - strokeWidth / 2);
    canvas.drawArc(rectYellow, (-90 + correctAngle + wrongAngle) * (3.14159 / 180), coinsAngle * (3.14159 / 180), false, paintYellow);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
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
  Widget build(BuildContext context) => Container(width: size, height: size, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)));
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