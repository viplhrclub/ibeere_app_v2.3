import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class BattleMatchingScreen extends StatefulWidget {
  const BattleMatchingScreen({super.key});

  static const String routeName = '/battle-matching';

  @override
  State<BattleMatchingScreen> createState() => _BattleMatchingScreenState();
}

class _BattleMatchingScreenState extends State<BattleMatchingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  int _opponentsFound = 1;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_opponentsFound < 3 && mounted) {
        setState(() => _opponentsFound++);
        HapticFeedback.mediumImpact();
      } else {
        timer.cancel();
        _navigateToNextScreen();
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _navigateToNextScreen() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        Navigator.pop(context, true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF7C3AED),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF7C3AED),
              const Color(0xFF6D28D9),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 16,
                left: 16,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 28),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Text(
                      '$_opponentsFound OPPONENT${_opponentsFound > 1 ? 'S' : ''} FOUND',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 80),
                    AnimatedBuilder(
                      animation: _pulseController,
                      builder: (context, child) {
                        return Container(
                          width: 300 + (_pulseController.value * 50),
                          height: 300 + (_pulseController.value * 50),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.1 - (_pulseController.value * 0.1)),
                          ),
                        );
                      },
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 48),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _PlayerCard(
                            name: 'Melissa_lin..',
                            avatar: '👧',
                            color: const Color(0xFF0F766E),
                            badge: 'x5 Wins',
                            isLeft: true,
                          ),
                          const Text(
                            'VS',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          _PlayerCard(
                            name: 'Isidore_Mban..',
                            avatar: '👨',
                            color: const Color(0xFFFFE4E1),
                            badge: 'x2 Wins',
                            isLeft: false,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlayerCard extends StatelessWidget {
  final String name;
  final String avatar;
  final Color color;
  final String badge;
  final bool isLeft;

  const _PlayerCard({
    required this.name,
    required this.avatar,
    required this.color,
    required this.badge,
    required this.isLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 120,
          height: 140,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white, width: 4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                avatar,
                style: const TextStyle(fontSize: 60),
              ),
              const SizedBox(height: 8),
              Text(
                name,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFFBD648),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.star, color: Colors.white, size: 16),
              const SizedBox(width: 4),
              Text(
                badge,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
