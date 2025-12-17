import 'package:flutter/material.dart';
import 'package:flutterquiz/features/quiz/models/question.dart';
import 'package:flutterquiz/features/system_config/model/answer_mode.dart';

/// Placeholder widget for Audio questions
class AudioQuestionContainer extends StatefulWidget {

  const AudioQuestionContainer({
    required this.answerMode, required this.hasSubmittedAnswerForCurrentQuestion, required this.questionAnimationController, required this.questionSlideAnimation, required this.questionScaleUpAnimation, required this.questionScaleDownAnimation, required this.questionContentAnimation, required this.questionContentAnimationController, required this.questions, required this.currentQuestionIndex, required this.submitAnswer, required this.timerAnimationController, required this.lifeLines, super.key,
    this.topPadding,
    this.level,
  });
  final AnswerMode answerMode;
  final bool Function() hasSubmittedAnswerForCurrentQuestion;
  final AnimationController questionAnimationController;
  final Animation<double> questionSlideAnimation;
  final Animation<double> questionScaleUpAnimation;
  final Animation<double> questionScaleDownAnimation;
  final Animation<double> questionContentAnimation;
  final AnimationController questionContentAnimationController;
  final List<Question> questions;
  final int currentQuestionIndex;
  final void Function(String) submitAnswer;
  final AnimationController timerAnimationController;
  final double? topPadding;
  final String? level;
  final Map<String, dynamic> lifeLines;

  @override
  State<AudioQuestionContainer> createState() => _AudioQuestionContainerState();
}

class _AudioQuestionContainerState extends State<AudioQuestionContainer> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Audio Question ${widget.currentQuestionIndex + 1}\nClick to play audio',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

