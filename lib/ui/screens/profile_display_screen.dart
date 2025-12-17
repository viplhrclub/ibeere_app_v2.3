import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';
import 'package:flutterquiz/ui/widgets/ibeere_v2_buttons.dart';

class ProfileDisplayScreen extends StatelessWidget {
  const ProfileDisplayScreen({super.key});

  static const String routeName = '/profile-display';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IbeereDesignTokens.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [IbeereDesignTokens.primaryPurple, IbeereDesignTokens.primaryPink],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      IconButton(
                        icon: Icon(Icons.settings, color: Colors.white),
                        onPressed: () => Navigator.pushNamed(context, '/settings'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 12, offset: Offset(0, 6))],
                    ),
                    child: Icon(Icons.person, size: 50, color: IbeereDesignTokens.primaryPurple),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'John Doe',
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'john.doe@example.com',
                    style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 14),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatBadge(Icons.quiz, '156', 'Quizzes'),
                      _buildStatBadge(Icons.emoji_events, '72%', 'Win Rate'),
                      _buildStatBadge(Icons.leaderboard, '#24', 'Rank'),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Statistics', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: IbeereDesignTokens.textPrimary)),
                    const SizedBox(height: 16),
                    _buildStatCard(Icons.stars, 'Total Coins', '3,580 Kauris', IbeereDesignTokens.accentYellow),
                    const SizedBox(height: 12),
                    _buildStatCard(Icons.emoji_events, 'Badges Earned', '12 / 20 Badges', IbeereDesignTokens.primaryPurple),
                    const SizedBox(height: 12),
                    _buildStatCard(Icons.check_circle, 'Correct Answers', '892 / 1,248', IbeereDesignTokens.accentGreen),
                    const SizedBox(height: 12),
                    _buildStatCard(Icons.bolt, 'Win Streak', '5 Games', IbeereDesignTokens.primaryPink),
                    const SizedBox(height: 24),
                    Text('Quick Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: IbeereDesignTokens.textPrimary)),
                    const SizedBox(height: 16),
                    IbeereButton(
                      text: 'Edit Profile',
                      onPressed: () => Navigator.pushNamed(context, '/edit-profile'),
                      icon: Icons.edit,
                      variant: IbeereButtonVariant.outlined,
                    ),
                    const SizedBox(height: 12),
                    IbeereButton(
                      text: 'View Badges',
                      onPressed: () => Navigator.pushNamed(context, '/badges-collection'),
                      icon: Icons.workspace_premium,
                      variant: IbeereButtonVariant.outlined,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatBadge(IconData icon, String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(label, style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 11)),
        ],
      ),
    );
  }

  Widget _buildStatCard(IconData icon, String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(color: IbeereDesignTokens.textSecondary, fontSize: 12)),
                const SizedBox(height: 4),
                Text(value, style: TextStyle(color: IbeereDesignTokens.textPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: IbeereDesignTokens.textSecondary),
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
