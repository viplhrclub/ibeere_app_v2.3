import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';

class QuizNumberPuzzleScreen extends StatefulWidget {
  const QuizNumberPuzzleScreen({super.key});

  static const String routeName = '/quiz-number-puzzle';

  @override
  State<QuizNumberPuzzleScreen> createState() => _QuizNumberPuzzleScreenState();
}

class _QuizNumberPuzzleScreenState extends State<QuizNumberPuzzleScreen> {
  int _timeRemaining = 20;
  int _userCorrects = 8;
  int _opponentCorrects = 2;
  final int _totalQuestions = 15;
  int _userWins = 5;
  int _opponentWins = 2;
  Timer? _timer;

  final List<int> _numbers = [1, 5, 3, 11, 6, 2, 10, 8, 4, 15, 7, 9, 13, 14, 12];

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
        _showResultsDialog();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _selectNumber(int number) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Selected: $number'),
        duration: Duration(milliseconds: 500),
      ),
    );
  }

  void _showResultsDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('Time\'s Up!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Your Score: $_userCorrects/$_totalQuestions'),
            Text('Opponent: $_opponentCorrects/$_totalQuestions'),
            SizedBox(height: 16),
            Text(
              _userCorrects > _opponentCorrects ? 'You Win! 🎉' : 'You Lose',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: _userCorrects > _opponentCorrects
                    ? IbeereDesignTokens.accentGreen
                    : IbeereDesignTokens.primaryRed,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/quiz-results');
            },
            child: Text('View Results'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IbeereDesignTokens.backgroundLight,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(top: 40, right: -30, child: _DecorativeCircle(color: Color(0xFFEC4899).withOpacity(0.1), size: 100)),
            Positioned(bottom: 100, left: -40, child: _DecorativeCircle(color: Color(0xFF8B5CF6).withOpacity(0.1), size: 120)),
            Positioned(top: 200, left: -20, child: _DecorativeCircle(color: Color(0xFF10B981).withOpacity(0.1), size: 60)),
            Column(
              children: [
                _buildTopBar(),
                const SizedBox(height: 20),
                _buildScoreBar(),
                const SizedBox(height: 32),
                Expanded(
                  child: _buildNumberGrid(),
                ),
                _buildBottomPlayers(),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: IbeereDesignTokens.primaryPurple,
        child: Icon(Icons.grid_view, color: Colors.white),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Color(0xFF5B6B8C),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.grid_view, color: Colors.white, size: 24),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Color(0xFF5B6B8C),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Center(
                child: Text(
                  '$_timeRemaining',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Color(0xFF5B6B8C),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.access_time, color: Colors.white, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: Offset(0, 4))],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: IbeereDesignTokens.accentCyan,
            child: Icon(Icons.person, color: Colors.white, size: 28),
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Corrects ',
                      style: TextStyle(
                        color: IbeereDesignTokens.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '$_userCorrects/$_totalQuestions',
                      style: TextStyle(
                        color: Color(0xFF5B6B8C),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ' | Corrects ',
                      style: TextStyle(
                        color: IbeereDesignTokens.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '$_opponentCorrects/$_totalQuestions',
                      style: TextStyle(
                        color: Color(0xFF5B6B8C),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          CircleAvatar(
            radius: 28,
            backgroundColor: Color(0xFFEC9696),
            child: Icon(Icons.person, color: Colors.white, size: 28),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberGrid() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFFD5DCE8),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Stack(
        children: [
          Positioned(top: 20, right: 30, child: _DecorativeSquare(color: Color(0xFF8B5CF6).withOpacity(0.2), size: 20)),
          Positioned(bottom: 40, left: 20, child: _DecorativeCircle(color: Color(0xFF10B981).withOpacity(0.2), size: 30)),
          Positioned(top: 100, right: 60, child: _DecorativeSquare(color: Color(0xFF5B6B8C).withOpacity(0.2), size: 15)),
          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
            ),
            itemCount: _numbers.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _selectNumber(_numbers[index]),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      '${_numbers[index]}',
                      style: TextStyle(
                        color: Color(0xFF5B6B8C),
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomPlayers() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Color(0xFFE5E7EB),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(Icons.person, size: 40, color: Color(0xFF6B7280)),
                  ),
                  Positioned(
                    top: -10,
                    left: -10,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: IbeereDesignTokens.accentYellow,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.emoji_events, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Color(0xFF5B6B8C),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.star, color: IbeereDesignTokens.accentYellow, size: 16),
                    Text(
                      'x$_userWins Wins',
                      style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Melissa_lin...',
                style: TextStyle(color: IbeereDesignTokens.textSecondary, fontSize: 12),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                'VS',
                style: TextStyle(
                  color: IbeereDesignTokens.textPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 40,
                height: 3,
                decoration: BoxDecoration(
                  color: IbeereDesignTokens.textSecondary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Color(0xFFFED7D7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(Icons.person, size: 40, color: Color(0xFFE53E3E)),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Color(0xFF5B6B8C),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.star, color: IbeereDesignTokens.accentYellow, size: 16),
                    Text(
                      'x$_opponentWins Wins',
                      style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Isidore_Mban...',
                style: TextStyle(color: IbeereDesignTokens.textSecondary, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DecorativeCircle extends StatelessWidget {
  final Color color;
  final double size;
  const _DecorativeCircle({required this.color, required this.size});
  @override
  Widget build(BuildContext context) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      );
}

class _DecorativeSquare extends StatelessWidget {
  final Color color;
  final double size;
  const _DecorativeSquare({required this.color, required this.size});
  @override
  Widget build(BuildContext context) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
        ),
      );
}