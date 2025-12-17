import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/design_tokens.dart';
import 'package:flutterquiz/ui/widgets/ibeere_buttons.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  int _currentQuestion = 0;
  final int _totalQuestions = 50;
  final List<int?> _answers = [];

  @override
  void initState() {
    super.initState();
    _answers.addAll(List.filled(_totalQuestions, null));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.background,
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF3B30),
        elevation: 0,
        title: const Text(
          'Exam Mode',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: _showExitDialog,
        ),
        actions: const [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '45:30',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'remaining',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress
          Container(
            padding: const EdgeInsets.all(12),
            color: const Color(0xFFF2F2F7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Question ${_currentQuestion + 1}/$_totalQuestions',
                      style: TextStyle(
                        fontSize: DesignTokens.fontSizeBase,
                        fontWeight: DesignTokens.fontWeightMedium,
                      ),
                    ),
                    Text(
                      '${((_currentQuestion + 1) / _totalQuestions * 100).toStringAsFixed(0)}%',
                      style: TextStyle(
                        fontSize: DesignTokens.fontSizeBase,
                        fontWeight: DesignTokens.fontWeightBold,
                        color: DesignTokens.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: DesignTokens.spaceSm),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: (_currentQuestion + 1) / _totalQuestions,
                    minHeight: 6,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(DesignTokens.primary),
                  ),
                ),
              ],
            ),
          ),

          // Question
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(DesignTokens.spaceLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DesignTokens.spaceSm,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Single Correct',
                      style: TextStyle(
                        fontSize: DesignTokens.fontSizeSm,
                        color: Colors.blue[700],
                        fontWeight: DesignTokens.fontWeightBold,
                      ),
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spaceMd),
                  Text(
                    'Which element has the symbol Au?',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: DesignTokens.fontWeightBold,
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spaceXxl),

                  // Options
                  ...[
                    {'text': 'Silver', 'isCorrect': false},
                    {'text': 'Gold', 'isCorrect': true},
                    {'text': 'Aluminum', 'isCorrect': false},
                    {'text': 'Argon', 'isCorrect': false},
                  ].asMap().entries.map((entry) {
                    final index = entry.key;
                    final option = entry.value;
                    final isSelected = _answers[_currentQuestion] == index;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: DesignTokens.spaceMd),
                      child: GestureDetector(
                        onTap: () => setState(() => _answers[_currentQuestion] = index),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.blue[50] : Colors.white,
                            border: Border.all(
                              color: isSelected ? DesignTokens.primary : (Colors.grey[300] ?? Colors.grey),
                              width: isSelected ? 2 : 1,
                            ),
                            borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(DesignTokens.spaceMd),
                            child: Row(
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: isSelected ? DesignTokens.primary : Colors.grey[400]!,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: isSelected
                                      ? Center(
                                    child: Container(
                                      width: 12,
                                      height: 12,
                                      decoration: BoxDecoration(
                                        color: DesignTokens.primary,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  )
                                      : null,
                                ),
                                const SizedBox(width: DesignTokens.spaceMd),
                                Expanded(
                                  child: Text(
                                    option['text']! as String,
                                    style: TextStyle(
                                      fontSize: DesignTokens.fontSizeBase,
                                      fontWeight: isSelected ? DesignTokens.fontWeightBold : DesignTokens.fontWeightMedium,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),

          // Navigation
          Padding(
            padding: const EdgeInsets.all(DesignTokens.spaceLg),
            child: Row(
              children: [
                Expanded(
                  child: IbeereSecondaryButton(
                    label: 'Previous',
                    onPressed: _currentQuestion > 0
                        ? () => setState(() => _currentQuestion--)
                        : () {},
                  ),
                ),
                const SizedBox(width: DesignTokens.spaceMd),
                Expanded(
                  child: IbeerePrimaryButton(
                    label: _currentQuestion < _totalQuestions - 1 ? 'Next' : 'Submit',
                    onPressed: () {
                      if (_currentQuestion < _totalQuestions - 1) {
                        setState(() => _currentQuestion++);
                      } else {
                        _showSubmitDialog();
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

  void _showExitDialog() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit Exam?'),
        content: const Text('Your progress will be lost. Are you sure?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Exit', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showSubmitDialog() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Submit Exam?'),
        content: Text('You have answered ${_answers.where((a) => a != null).length} out of $_totalQuestions questions.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Review'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Submit', style: TextStyle(color: DesignTokens.primary)),
          ),
        ],
      ),
    );
  }
}


