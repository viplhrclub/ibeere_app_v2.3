import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';

class StatisticsScreenV2 extends StatelessWidget {
  const StatisticsScreenV2({super.key});

  static const String routeName = '/statistics-v2';

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
        title: Text('Statistics', style: TextStyle(color: IbeereDesignTokens.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
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
                  Text('Overall Performance', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildOverallStat('156', 'Games Played'),
                      Container(width: 1, height: 40, color: Colors.white.withOpacity(0.3)),
                      _buildOverallStat('72%', 'Win Rate'),
                      Container(width: 1, height: 40, color: Colors.white.withOpacity(0.3)),
                      _buildOverallStat('#24', 'Global Rank'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text('Category Performance', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: IbeereDesignTokens.textPrimary)),
            const SizedBox(height: 16),
            _buildCategoryStats('Science', 45, 62, IbeereDesignTokens.primaryPurple),
            const SizedBox(height: 12),
            _buildCategoryStats('History', 32, 48, IbeereDesignTokens.primaryPink),
            const SizedBox(height: 12),
            _buildCategoryStats('Geography', 28, 35, IbeereDesignTokens.accentGreen),
            const SizedBox(height: 12),
            _buildCategoryStats('Mathematics', 51, 60, IbeereDesignTokens.accentYellow),
            const SizedBox(height: 24),
            Text('Recent Activity', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: IbeereDesignTokens.textPrimary)),
            const SizedBox(height: 16),
            _buildActivityCard('Won Quiz Battle', 'Science Category', Icons.emoji_events, IbeereDesignTokens.accentGreen, '2 hours ago'),
            const SizedBox(height: 12),
            _buildActivityCard('Earned Badge', 'Quiz Master Achievement', Icons.workspace_premium, IbeereDesignTokens.accentYellow, '5 hours ago'),
            const SizedBox(height: 12),
            _buildActivityCard('Lost Battle', 'History Category', Icons.close_fullscreen, IbeereDesignTokens.primaryRed, '1 day ago'),
          ],
        ),
      ),
    );
  }

  Widget _buildOverallStat(String value, String label) {
    return Column(
      children: [
        Text(value, style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 11)),
      ],
    );
  }

  Widget _buildCategoryStats(String category, int correct, int total, Color color) {
    final percentage = (correct / total * 100).round();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(category, style: TextStyle(color: IbeereDesignTokens.textPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
              Text('$correct/$total', style: TextStyle(color: IbeereDesignTokens.textSecondary, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: correct / total,
              minHeight: 8,
              backgroundColor: IbeereDesignTokens.backgroundLight,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
          const SizedBox(height: 8),
          Text('$percentage% Accuracy', style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildActivityCard(String title, String subtitle, IconData icon, Color color, String time) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: IbeereDesignTokens.textPrimary, fontSize: 14, fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(subtitle, style: TextStyle(color: IbeereDesignTokens.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          Text(time, style: TextStyle(color: IbeereDesignTokens.textTertiary, fontSize: 11)),
        ],
      ),
    );
  }

  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(color: IbeereDesignTokens.textSecondary, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 0.5),
      ),
    );
  }
}
