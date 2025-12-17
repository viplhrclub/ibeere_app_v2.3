import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';
import 'dart:async';

class MemoryFlipCardGameScreen extends StatefulWidget {
  const MemoryFlipCardGameScreen({super.key});

  static const String routeName = '/memory-flip-card';

  @override
  State<MemoryFlipCardGameScreen> createState() => _MemoryFlipCardGameScreenState();
}

class _MemoryFlipCardGameScreenState extends State<MemoryFlipCardGameScreen> {
  List<String> _cardValues = [];
  List<bool> _cardFlips = [];
  List<bool> _cardMatched = [];
  int? _firstCardIndex;
  int? _secondCardIndex;
  int _moves = 0;
  int _matches = 0;
  int _timeLeft = 60;
  Timer? _timer;

  final List<String> _emojis = ['🎮', '🎯', '🎨', '🎭', '🎪', '🎸', '🎺', '🎻'];

  @override
  void initState() {
    super.initState();
    _initializeGame();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _initializeGame() {
    _cardValues = [..._emojis, ..._emojis]..shuffle();
    _cardFlips = List.filled(16, false);
    _cardMatched = List.filled(16, false);
    _firstCardIndex = null;
    _secondCardIndex = null;
    _moves = 0;
    _matches = 0;
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() => _timeLeft--);
      } else {
        timer.cancel();
      }
    });
  }

  void _flipCard(int index) {
    if (_cardMatched[index] || _cardFlips[index] || _secondCardIndex != null) {
      return;
    }

    HapticFeedback.mediumImpact();
    setState(() {
      _cardFlips[index] = true;

      if (_firstCardIndex == null) {
        _firstCardIndex = index;
      } else {
        _secondCardIndex = index;
        _moves++;

        if (_cardValues[_firstCardIndex!] == _cardValues[_secondCardIndex!]) {
          _cardMatched[_firstCardIndex!] = true;
          _cardMatched[_secondCardIndex!] = true;
          _matches++;
          _firstCardIndex = null;
          _secondCardIndex = null;
          HapticFeedback.heavyImpact();

          if (_matches == 8) {
            _timer?.cancel();
          }
        } else {
          Future.delayed(const Duration(milliseconds: 1000), () {
            setState(() {
              _cardFlips[_firstCardIndex!] = false;
              _cardFlips[_secondCardIndex!] = false;
              _firstCardIndex = null;
              _secondCardIndex = null;
            });
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: IbeereDesignTokens.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Memory Game',
          style: TextStyle(
            color: IbeereDesignTokens.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _InfoCard(
                    label: 'Moves',
                    value: _moves.toString(),
                    icon: Icons.touch_app,
                    color: const Color(0xFF6366F1),
                  ),
                  _InfoCard(
                    label: 'Matches',
                    value: '$_matches/8',
                    icon: Icons.check_circle,
                    color: const Color(0xFF10B981),
                  ),
                  _InfoCard(
                    label: 'Time',
                    value: '$_timeLeft s',
                    icon: Icons.timer,
                    color: const Color(0xFFEC4899),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                  ),
                  itemCount: 16,
                  itemBuilder: (context, index) {
                    final isFlipped = _cardFlips[index];
                    final isMatched = _cardMatched[index];

                    return GestureDetector(
                      onTap: () => _flipCard(index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          color: isMatched
                              ? const Color(0xFF10B981).withOpacity(0.3)
                              : isFlipped
                                  ? Colors.white
                                  : IbeereDesignTokens.primaryPurple,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: isFlipped || isMatched
                              ? Text(
                                  _cardValues[index],
                                  style: const TextStyle(fontSize: 32),
                                )
                              : const Icon(
                                  Icons.question_mark,
                                  color: Colors.white,
                                  size: 32,
                                ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              if (_matches == 8)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: IbeereDesignTokens.primaryGradient,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        '🎉 You Won!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Moves: $_moves | Time: ${60 - _timeLeft}s',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              if (_matches == 8) const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _timer?.cancel();
                    setState(() {
                      _timeLeft = 60;
                      _initializeGame();
                      _startTimer();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: IbeereDesignTokens.primaryPurple,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'New Game',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
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
}

class _InfoCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _InfoCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
