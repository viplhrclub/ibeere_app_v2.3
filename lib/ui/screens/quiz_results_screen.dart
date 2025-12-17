import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';
import 'package:flutterquiz/ui/widgets/ibeere_v2_buttons.dart';

class QuizResultsScreen extends StatelessWidget {
  const QuizResultsScreen({super.key});

  static const String routeName = '/quiz-results';

  @override
  Widget build(BuildContext context) {
    final bool isWinner = true;
    final int userScore = 280;
    final int opponentScore = 190;
    final int correctAnswers = 7;
    final int totalQuestions = 10;
    final int coinsEarned = 50;
    final String accuracy = '70%';

    return Scaffold(
      backgroundColor: IbeereDesignTokens.backgroundLight,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(top: -50, right: -50, child: _DecorativeCircle(color: isWinner ? IbeereDesignTokens.accentGreen.withOpacity(0.1) : IbeereDesignTokens.primaryRed.withOpacity(0.1), size: 200)),
            Positioned(bottom: -60, left: -60, child: _DecorativeCircle(color: IbeereDesignTokens.primaryPurple.withOpacity(0.1), size: 180)),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.close, color: IbeereDesignTokens.textPrimary),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Text('Quiz Results', style: TextStyle(color: IbeereDesignTokens.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: isWinner ? IbeereDesignTokens.accentGreen : IbeereDesignTokens.primaryRed,
                            shape: BoxShape.circle,
                            boxShadow: [BoxShadow(color: (isWinner ? IbeereDesignTokens.accentGreen : IbeereDesignTokens.primaryRed).withOpacity(0.3), blurRadius: 20, offset: Offset(0, 10))],
                          ),
                          child: Icon(
                            isWinner ? Icons.emoji_events : Icons.sentiment_dissatisfied,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          isWinner ? 'Congratulations!' : 'Better Luck Next Time!',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: IbeereDesignTokens.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          isWinner ? 'You Won the Quiz!' : 'You Lost the Quiz',
                          style: TextStyle(fontSize: 16, color: IbeereDesignTokens.textSecondary),
                        ),
                        const SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildScoreCard('Your Score', userScore, IbeereDesignTokens.primaryPurple, true),
                            const SizedBox(width: 16),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: IbeereDesignTokens.accentYellow.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Text('VS', style: TextStyle(color: IbeereDesignTokens.accentYellow, fontSize: 16, fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(width: 16),
                            _buildScoreCard('Opponent', opponentScore, IbeereDesignTokens.primaryPink, false),
                          ],
                        ),
                        const SizedBox(height: 32),
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: Offset(0, 4))],
                          ),
                          child: Column(
                            children: [
                              Text('Performance', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: IbeereDesignTokens.textPrimary)),
                              const SizedBox(height: 20),
                              _buildStatRow(Icons.check_circle, 'Correct Answers', '$correctAnswers/$totalQuestions', IbeereDesignTokens.accentGreen),
                              const SizedBox(height: 16),
                              _buildStatRow(Icons.timeline, 'Accuracy', accuracy, IbeereDesignTokens.primaryPurple),
                              const SizedBox(height: 16),
                              _buildStatRow(Icons.stars, 'Coins Earned', '+$coinsEarned', IbeereDesignTokens.accentYellow),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () => Navigator.pushNamed(context, '/review-quiz'),
                                icon: Icon(Icons.replay, size: 20),
                                label: Text('Review'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: IbeereDesignTokens.primaryPurple,
                                  side: BorderSide(color: IbeereDesignTokens.primaryPurple, width: 2),
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.share, size: 20),
                                label: Text('Share'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: IbeereDesignTokens.primaryPurple,
                                  side: BorderSide(color: IbeereDesignTokens.primaryPurple, width: 2),
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        IbeereButton(
                          text: 'Play Again',
                          onPressed: () => Navigator.pop(context),
                          icon: Icons.refresh,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreCard(String label, int score, Color color, bool isUser) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3), width: 2),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.person, color: color, size: 28),
          ),
          const SizedBox(height: 12),
          Text(label, style: TextStyle(color: IbeereDesignTokens.textSecondary, fontSize: 12)),
          const SizedBox(height: 4),
          Text('$score', style: TextStyle(color: color, fontSize: 28, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildStatRow(IconData icon, String label, String value, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(label, style: TextStyle(color: IbeereDesignTokens.textSecondary, fontSize: 14)),
        ),
        Text(value, style: TextStyle(color: IbeereDesignTokens.textPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
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
