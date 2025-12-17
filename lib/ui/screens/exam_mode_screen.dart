import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';
import 'package:flutterquiz/ui/widgets/ibeere_v2_buttons.dart';

class ExamModeScreen extends StatelessWidget {
  const ExamModeScreen({super.key});

  static const String routeName = '/exam-mode';

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
        title: Text('Exam Mode', style: TextStyle(color: IbeereDesignTokens.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      body: Stack(
        children: [
          Positioned(top: -40, right: -40, child: _DecorativeCircle(color: IbeereDesignTokens.primaryPurple.withOpacity(0.05), size: 160)),
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [IbeereDesignTokens.primaryRed, Color(0xFFF87171)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(color: IbeereDesignTokens.primaryRed.withOpacity(0.3), blurRadius: 15, offset: Offset(0, 8))],
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.school, color: Colors.white, size: 56),
                      const SizedBox(height: 16),
                      Text('Science Exam', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text('30 Questions • 30 Minutes', style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 14)),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Text('Exam Rules', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: IbeereDesignTokens.textPrimary)),
                const SizedBox(height: 16),
                _buildRuleCard(Icons.timer, 'Time Limit', '30 minutes to complete all questions'),
                const SizedBox(height: 12),
                _buildRuleCard(Icons.help_outline, 'No Lifelines', 'Lifelines are not available in exam mode'),
                const SizedBox(height: 12),
                _buildRuleCard(Icons.block, 'No Review', 'Cannot review answers during exam'),
                const SizedBox(height: 12),
                _buildRuleCard(Icons.warning_amber, 'One Attempt', 'You can only attempt this exam once'),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: IbeereDesignTokens.accentYellow.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: IbeereDesignTokens.accentYellow.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.stars, color: IbeereDesignTokens.accentYellow, size: 32),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Entry Fee', style: TextStyle(color: IbeereDesignTokens.textSecondary, fontSize: 12)),
                            const SizedBox(height: 4),
                            Text('10 Kauris', style: TextStyle(color: IbeereDesignTokens.textPrimary, fontSize: 20, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                IbeereButton(
                  text: 'Start Exam',
                  onPressed: () => Navigator.pushNamed(context, '/battle-countdown'),
                  icon: Icons.play_arrow,
                ),
                const SizedBox(height: 16),
                IbeereButton(
                  text: 'Cancel',
                  onPressed: () => Navigator.pop(context),
                  variant: IbeereButtonVariant.outlined,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRuleCard(IconData icon, String title, String description) {
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
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: IbeereDesignTokens.primaryPurple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: IbeereDesignTokens.primaryPurple, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: IbeereDesignTokens.textPrimary, fontSize: 14, fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(description, style: TextStyle(color: IbeereDesignTokens.textSecondary, fontSize: 12)),
              ],
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
