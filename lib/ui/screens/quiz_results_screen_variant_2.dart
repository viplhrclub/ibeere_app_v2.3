import 'package:flutter/material.dart';
import 'package:flutterquiz/ui/screens/quiz_results_screen.dart';

/// Quiz results - Variant 2
/// Screenshot: 36_quiz_results_screen_2
class QuizResultsScreenVariant2 extends StatelessWidget {
  const QuizResultsScreenVariant2({super.key});

  @override
  Widget build(BuildContext context) {
    return const QuizResultsScreen(
      quizTitle: 'Sample Quiz',
      category: 'General Knowledge',
      correctAnswers: 8,
      totalQuestions: 10,
      timeSpent: 120,
      pointsEarned: 80,
    );
  }
}

