import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/design_tokens.dart';

class QuizZoneScreen extends StatefulWidget {
  const QuizZoneScreen({super.key});

  @override
  State<QuizZoneScreen> createState() => _QuizZoneScreenState();
}

class _QuizZoneScreenState extends State<QuizZoneScreen> {
  final List<Map<String, dynamic>> _quizzes = [
    {
      'title': 'Daily Quiz',
      'description': 'Complete 3 questions daily',
      'reward': '50 coins',
      'completed': true,
      'icon': '📅',
    },
    {
      'title': 'Speed Quiz',
      'description': 'Answer 10 questions in 5 minutes',
      'reward': '100 coins',
      'completed': false,
      'icon': '⚡',
    },
    {
      'title': 'Expert Quiz',
      'description': 'Ace all hard difficulty questions',
      'reward': '200 coins',
      'completed': false,
      'icon': '🎓',
    },
    {
      'title': 'Survival Mode',
      'description': "Don't get 3 questions wrong",
      'reward': '150 coins',
      'completed': false,
      'icon': '🏆',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.background,
      appBar: AppBar(
        backgroundColor: DesignTokens.background,
        elevation: 0,
        title: Text(
          'Quiz Zone',
          style: TextStyle(
            color: DesignTokens.primary,
            fontWeight: DesignTokens.fontWeightBold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(DesignTokens.spaceLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card
            Container(
              padding: const EdgeInsets.all(DesignTokens.spaceLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [DesignTokens.primary, Colors.blue[600]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Quiz Zone',
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeLg,
                      color: Colors.white,
                      fontWeight: DesignTokens.fontWeightBold,
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spaceSm),
                  const Text(
                    'Complete special quizzes to earn bonus coins',
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeBase,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spaceXl),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Completed',
                            style: TextStyle(
                              fontSize: DesignTokens.fontSizeSm,
                              color: Colors.white70,
                            ),
                          ),
                          Text(
                            '${_quizzes.where((q) => q['completed'] as bool).length}/${_quizzes.length}',
                            style: const TextStyle(
                              fontSize: DesignTokens.fontSizeXl,
                              color: Colors.white,
                              fontWeight: DesignTokens.fontWeightBold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Total Coins',
                            style: TextStyle(
                              fontSize: DesignTokens.fontSizeSm,
                              color: Colors.white70,
                            ),
                          ),
                          Text(
                            '500',
                            style: TextStyle(
                              fontSize: DesignTokens.fontSizeXl,
                              color: Colors.white,
                              fontWeight: DesignTokens.fontWeightBold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: DesignTokens.spaceXxl),

            // Quiz List
            Text(
              'Available Quizzes',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: DesignTokens.fontWeightBold,
              ),
            ),
            const SizedBox(height: DesignTokens.spaceMd),
            ..._quizzes.map((quiz) {
              return Padding(
                padding: const EdgeInsets.only(bottom: DesignTokens.spaceMd),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                    border: Border.all(color: Colors.grey[200] ?? Colors.grey),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(DesignTokens.spaceMd),
                    child: Row(
                      children: [
                        Text(
                          quiz['icon'] as String,
                          style: const TextStyle(fontSize: 32),
                        ),
                        const SizedBox(width: DesignTokens.spaceMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                quiz['title'] as String,
                                style: const TextStyle(
                                  fontSize: DesignTokens.fontSizeBase,
                                  fontWeight: DesignTokens.fontWeightBold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                quiz['description'] as String,
                                style: TextStyle(
                                  fontSize: DesignTokens.fontSizeSm,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: DesignTokens.spaceSm),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: DesignTokens.spaceSm,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.orange[100],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  '🪙 ${quiz['reward']}',
                                  style: TextStyle(
                                    fontSize: DesignTokens.fontSizeSm,
                                    color: Colors.orange[700],
                                    fontWeight: DesignTokens.fontWeightBold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (quiz['completed'] as bool)
                          const Icon(Icons.check_circle, color: Colors.green, size: 24)
                        else
                          Icon(Icons.arrow_forward_rounded, color: Colors.grey[400]),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}


