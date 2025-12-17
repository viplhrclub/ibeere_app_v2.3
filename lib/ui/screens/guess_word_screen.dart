import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';

class GuessWordScreen extends StatefulWidget {
  const GuessWordScreen({super.key});

  static const String routeName = '/guess-word';

  @override
  State<GuessWordScreen> createState() => _GuessWordScreenState();
}

class _GuessWordScreenState extends State<GuessWordScreen> {
  int _timeRemaining = 20;
  Timer? _timer;
  String _category = 'Capitals';
  String _answer = 'MORNING';
  List<String> _guessedLetters = ['M', 'O', 'R', 'N', '', 'N', 'G'];
  Map<String, int> _lifelines = {
    'clock': 2,
    'star': 4,
    'edit': 3,
    'plus': 6,
  };

  final List<String> _keyboardRows = [
    'QWERTYUIOP',
    'ASDFGHJKL',
    'ZXCVBNM',
  ];

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
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _selectLetter(String letter) {
    final emptyIndex = _guessedLetters.indexOf('');
    if (emptyIndex != -1) {
      setState(() {
        _guessedLetters[emptyIndex] = letter;
      });
    }
  }

  void _deleteLetter() {
    for (int i = _guessedLetters.length - 1; i >= 0; i--) {
      if (_guessedLetters[i].isNotEmpty) {
        setState(() {
          _guessedLetters[i] = '';
        });
        break;
      }
    }
  }

  void _submit() {
    final guessedWord = _guessedLetters.join('');
    if (guessedWord == _answer) {
      _showSuccessDialog();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Incorrect! Try again'), backgroundColor: IbeereDesignTokens.primaryRed),
      );
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Correct! 🎉'),
        content: Text('You guessed the word correctly!'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text('Continue'),
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
            Positioned(top: 60, right: -30, child: _DecorativeCircle(color: Color(0xFFEC4899).withOpacity(0.1), size: 100)),
            Positioned(bottom: 200, left: -40, child: _DecorativeTriangle(color: Color(0xFF10B981).withOpacity(0.1), size: 80)),
            Positioned(top: 300, left: 20, child: _DecorativeCircle(color: Color(0xFF06B6D4).withOpacity(0.1), size: 50)),
            Positioned(bottom: 100, right: 30, child: _DecorativeSquare(color: Color(0xFFFBBF24).withOpacity(0.1), size: 40)),
            Column(
              children: [
                _buildTopBar(),
                const SizedBox(height: 24),
                Text(
                  'CATEGORIES',
                  style: TextStyle(
                    color: IbeereDesignTokens.textTertiary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 3,
                      height: 20,
                      decoration: BoxDecoration(
                        color: IbeereDesignTokens.primaryRed,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _category,
                      style: TextStyle(
                        color: IbeereDesignTokens.textPrimary,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                _buildAnswerBoxes(),
                const SizedBox(height: 24),
                _buildLifelineButtons(),
                const SizedBox(height: 32),
                Expanded(child: _buildKeyboard()),
                const SizedBox(height: 16),
                _buildSubmitButton(),
                const SizedBox(height: 24),
              ],
            ),
          ],
        ),
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
            child: Icon(Icons.share, color: Colors.white, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerBoxes() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Color(0xFF3D4F6D),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 15, offset: Offset(0, 4))],
      ),
      child: Stack(
        children: [
          Positioned(top: 10, left: 20, child: _DecorativeTriangle(color: Color(0xFFEF4444).withOpacity(0.3), size: 30)),
          Positioned(bottom: 10, right: 30, child: _DecorativeCircle(color: Color(0xFF8B5CF6).withOpacity(0.3), size: 40)),
          Positioned(top: 40, right: 50, child: _DecorativeSquare(color: Color(0xFFFBBF24).withOpacity(0.3), size: 25)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _guessedLetters.length,
              (index) => Container(
                width: 48,
                height: 60,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: _guessedLetters[index].isEmpty ? Color(0xFF5B6B8C) : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: _guessedLetters[index].isNotEmpty
                      ? [BoxShadow(color: Colors.white.withOpacity(0.3), blurRadius: 8, offset: Offset(0, 2))]
                      : null,
                ),
                child: Center(
                  child: Text(
                    _guessedLetters[index],
                    style: TextStyle(
                      color: _guessedLetters[index].isEmpty ? Color(0xFF8897AE) : Color(0xFF5B6B8C),
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLifelineButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLifelineButton(Icons.access_time, 'clock', Color(0xFF8B5CF6)),
          const SizedBox(width: 12),
          _buildLifelineButton(Icons.star, 'star', Color(0xFF10B981)),
          const SizedBox(width: 12),
          _buildLifelineButton(Icons.edit, 'edit', Color(0xFF3B82F6)),
          const SizedBox(width: 12),
          _buildLifelineButton(Icons.add, 'plus', Color(0xFFEC4899)),
        ],
      ),
    );
  }

  Widget _buildLifelineButton(IconData icon, String type, Color color) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: color.withOpacity(0.3), blurRadius: 10, offset: Offset(0, 4))],
      ),
      child: Stack(
        children: [
          Center(child: Icon(icon, color: Colors.white, size: 28)),
          Positioned(
            top: 4,
            right: 4,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Text(
                '${_lifelines[type]}',
                style: TextStyle(
                  color: color,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeyboard() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildKeyButton('Hint', isSpecial: true, icon: Icons.refresh),
            const SizedBox(width: 40),
            _buildKeyButton('Back', isSpecial: true, icon: Icons.refresh),
          ],
        ),
        const SizedBox(height: 20),
        ..._keyboardRows.map((row) {
          return Padding(
            padding: EdgeInsets.only(bottom: 8, left: _keyboardRows.indexOf(row) == 1 ? 20 : 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_keyboardRows.indexOf(row) == 2)
                  _buildKeyButton('↑', isControl: true),
                ...row.split('').map((letter) => _buildKeyButton(letter)),
                if (_keyboardRows.indexOf(row) == 2)
                  _buildKeyButton('×', isControl: true, onTap: _deleteLetter),
              ],
            ),
          );
        }).toList(),
        const SizedBox(height: 8),
        _buildKeyButton('Space', isWide: true),
      ],
    );
  }

  Widget _buildKeyButton(String label, {bool isSpecial = false, bool isControl = false, bool isWide = false, IconData? icon, VoidCallback? onTap}) {
    final isFirstLetter = label == 'Q';
    
    return GestureDetector(
      onTap: onTap ?? () {
        if (!isSpecial && !isControl && !isWide) {
          _selectLetter(label);
        }
      },
      child: Container(
        width: isWide ? 200 : (isSpecial ? 80 : (isControl ? 44 : 32)),
        height: isSpecial ? 36 : 44,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: isFirstLetter ? IbeereDesignTokens.accentGreen : (isSpecial ? Colors.transparent : Color(0xFFE5E7EB)),
          border: isSpecial ? Border.all(color: IbeereDesignTokens.textTertiary, width: 1) : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: icon != null
              ? Icon(icon, size: 16, color: IbeereDesignTokens.textSecondary)
              : Text(
                  label,
                  style: TextStyle(
                    color: isFirstLetter ? Colors.white : (isSpecial ? IbeereDesignTokens.textSecondary : Color(0xFF5B6B8C)),
                    fontSize: isWide ? 14 : (isSpecial ? 13 : 18),
                    fontWeight: isFirstLetter ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [IbeereDesignTokens.primaryRed, Color(0xFFDC2626)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [BoxShadow(color: IbeereDesignTokens.primaryRed.withOpacity(0.3), blurRadius: 15, offset: Offset(0, 6))],
      ),
      child: Stack(
        children: [
          Positioned(top: 8, right: 40, child: _DecorativeSquare(color: Colors.white.withOpacity(0.2), size: 20)),
          Positioned(bottom: 10, left: 50, child: _DecorativeCircle(color: Colors.white.withOpacity(0.15), size: 25)),
          Positioned(top: 10, left: 100, child: _DecorativeTriangle(color: Colors.white.withOpacity(0.1), size: 15)),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _submit,
              borderRadius: BorderRadius.circular(28),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.play_arrow, color: Colors.white, size: 28),
                    const SizedBox(width: 8),
                    Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
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