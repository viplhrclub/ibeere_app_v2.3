import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';

class QuizPlayingScreen extends StatefulWidget {
  const QuizPlayingScreen({super.key});

  static const String routeName = '/quiz-playing';

  @override
  State<QuizPlayingScreen> createState() => _QuizPlayingScreenState();
}

class _QuizPlayingScreenState extends State<QuizPlayingScreen> {
  int _timeRemaining = 30;
  int _currentQuestion = 3;
  final int _totalQuestions = 10;
  int _userScore = 150;
  int _opponentScore = 120;
  String? _selectedAnswer;
  bool _answerLocked = false;
  Timer? _timer;

  final List<String> _options = [
    'Mitochondria',
    'Nucleus',
    'Ribosome',
    'Endoplasmic Reticulum',
  ];

  final String _correctAnswer = 'a';

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timeRemaining > 0) {
        setState(() => _timeRemaining--);
      } else {
        _timer?.cancel();
        _nextQuestion();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _selectAnswer(String answer) {
    if (!_answerLocked) {
      setState(() {
        _selectedAnswer = answer;
        _answerLocked = true;
      });
      Future.delayed(Duration(seconds: 2), () => _nextQuestion());
    }
  }

  void _nextQuestion() {
    if (_currentQuestion < _totalQuestions) {
      setState(() {
        _currentQuestion++;
        _timeRemaining = 30;
        _selectedAnswer = null;
        _answerLocked = false;
      });
    } else {
      Navigator.pushNamed(context, '/quiz-results');
    }
  }

  void _useLifeline(String type) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$type lifeline used!'), duration: Duration(seconds: 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IbeereDesignTokens.backgroundLight,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(top: 40, right: -30, child: _DecorativeCircle(color: IbeereDesignTokens.decorativePink.withOpacity(0.3), size: 120)),
            Positioned(bottom: 100, left: -40, child: _DecorativeCircle(color: IbeereDesignTokens.decorativeYellow.withOpacity(0.3), size: 140)),
            Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        _buildQuestionCard(),
                        const SizedBox(height: 24),
                        _buildOptions(),
                        const SizedBox(height: 24),
                        _buildLifelines(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: Offset(0, 2))],
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  value: _timeRemaining / 30,
                  strokeWidth: 6,
                  backgroundColor: IbeereDesignTokens.backgroundLight,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _timeRemaining > 10 ? IbeereDesignTokens.accentGreen : IbeereDesignTokens.primaryRed,
                  ),
                ),
              ),
              Text(
                '$_timeRemaining',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: _timeRemaining > 10 ? IbeereDesignTokens.accentGreen : IbeereDesignTokens.primaryRed,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildPlayerInfo('You', _userScore, IbeereDesignTokens.primaryPurple, true),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: IbeereDesignTokens.accentYellow.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$_currentQuestion/$_totalQuestions',
                  style: TextStyle(color: IbeereDesignTokens.textPrimary, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              _buildPlayerInfo('Opponent', _opponentScore, IbeereDesignTokens.primaryPink, false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerInfo(String name, int score, Color color, bool isLeft) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2),
          ),
          child: Icon(Icons.person, color: color, size: 28),
        ),
        const SizedBox(height: 8),
        Text(name, style: TextStyle(color: IbeereDesignTokens.textSecondary, fontSize: 12)),
        Text('$score', style: TextStyle(color: IbeereDesignTokens.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildQuestionCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [IbeereDesignTokens.primaryPurple, IbeereDesignTokens.primaryPink],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: IbeereDesignTokens.primaryPurple.withOpacity(0.3), blurRadius: 15, offset: Offset(0, 8))],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text('Science', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 16),
          Text(
            'What is the powerhouse of the cell?',
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, height: 1.4),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildOptions() {
    return Column(
      children: List.generate(4, (index) {
        final letter = String.fromCharCode(97 + index);
        final isSelected = _selectedAnswer == letter;
        final isCorrect = letter == _correctAnswer;
        final showResult = _answerLocked;

        Color getColor() {
          if (showResult) {
            if (isSelected && !isCorrect) return IbeereDesignTokens.primaryRed;
            if (isCorrect) return IbeereDesignTokens.accentGreen;
          }
          if (isSelected) return IbeereDesignTokens.primaryPurple;
          return Colors.white;
        }

        Color getTextColor() {
          if (showResult && (isCorrect || (isSelected && !isCorrect))) return Colors.white;
          return IbeereDesignTokens.textPrimary;
        }

        return GestureDetector(
          onTap: () => _selectAnswer(letter),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: getColor(),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: showResult && isCorrect ? IbeereDesignTokens.accentGreen : 
                       showResult && isSelected ? IbeereDesignTokens.primaryRed :
                       isSelected ? IbeereDesignTokens.primaryPurple : Color(0xFFE2E8F0),
                width: 2,
              ),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: Offset(0, 2))],
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: showResult && (isCorrect || (isSelected && !isCorrect)) ? Colors.white.withOpacity(0.2) : IbeereDesignTokens.backgroundLight,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      letter.toUpperCase(),
                      style: TextStyle(
                        color: getTextColor(),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    _options[index],
                    style: TextStyle(color: getTextColor(), fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                if (showResult && isCorrect)
                  Icon(Icons.check_circle, color: Colors.white, size: 24),
                if (showResult && isSelected && !isCorrect)
                  Icon(Icons.cancel, color: Colors.white, size: 24),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildLifelines() {
    final lifelines = [
      {'icon': Icons.filter_2, 'label': '50:50'},
      {'icon': Icons.people, 'label': 'Poll'},
      {'icon': Icons.skip_next, 'label': 'Skip'},
      {'icon': Icons.refresh, 'label': 'Reset'},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: lifelines.map((lifeline) {
        return GestureDetector(
          onTap: () => _useLifeline(lifeline['label'] as String),
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: IbeereDesignTokens.primaryPurple.withOpacity(0.2), width: 2),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(lifeline['icon'] as IconData, color: IbeereDesignTokens.primaryPurple, size: 24),
                const SizedBox(height: 4),
                Text(
                  lifeline['label'] as String,
                  style: TextStyle(color: IbeereDesignTokens.textSecondary, fontSize: 10, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        );
      }).toList(),
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
