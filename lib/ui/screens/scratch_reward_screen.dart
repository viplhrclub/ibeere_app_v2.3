import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';
import 'package:flutterquiz/ui/widgets/ibeere_v2_buttons.dart';

class ScratchRewardScreen extends StatefulWidget {
  const ScratchRewardScreen({super.key});

  static const String routeName = '/scratch-reward';

  @override
  State<ScratchRewardScreen> createState() => _ScratchRewardScreenState();
}

class _ScratchRewardScreenState extends State<ScratchRewardScreen> {
  bool _isScratched = false;
  final int _rewardAmount = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IbeereDesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: IbeereDesignTokens.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Scratch & Win', style: TextStyle(color: IbeereDesignTokens.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Scratch to Reveal',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: IbeereDesignTokens.textPrimary),
              ),
              const SizedBox(height: 8),
              Text(
                'Your Daily Reward',
                style: TextStyle(fontSize: 16, color: IbeereDesignTokens.textSecondary),
              ),
              const SizedBox(height: 40),
              GestureDetector(
                onTap: () => setState(() => _isScratched = true),
                child: Container(
                  width: 280,
                  height: 320,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: _isScratched
                          ? [IbeereDesignTokens.accentYellow, Color(0xFFF59E0B)]
                          : [IbeereDesignTokens.primaryPurple, IbeereDesignTokens.primaryPink],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [BoxShadow(color: IbeereDesignTokens.primaryPurple.withOpacity(0.3), blurRadius: 20, offset: Offset(0, 10))],
                  ),
                  child: _isScratched
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.stars, color: Colors.white, size: 80),
                            const SizedBox(height: 24),
                            Text(
                              'You Won!',
                              style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '$_rewardAmount Kauris',
                              style: TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      : Stack(
                          children: [
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.touch_app, color: Colors.white, size: 48),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Tap to Scratch',
                                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            ...List.generate(8, (i) => Positioned(
                              top: Random().nextDouble() * 280,
                              left: Random().nextDouble() * 240,
                              child: Icon(Icons.stars, color: Colors.white.withOpacity(0.2), size: 24),
                            )),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 40),
              if (_isScratched)
                IbeereButton(
                  text: 'Claim Reward',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Claimed $_rewardAmount Kauris!')),
                    );
                    Navigator.pop(context);
                  },
                  icon: Icons.card_giftcard,
                ),
            ],
          ),
        ),
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
