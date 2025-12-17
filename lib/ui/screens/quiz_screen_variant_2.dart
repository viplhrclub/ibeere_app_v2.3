import 'package:flutter/material.dart';
import 'package:flutterquiz/ui/screens/quiz_screen.dart';

/// Quiz - Variant 2
/// Screenshot: 33_quiz_screen_2
class QuizScreenVariant2 extends StatelessWidget {
  const QuizScreenVariant2({super.key});

  @override
  Widget build(BuildContext context) {
    return const QuizScreen(
      quizTitle: 'Sample Quiz',
      category: 'General Knowledge',
    );
  }
}

