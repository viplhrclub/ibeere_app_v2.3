import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';
import 'package:flutterquiz/ui/widgets/ibeere_v2_buttons.dart';

class BattleRoomScreen extends StatelessWidget {
  const BattleRoomScreen({super.key});

  static const String routeName = '/battle-room';

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
        title: Text('Battle Room', style: TextStyle(color: IbeereDesignTokens.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      body: Stack(
        children: [
          Positioned(top: -40, right: -40, child: _DecorativeCircle(color: IbeereDesignTokens.primaryPurple.withOpacity(0.05), size: 160)),
          Positioned(bottom: -50, left: -50, child: _DecorativeCircle(color: IbeereDesignTokens.primaryPink.withOpacity(0.05), size: 180)),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  'Choose Battle Mode',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: IbeereDesignTokens.textPrimary),
                ),
                const SizedBox(height: 8),
                Text(
                  'Compete with others in real-time',
                  style: TextStyle(fontSize: 14, color: IbeereDesignTokens.textSecondary),
                ),
                const SizedBox(height: 40),
                _buildBattleMode(
                  context,
                  'One vs One Battle',
                  'Challenge a single opponent',
                  Icons.people,
                  [IbeereDesignTokens.primaryPurple, Color(0xFF8B5CF6)],
                  '5 Kauris',
                ),
                const SizedBox(height: 16),
                _buildBattleMode(
                  context,
                  'Group Battle',
                  'Compete with multiple players',
                  Icons.groups,
                  [IbeereDesignTokens.primaryPink, Color(0xFFF472B6)],
                  '5 Kauris',
                ),
                const SizedBox(height: 16),
                _buildBattleMode(
                  context,
                  'Random Battle',
                  'Match with random opponent',
                  Icons.shuffle,
                  [IbeereDesignTokens.accentCyan, Color(0xFF22D3EE)],
                  '5 Kauris',
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: IbeereDesignTokens.accentYellow.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: IbeereDesignTokens.accentYellow, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Win battles to earn coins and climb the leaderboard!',
                          style: TextStyle(color: IbeereDesignTokens.textSecondary, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBattleMode(BuildContext context, String title, String subtitle, IconData icon, List<Color> gradient, String entryFee) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/battle-countdown'),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: gradient[0].withOpacity(0.3), blurRadius: 12, offset: Offset(0, 6))],
        ),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 32, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 13)),
                ],
              ),
            ),
            Column(
              children: [
                Icon(Icons.monetization_on, color: Colors.white, size: 20),
                const SizedBox(height: 4),
                Text(entryFee, style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
              ],
            ),
          ],
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
