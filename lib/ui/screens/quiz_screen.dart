import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/design_tokens.dart';
import 'package:flutterquiz/ui/widgets/ibeere_buttons.dart';
import 'package:flutterquiz/ui/widgets/ibeere_cards.dart';
import 'package:flutterquiz/ui/widgets/ibeere_navigation.dart';

/// Quiz Screen for Ibeere
/// 
/// Displays quiz questions and handles user answers
class QuizScreen extends StatefulWidget {

  const QuizScreen({
    required this.quizTitle, required this.category, super.key,
  });
  final String quizTitle;
  final String category;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int? _selectedAnswerIndex;
  bool _answered = false;
  int _correctAnswers = 0;
  int _totalQuestions = 0;

  final List<_Question> _questions = [
    _Question(
      question: 'What is the capital of France?',
      options: ['London', 'Paris', 'Berlin', 'Madrid'],
      correctIndex: 1,
    ),
    _Question(
      question: 'Which planet is known as the Red Planet?',
      options: ['Venus', 'Mars', 'Jupiter', 'Saturn'],
      correctIndex: 1,
    ),
    _Question(
      question: 'What is the largest ocean on Earth?',
      options: ['Atlantic', 'Indian', 'Arctic', 'Pacific'],
      correctIndex: 3,
    ),
    _Question(
      question: 'Who painted the Mona Lisa?',
      options: ['Michelangelo', 'Leonardo da Vinci', 'Raphael', 'Donatello'],
      correctIndex: 1,
    ),
    _Question(
      question: 'What is the chemical symbol for Gold?',
      options: ['Go', 'Gd', 'Au', 'Ag'],
      correctIndex: 2,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _totalQuestions = _questions.length;
  }

  void _selectAnswer(int index) {
    if (!_answered) {
      setState(() {
        _selectedAnswerIndex = index;
        _answered = true;
        if (index == _questions[_currentQuestionIndex].correctIndex) {
          _correctAnswers++;
        }
      });
    }
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswerIndex = null;
        _answered = false;
      });
    } else {
      _showResultsDialog();
    }
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
        _selectedAnswerIndex = null;
        _answered = false;
      });
    }
  }

  void _showResultsDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => _ResultsDialog(
        correctAnswers: _correctAnswers,
        totalQuestions: _totalQuestions,
        onRetry: () {
          Navigator.pop(context);
          _resetQuiz();
        },
        onFinish: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _resetQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _selectedAnswerIndex = null;
      _answered = false;
      _correctAnswers = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentQuestionIndex];
    final progress = (_currentQuestionIndex + 1) / _questions.length;

    return Scaffold(
      backgroundColor: DesignTokens.background,
      appBar: IbeereAppBar(
        title: widget.quizTitle,
        centerTitle: true,
        onLeadingPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(DesignTokens.spaceLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Question ${_currentQuestionIndex + 1}/$_totalQuestions',
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeBase,
                    fontWeight: DesignTokens.fontWeightSemibold,
                    color: DesignTokens.primary,
                  ),
                ),
                Text(
                  '${(_correctAnswers / (_currentQuestionIndex + 1) * 100).toStringAsFixed(0)}%',
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeBase,
                    fontWeight: DesignTokens.fontWeightBold,
                    color: DesignTokens.success,
                  ),
                ),
              ],
            ),
            const SizedBox(height: DesignTokens.spaceSm),
            ClipRRect(
              borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(
                  DesignTokens.primary,
                ),
              ),
            ),
            const SizedBox(height: DesignTokens.spaceXxl),

            // Question Section
            IbeereCard(
              backgroundColor: DesignTokens.surface,
              elevation: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question.question,
                    style: const TextStyle(
                      fontSize: DesignTokens.fontSizeXl,
                      fontWeight: DesignTokens.fontWeightBold,
                      height: DesignTokens.lineHeightRelaxed,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: DesignTokens.spaceXl),

            // Options Section
            Column(
              children: List.generate(
                question.options.length,
                (index) {
                  final isSelected = _selectedAnswerIndex == index;
                  final isCorrect = index == question.correctIndex;
                  final showCorrect = _answered && isCorrect;
                  final showIncorrect = _answered && isSelected && !isCorrect;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: DesignTokens.spaceMd),
                    child: _AnswerOption(
                      number: String.fromCharCode(65 + index), // A, B, C, D
                      text: question.options[index],
                      isSelected: isSelected,
                      isCorrect: showCorrect,
                      isIncorrect: showIncorrect,
                      onTap: () => _selectAnswer(index),
                      enabled: !_answered,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: DesignTokens.spaceXxl),

            // Navigation Buttons
            Row(
              children: [
                Expanded(
                  child: IbeereSecondaryButton(
                    label: 'Previous',
                    isEnabled: _currentQuestionIndex > 0,
                    onPressed: _previousQuestion,
                  ),
                ),
                const SizedBox(width: DesignTokens.spaceMd),
                Expanded(
                  child: IbeerePrimaryButton(
                    label: _currentQuestionIndex == _questions.length - 1
                        ? 'Finish'
                        : 'Next',
                    isEnabled: _answered,
                    onPressed: _nextQuestion,
                  ),
                ),
              ],
            ),
            const SizedBox(height: DesignTokens.spaceLg),
          ],
        ),
      ),
    );
  }
}

/// Answer Option Widget
class _AnswerOption extends StatelessWidget {

  const _AnswerOption({
    required this.number,
    required this.text,
    required this.isSelected,
    required this.isCorrect,
    required this.isIncorrect,
    required this.onTap,
    required this.enabled,
  });
  final String number;
  final String text;
  final bool isSelected;
  final bool isCorrect;
  final bool isIncorrect;
  final VoidCallback onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    var backgroundColor = DesignTokens.surface;
    var borderColor = Colors.grey[300] ?? Colors.grey;
    var textColor = DesignTokens.primary;

    if (isCorrect) {
      backgroundColor = DesignTokens.success.withOpacity(0.5);
      borderColor = DesignTokens.success;
      textColor = DesignTokens.success;
    } else if (isIncorrect) {
      backgroundColor = DesignTokens.error.withOpacity(0.5);
      borderColor = DesignTokens.error;
      textColor = DesignTokens.error;
    } else if (isSelected) {
      backgroundColor = DesignTokens.primary.withOpacity(0.5);
      borderColor = DesignTokens.primary;
    }

    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        padding: const EdgeInsets.all(DesignTokens.spaceMd),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor, width: 2),
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: borderColor,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: DesignTokens.fontWeightBold,
                  fontSize: DesignTokens.fontSizeBase,
                ),
              ),
            ),
            const SizedBox(width: DesignTokens.spaceMd),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: DesignTokens.fontSizeBase,
                  fontWeight: DesignTokens.fontWeightMedium,
                  color: textColor,
                ),
              ),
            ),
            if (isCorrect)
              Icon(Icons.check_circle, color: DesignTokens.success)
            else if (isIncorrect)
              Icon(Icons.cancel, color: DesignTokens.error),
          ],
        ),
      ),
    );
  }
}

/// Results Dialog
class _ResultsDialog extends StatelessWidget {

  const _ResultsDialog({
    required this.correctAnswers,
    required this.totalQuestions,
    required this.onRetry,
    required this.onFinish,
  });
  final int correctAnswers;
  final int totalQuestions;
  final VoidCallback onRetry;
  final VoidCallback onFinish;

  @override
  Widget build(BuildContext context) {
    final percentage = (correctAnswers / totalQuestions * 100).toInt();
    final isPassed = percentage >= 60;

    return AlertDialog(
      backgroundColor: DesignTokens.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: isPassed
                  ? DesignTokens.success.withOpacity(0.5)
                  : DesignTokens.error.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(
              isPassed ? Icons.check_circle : Icons.error,
              size: 48,
              color: isPassed ? DesignTokens.success : DesignTokens.error,
            ),
          ),
          const SizedBox(height: DesignTokens.spaceLg),
          Text(
            isPassed ? 'Great Job!' : 'Try Again',
            style: const TextStyle(
              fontSize: DesignTokens.fontSizeXl,
              fontWeight: DesignTokens.fontWeightBold,
            ),
          ),
          const SizedBox(height: DesignTokens.spaceSm),
          Text(
            'You scored $percentage%',
            style: TextStyle(
              fontSize: DesignTokens.fontSizeLg,
              fontWeight: DesignTokens.fontWeightSemibold,
              color: isPassed ? DesignTokens.success : DesignTokens.error,
            ),
          ),
          const SizedBox(height: DesignTokens.spaceMd),
          Text(
            '$correctAnswers of $totalQuestions correct',
            style: TextStyle(
              fontSize: DesignTokens.fontSizeBase,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: DesignTokens.spaceXl),
        ],
      ),
      actions: [
        SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: onRetry,
                  child: Text(
                    'Retry',
                    style: TextStyle(color: DesignTokens.primary),
                  ),
                ),
              ),
              const SizedBox(width: DesignTokens.spaceMd),
              Expanded(
                child: ElevatedButton(
                  onPressed: onFinish,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: DesignTokens.primary,
                  ),
                  child: const Text('Finish'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Question Model
class _Question {

  _Question({
    required this.question,
    required this.options,
    required this.correctIndex,
  });
  final String question;
  final List<String> options;
  final int correctIndex;
}



