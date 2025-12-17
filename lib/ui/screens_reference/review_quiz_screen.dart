import 'package:flutter/material.dart';
import '../../core/theme/design_tokens.dart';
import '../widgets/ibeere_buttons.dart';
import '../widgets/ibeere_cards.dart';

class ReviewQuizScreen extends StatefulWidget {
  const ReviewQuizScreen({Key? key}) : super(key: key);

  @override
  State<ReviewQuizScreen> createState() => _ReviewQuizScreenState();
}

class _ReviewQuizScreenState extends State<ReviewQuizScreen> {
  int _selectedQuestionIndex = 0;
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'What is the capital of France?',
      'options': ['London', 'Berlin', 'Paris', 'Madrid'],
      'correctAnswer': 2,
      'userAnswer': 2,
      'explanation': 'Paris is the capital city of France, located in the north-central part of the country.',
    },
    {
      'question': 'Which planet is closest to the Sun?',
      'options': ['Venus', 'Mercury', 'Mars', 'Earth'],
      'correctAnswer': 1,
      'userAnswer': 0,
      'explanation': 'Mercury is the closest planet to the Sun, despite Venus being hotter.',
    },
    {
      'question': 'What is the chemical symbol for gold?',
      'options': ['Go', 'Gd', 'Au', 'Ag'],
      'correctAnswer': 2,
      'userAnswer': 2,
      'explanation': 'Au is the chemical symbol for gold, derived from the Latin word "aurum".',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _questions[_selectedQuestionIndex];
    final isCorrect = currentQuestion['userAnswer'] == currentQuestion['correctAnswer'];

    return Scaffold(
      backgroundColor: DesignTokens.background,
      appBar: AppBar(
        backgroundColor: DesignTokens.background,
        elevation: 0,
        title: Text(
          'Review Quiz',
          style: TextStyle(
            color: DesignTokens.primary,
            fontWeight: DesignTokens.fontWeightBold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: DesignTokens.primary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Progress Indicator
          Padding(
            padding: EdgeInsets.all(DesignTokens.spaceLg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Question ${_selectedQuestionIndex + 1}/${_questions.length}',
                      style: TextStyle(
                        fontSize: DesignTokens.fontSizeBase,
                        fontWeight: DesignTokens.fontWeightMedium,
                        color: Colors.grey[600],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: DesignTokens.spaceSm,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: isCorrect ? Colors.green[100] : Colors.red[100],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        isCorrect ? 'Correct' : 'Incorrect',
                        style: TextStyle(
                          fontSize: DesignTokens.fontSizeSm,
                          color: isCorrect ? Colors.green[700] : Colors.red[700],
                          fontWeight: DesignTokens.fontWeightBold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: DesignTokens.spaceMd),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: (_selectedQuestionIndex + 1) / _questions.length,
                    minHeight: 6,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(DesignTokens.primary),
                  ),
                ),
              ],
            ),
          ),

          // Question Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: DesignTokens.spaceLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Question
                  Text(
                    currentQuestion['question'] as String,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: DesignTokens.fontWeightBold,
                    ),
                  ),
                  SizedBox(height: DesignTokens.spaceXl),

                  // Options
                  ...(currentQuestion['options'] as List<String>).asMap().entries.map((entry) {
                    final index = entry.key;
                    final option = entry.value;
                    final isUserAnswer = index == currentQuestion['userAnswer'];
                    final isCorrectAnswer = index == currentQuestion['correctAnswer'];

                    Color borderColor = Colors.grey[300] ?? Colors.grey;
                    Color bgColor = Colors.white;

                    if (isCorrectAnswer) {
                      borderColor = Colors.green;
                      bgColor = Colors.green[50] ?? Colors.green;
                    } else if (isUserAnswer && !isCorrectAnswer) {
                      borderColor = Colors.red;
                      bgColor = Colors.red[50] ?? Colors.red;
                    }

                    return Padding(
                      padding: EdgeInsets.only(bottom: DesignTokens.spaceMd),
                      child: Container(
                        decoration: BoxDecoration(
                          color: bgColor,
                          border: Border.all(color: borderColor, width: 2),
                          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(DesignTokens.spaceMd),
                          child: Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: borderColor.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    String.fromCharCode(65 + index),
                                    style: TextStyle(
                                      fontWeight: DesignTokens.fontWeightBold,
                                      color: borderColor,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: DesignTokens.spaceMd),
                              Expanded(
                                child: Text(
                                  option,
                                  style: TextStyle(
                                    fontSize: DesignTokens.fontSizeBase,
                                    fontWeight: DesignTokens.fontWeightMedium,
                                  ),
                                ),
                              ),
                              if (isCorrectAnswer)
                                Icon(Icons.check_circle, color: Colors.green, size: 20)
                              else if (isUserAnswer)
                                Icon(Icons.close_circle, color: Colors.red, size: 20),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),

                  SizedBox(height: DesignTokens.spaceXl),

                  // Explanation
                  Container(
                    padding: EdgeInsets.all(DesignTokens.spaceMd),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                      border: Border.all(color: Colors.blue[200] ?? Colors.blue),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.lightbulb_outline, color: Colors.blue[700], size: 20),
                            SizedBox(width: DesignTokens.spaceSm),
                            Text(
                              'Explanation',
                              style: TextStyle(
                                fontSize: DesignTokens.fontSizeBase,
                                fontWeight: DesignTokens.fontWeightBold,
                                color: Colors.blue[700],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: DesignTokens.spaceSm),
                        Text(
                          currentQuestion['explanation'] as String,
                          style: TextStyle(
                            fontSize: DesignTokens.fontSizeBase,
                            color: Colors.blue[900],
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: DesignTokens.spaceXl),
                ],
              ),
            ),
          ),

          // Navigation Buttons
          Padding(
            padding: EdgeInsets.all(DesignTokens.spaceLg),
            child: Row(
              children: [
                Expanded(
                  child: IbeereSecondaryButton(
                    label: 'Previous',
                    onPressed: _selectedQuestionIndex > 0
                        ? () => setState(() => _selectedQuestionIndex--)
                        : null,
                  ),
                ),
                SizedBox(width: DesignTokens.spaceMd),
                Expanded(
                  child: IbeerePrimaryButton(
                    label: _selectedQuestionIndex < _questions.length - 1 ? 'Next' : 'Finish',
                    onPressed: () {
                      if (_selectedQuestionIndex < _questions.length - 1) {
                        setState(() => _selectedQuestionIndex++);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
