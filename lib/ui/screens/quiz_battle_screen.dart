import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';

class QuizBattleScreen extends StatefulWidget {
  const QuizBattleScreen({super.key});

  static const String routeName = '/quiz-battle';

  @override
  State<QuizBattleScreen> createState() => _QuizBattleScreenState();
}

class _QuizBattleScreenState extends State<QuizBattleScreen> {
  int _currentQuestion = 1;
  final int _totalQuestions = 5;
  String? _selectedAnswer;
  bool _answerLocked = false;
  double _userPoints = 12.7;
  double _opponentPoints = 0.895;

  final String _question = "Qu'est-ce que l'indice des prix à la consommation (IPC)? Qu'est-ce que l'indice des prix à la profession (IPC)?";

  final List<Map<String, dynamic>> _options = [
    {'text': 'Les mesures prises pour atténuer les fluctuations économiques.', 'isCorrect': false},
    {'text': 'L\'ouverture des frontières aux flux migratoires.', 'isCorrect': false},
    {'text': 'La mesure du chômage, une économie', 'isCorrect': false},
    {'text': 'Allasane Ouatara', 'isCorrect': false},
  ];

  void _selectAnswer(int index) {
    if (!_answerLocked) {
      setState(() {
        _selectedAnswer = index.toString();
        _answerLocked = true;
      });
      Future.delayed(Duration(seconds: 2), () {
        _nextQuestion();
      });
    }
  }

  void _nextQuestion() {
    if (_currentQuestion < _totalQuestions) {
      setState(() {
        _currentQuestion++;
        _selectedAnswer = null;
        _answerLocked = false;
      });
    } else {
      Navigator.pushNamed(context, '/quiz-results');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IbeereDesignTokens.backgroundLight,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(top: 40, right: -30, child: _DecorativeCircle(color: Color(0xFF8B5CF6).withOpacity(0.1), size: 80)),
            Positioned(top: 200, left: -20, child: _DecorativeCircle(color: Color(0xFF06B6D4).withOpacity(0.1), size: 60)),
            Positioned(bottom: 250, right: 40, child: _DecorativeSquare(color: Color(0xFFFBBF24).withOpacity(0.1), size: 30)),
            Positioned(bottom: 150, left: 30, child: _DecorativeTriangle(color: Color(0xFFEF4444).withOpacity(0.1), size: 35)),
            Column(
              children: [
                _buildQuestionCounter(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        _buildQuestionCard(),
                        const SizedBox(height: 24),
                        _buildOptions(),
                      ],
                    ),
                  ),
                ),
                _buildBottomSection(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionCounter() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        '$_currentQuestion | $_totalQuestions Questions',
        style: TextStyle(
          color: IbeereDesignTokens.textSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildQuestionCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15, offset: Offset(0, 4))],
      ),
      child: Stack(
        children: [
          Positioned(top: -5, right: 10, child: _DecorativeSquare(color: Color(0xFF8B5CF6).withOpacity(0.1), size: 25)),
          Positioned(bottom: 10, left: 15, child: _DecorativeCircle(color: Color(0xFF06B6D4).withOpacity(0.1), size: 30)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 4,
                height: 60,
                decoration: BoxDecoration(
                  color: IbeereDesignTokens.primaryRed,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  _question,
                  style: TextStyle(
                    color: Color(0xFF5B6B8C),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOptions() {
    return Column(
      children: List.generate(
        _options.length,
        (index) => Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: Stack(
            children: [
              Positioned(top: 10, right: 15, child: _DecorativeSquare(color: Color(0xFF8B5CF6).withOpacity(0.08), size: 20)),
              Positioned(bottom: 8, left: 20, child: _DecorativeCircle(color: Color(0xFF10B981).withOpacity(0.08), size: 15)),
              GestureDetector(
                onTap: () => _selectAnswer(index),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border(
                      left: BorderSide(
                        color: Color(0xFF5B6B8C),
                        width: 3,
                      ),
                    ),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: Offset(0, 2))],
                  ),
                  child: Text(
                    _options[index]['text'],
                    style: TextStyle(
                      color: Color(0xFF5B6B8C),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF6366F1).withOpacity(0.95), Color(0xFF8B5CF6).withOpacity(0.95)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildPlayerInfo(true),
              Column(
                children: [
                  Text(
                    'VS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: IbeereDesignTokens.primaryPurple,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Icon(Icons.remove_red_eye, color: Colors.white, size: 18),
                  ),
                ],
              ),
              _buildPlayerInfo(false),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: IbeereDesignTokens.primaryPurple.withOpacity(0.3),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
            ),
            child: Icon(Icons.grid_view, color: Colors.white, size: 28),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerInfo(bool isUser) {
    final points = isUser ? _userPoints : _opponentPoints;
    final image = isUser ? 'assets/profile/1.svg' : 'assets/profile/2.svg';
    final name = isUser ? 'Melissa_lin...' : 'Opponent';
    final bgColor = isUser ? Color(0xFFFBBF24) : Color(0xFFEC9696);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Color(0xFF5B6B8C),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Icon(Icons.star, color: IbeereDesignTokens.accentYellow, size: 18),
              const SizedBox(width: 4),
              Text(
                '+${points}K Points',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 12, offset: Offset(0, 4))],
          ),
          child: Icon(Icons.person, size: 40, color: Colors.white),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
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