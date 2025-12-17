import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';

class BattleCountdownScreen extends StatefulWidget {
  const BattleCountdownScreen({super.key});

  static const String routeName = '/battle-countdown';

  @override
  State<BattleCountdownScreen> createState() => _BattleCountdownScreenState();
}

class _BattleCountdownScreenState extends State<BattleCountdownScreen> with TickerProviderStateMixin {
  int _countdown = 3;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
    
    _startCountdown();
  }

  void _startCountdown() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        setState(() => _countdown--);
        _scaleController.forward(from: 0);
      } else {
        timer.cancel();
        Navigator.pushReplacementNamed(context, '/quiz-playing');
      }
    });
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E3A8A),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(top: -80, right: -80, child: _DecorativeCircle(color: Colors.white.withOpacity(0.05), size: 200)),
            Positioned(bottom: -100, left: -100, child: _DecorativeCircle(color: Colors.white.withOpacity(0.05), size: 240)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildAvatar(Icons.person, IbeereDesignTokens.primaryPurple, 'You'),
                    const SizedBox(width: 32),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: IbeereDesignTokens.accentYellow,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.bolt, color: Colors.white, size: 32),
                    ),
                    const SizedBox(width: 32),
                    _buildAvatar(Icons.person, IbeereDesignTokens.primaryPink, 'Opponent'),
                  ],
                ),
                const SizedBox(height: 60),
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    child: Center(
                      child: Text(
                        _countdown > 0 ? '$_countdown' : 'GO!',
                        style: TextStyle(color: Colors.white, fontSize: 64, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  'Prepare for the Duel',
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Battle starts in $_countdown seconds',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(IconData icon, Color color, String label) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: color.withOpacity(0.3), blurRadius: 15, offset: Offset(0, 8))],
          ),
          child: Icon(icon, size: 40, color: color),
        ),
        const SizedBox(height: 12),
        Text(label, style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
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
