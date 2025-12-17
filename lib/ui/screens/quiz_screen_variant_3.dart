import 'package:flutter/material.dart';
import 'package:flutterquiz/ui/screens/quiz_screen.dart';

/// Quiz - Variant 3
/// Screenshot: 33_quiz_screen_3
class QuizScreenVariant3 extends StatelessWidget {
  const QuizScreenVariant3({super.key});

  @override
  Widget build(BuildContext context) {
    return const QuizScreen(
      quizTitle: 'Sample Quiz',
      category: 'General Knowledge',
    );
  }
}

