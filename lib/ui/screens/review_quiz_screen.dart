import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';
import 'package:flutterquiz/ui/widgets/ibeere_v2_buttons.dart';

class ReviewQuizScreen extends StatelessWidget {
  const ReviewQuizScreen({super.key});

  static const String routeName = '/review-quiz';

  @override
  Widget build(BuildContext context) {
    final questions = [
      {
        'question': 'What is the powerhouse of the cell?',
        'options': ['Mitochondria', 'Nucleus', 'Ribosome', 'Endoplasmic Reticulum'],
        'correct': 0,
        'selected': 0,
        'isCorrect': true,
      },
      {
        'question': 'What is the capital of France?',
        'options': ['London', 'Berlin', 'Paris', 'Madrid'],
        'correct': 2,
        'selected': 2,
        'isCorrect': true,
      },
      {
        'question': 'What is 2 + 2?',
        'options': ['3', '4', '5', '6'],
        'correct': 1,
        'selected': 2,
        'isCorrect': false,
      },
      {
        'question': 'Who painted the Mona Lisa?',
        'options': ['Van Gogh', 'Da Vinci', 'Picasso', 'Monet'],
        'correct': 1,
        'selected': 1,
        'isCorrect': true,
      },
      {
        'question': 'What is the largest planet?',
        'options': ['Earth', 'Mars', 'Jupiter', 'Saturn'],
        'correct': 2,
        'selected': 0,
        'isCorrect': false,
      },
    ];

    return Scaffold(
      backgroundColor: IbeereDesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: IbeereDesignTokens.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Review Quiz', style: TextStyle(color: IbeereDesignTokens.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSummaryItem(Icons.check_circle, 'Correct', '${questions.where((q) => q['isCorrect'] as bool).length}', IbeereDesignTokens.accentGreen),
                _buildSummaryItem(Icons.cancel, 'Wrong', '${questions.where((q) => !(q['isCorrect'] as bool)).length}', IbeereDesignTokens.primaryRed),
                _buildSummaryItem(Icons.question_answer, 'Total', '${questions.length}', IbeereDesignTokens.primaryPurple),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: questions.length,
              itemBuilder: (context, index) {
                final q = questions[index];
                final isCorrect = q['isCorrect'] as bool;
                
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isCorrect ? IbeereDesignTokens.accentGreen.withOpacity(0.3) : IbeereDesignTokens.primaryRed.withOpacity(0.3),
                      width: 2,
                    ),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: Offset(0, 2))],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isCorrect ? IbeereDesignTokens.accentGreen.withOpacity(0.1) : IbeereDesignTokens.primaryRed.withOpacity(0.1),
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(14)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: isCorrect ? IbeereDesignTokens.accentGreen : IbeereDesignTokens.primaryRed,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '${index + 1}',
                                  style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                q['question'] as String,
                                style: TextStyle(color: IbeereDesignTokens.textPrimary, fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                            Icon(
                              isCorrect ? Icons.check_circle : Icons.cancel,
                              color: isCorrect ? IbeereDesignTokens.accentGreen : IbeereDesignTokens.primaryRed,
                              size: 28,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...List.generate((q['options'] as List<String>).length, (optIndex) {
                              final option = (q['options'] as List<String>)[optIndex];
                              final isSelected = q['selected'] == optIndex;
                              final isCorrectOption = q['correct'] == optIndex;
                              
                              Color getColor() {
                                if (isCorrectOption) return IbeereDesignTokens.accentGreen;
                                if (isSelected && !isCorrectOption) return IbeereDesignTokens.primaryRed;
                                return IbeereDesignTokens.backgroundLight;
                              }
                              
                              Color getTextColor() {
                                if (isCorrectOption || (isSelected && !isCorrectOption)) return Colors.white;
                                return IbeereDesignTokens.textPrimary;
                              }

                              return Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: getColor(),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isCorrectOption ? IbeereDesignTokens.accentGreen :
                                           isSelected ? IbeereDesignTokens.primaryRed : Color(0xFFE2E8F0),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: (isCorrectOption || (isSelected && !isCorrectOption)) ? Colors.white.withOpacity(0.2) : Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          String.fromCharCode(65 + optIndex),
                                          style: TextStyle(
                                            color: getTextColor(),
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        option,
                                        style: TextStyle(color: getTextColor(), fontSize: 14),
                                      ),
                                    ),
                                    if (isCorrectOption)
                                      Icon(Icons.check, color: Colors.white, size: 20),
                                    if (isSelected && !isCorrectOption)
                                      Icon(Icons.close, color: Colors.white, size: 20),
                                  ],
                                ),
                              );
                            }),
                            if (!isCorrect) ...[
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: IbeereDesignTokens.accentYellow.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.lightbulb, color: IbeereDesignTokens.accentYellow, size: 20),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        'Explanation: The correct answer is ${(q['options'] as List<String>)[q['correct'] as int]}',
                                        style: TextStyle(color: IbeereDesignTokens.textSecondary, fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: IbeereButton(
              text: 'Back to Home',
              onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
              icon: Icons.home,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(IconData icon, String label, String value, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: IbeereDesignTokens.textSecondary, fontSize: 12)),
        const SizedBox(height: 2),
        Text(value, style: TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
