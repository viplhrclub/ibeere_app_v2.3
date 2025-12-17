import 'package:flutter/material.dart';
import 'package:flutterquiz/features/quiz/models/guess_the_word_question.dart';
import 'package:flutterquiz/features/system_config/model/answer_mode.dart';

/// Placeholder widget for Guess The Word questions
class GuessTheWordQuestionContainer extends StatefulWidget {

  const GuessTheWordQuestionContainer({
    required this.answerMode, required this.showHint, required this.timerAnimationController, required this.submitAnswer, required this.constraints, required this.currentQuestionIndex, required this.questions, super.key,
  });
  final AnswerMode answerMode;
  final bool showHint;
  final AnimationController timerAnimationController;
  final void Function(String) submitAnswer;
  final BoxConstraints constraints;
  final int currentQuestionIndex;
  final List<GuessTheWordQuestion> questions;

  @override
  State<GuessTheWordQuestionContainer> createState() =>
      _GuessTheWordQuestionContainerState();
}

class _GuessTheWordQuestionContainerState
    extends State<GuessTheWordQuestionContainer> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Guess The Word Quiz\nQuestion ${widget.currentQuestionIndex + 1}',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

