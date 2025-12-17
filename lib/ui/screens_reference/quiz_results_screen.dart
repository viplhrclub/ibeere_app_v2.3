import 'package:flutter/material.dart';
import '../../core/theme/design_tokens.dart';
import '../widgets/ibeere_buttons.dart';
import '../widgets/ibeere_cards.dart';
import '../widgets/ibeere_navigation.dart';

/// Quiz Results Screen for Ibeere
/// 
/// Shows detailed results and performance analytics after quiz completion
class QuizResultsScreen extends StatelessWidget {
  final String quizTitle;
  final String category;
  final int correctAnswers;
  final int totalQuestions;
  final int timeSpent; // in seconds
  final int pointsEarned;

  const QuizResultsScreen({
    Key? key,
    required this.quizTitle,
    required this.category,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.timeSpent,
    required this.pointsEarned,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final percentage = (correctAnswers / totalQuestions * 100).toInt();
    final isPassed = percentage >= 60;
    final grade = _getGrade(percentage);
    final minutes = timeSpent ~/ 60;
    final seconds = timeSpent % 60;

    return Scaffold(
      backgroundColor: DesignTokens.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header Section with Score Circle
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      isPassed
                          ? DesignTokens.success.withOpacity(0.2)
                          : DesignTokens.error.withOpacity(0.2),
                      DesignTokens.background,
                    ],
                  ),
                ),
                padding: EdgeInsets.all(DesignTokens.spaceLg),
                child: Column(
                  children: [
                    SizedBox(height: DesignTokens.spaceLg),
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isPassed
                            ? DesignTokens.success.withOpacity(0.1)
                            : DesignTokens.error.withOpacity(0.1),
                        border: Border.all(
                          color: isPassed
                              ? DesignTokens.success
                              : DesignTokens.error,
                          width: 4,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$percentage%',
                            style: TextStyle(
                              fontSize: DesignTokens.fontSizeXxxxl,
                              fontWeight: DesignTokens.fontWeightBold,
                              color: isPassed
                                  ? DesignTokens.success
                                  : DesignTokens.error,
                            ),
                          ),
                          Text(
                            grade,
                            style: TextStyle(
                              fontSize: DesignTokens.fontSizeLg,
                              fontWeight: DesignTokens.fontWeightSemibold,
                              color: isPassed
                                  ? DesignTokens.success
                                  : DesignTokens.error,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: DesignTokens.spaceXl),
                    Text(
                      isPassed ? 'Excellent Performance!' : 'Try Again',
                      style: TextStyle(
                        fontSize: DesignTokens.fontSizeXl,
                        fontWeight: DesignTokens.fontWeightBold,
                      ),
                    ),
                    SizedBox(height: DesignTokens.spaceSm),
                    Text(
                      'You completed $quizTitle',
                      style: TextStyle(
                        fontSize: DesignTokens.fontSizeBase,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: DesignTokens.spaceXl),
                  ],
                ),
              ),

              // Stats Section
              Padding(
                padding: EdgeInsets.all(DesignTokens.spaceLg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quiz Performance',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(height: DesignTokens.spaceMd),
                    Row(
                      children: [
                        Expanded(
                          child: _StatBox(
                            icon: Icons.check_circle,
                            title: 'Correct',
                            value: '$correctAnswers',
                            color: DesignTokens.success,
                          ),
                        ),
                        SizedBox(width: DesignTokens.spaceMd),
                        Expanded(
                          child: _StatBox(
                            icon: Icons.cancel,
                            title: 'Incorrect',
                            value: '${totalQuestions - correctAnswers}',
                            color: DesignTokens.error,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: DesignTokens.spaceMd),
                    Row(
                      children: [
                        Expanded(
                          child: _StatBox(
                            icon: Icons.timer,
                            title: 'Time',
                            value: '$minutes:${seconds.toString().padLeft(2, '0')}',
                            color: DesignTokens.warning,
                          ),
                        ),
                        SizedBox(width: DesignTokens.spaceMd),
                        Expanded(
                          child: _StatBox(
                            icon: Icons.stars,
                            title: 'Points',
                            value: '$pointsEarned',
                            color: DesignTokens.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Breakdown Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: DesignTokens.spaceLg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Detailed Breakdown',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(height: DesignTokens.spaceMd),
                    IbeereCard(
                      padding: EdgeInsets.all(DesignTokens.spaceLg),
                      elevation: 1,
                      child: Column(
                        children: [
                          _BreakdownItem(
                            label: 'Quiz Category',
                            value: category,
                            icon: Icons.category,
                          ),
                          Divider(
                            color: Colors.grey[300],
                            height: DesignTokens.spaceXl,
                          ),
                          _BreakdownItem(
                            label: 'Total Questions',
                            value: totalQuestions.toString(),
                            icon: Icons.help,
                          ),
                          Divider(
                            color: Colors.grey[300],
                            height: DesignTokens.spaceXl,
                          ),
                          _BreakdownItem(
                            label: 'Accuracy Rate',
                            value: '$percentage%',
                            icon: Icons.target,
                          ),
                          Divider(
                            color: Colors.grey[300],
                            height: DesignTokens.spaceXl,
                          ),
                          _BreakdownItem(
                            label: 'Status',
                            value: isPassed ? 'PASSED' : 'FAILED',
                            icon: isPassed ? Icons.verified : Icons.warning,
                            valueColor:
                                isPassed ? DesignTokens.success : DesignTokens.error,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: DesignTokens.spaceXl),

              // Achievement Section
              if (isPassed)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: DesignTokens.spaceLg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Achievements Unlocked',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      SizedBox(height: DesignTokens.spaceMd),
                      Row(
                        children: [
                          _AchievementBadge(
                            emoji: '🏆',
                            title: 'Quiz Champion',
                            description: 'Completed a quiz',
                          ),
                          SizedBox(width: DesignTokens.spaceMd),
                          if (percentage >= 90)
                            _AchievementBadge(
                              emoji: '⭐',
                              title: 'Perfect Score',
                              description: '90% or above',
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              SizedBox(height: DesignTokens.spaceXxl),

              // Action Buttons
              Padding(
                padding: EdgeInsets.symmetric(horizontal: DesignTokens.spaceLg),
                child: Column(
                  children: [
                    IbeerePrimaryButton(
                      label: 'Retake Quiz',
                      isFullWidth: true,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(height: DesignTokens.spaceMd),
                    IbeereSecondaryButton(
                      label: 'Back to Home',
                      isFullWidth: true,
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: DesignTokens.spaceLg),
            ],
          ),
        ),
      ),
    );
  }

  String _getGrade(int percentage) {
    if (percentage >= 90) return 'A+';
    if (percentage >= 80) return 'A';
    if (percentage >= 70) return 'B';
    if (percentage >= 60) return 'C';
    return 'F';
  }
}

/// Stat Box Widget
class _StatBox extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _StatBox({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return IbeereCard(
      backgroundColor: color.withOpacity(0.1),
      elevation: 1,
      padding: EdgeInsets.all(DesignTokens.spaceMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 28),
          SizedBox(height: DesignTokens.spaceSm),
          Text(
            value,
            style: TextStyle(
              fontSize: DesignTokens.fontSizeXl,
              fontWeight: DesignTokens.fontWeightBold,
              color: color,
            ),
          ),
          SizedBox(height: DesignTokens.spaceSm),
          Text(
            title,
            style: TextStyle(
              fontSize: DesignTokens.fontSizeSm,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

/// Breakdown Item Widget
class _BreakdownItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color? valueColor;

  const _BreakdownItem({
    required this.label,
    required this.value,
    required this.icon,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: DesignTokens.primary, size: 20),
            SizedBox(width: DesignTokens.spaceMd),
            Text(
              label,
              style: TextStyle(
                fontSize: DesignTokens.fontSizeBase,
                fontWeight: DesignTokens.fontWeightMedium,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: DesignTokens.fontSizeBase,
            fontWeight: DesignTokens.fontWeightBold,
            color: valueColor ?? DesignTokens.primary,
          ),
        ),
      ],
    );
  }
}

/// Achievement Badge Widget
class _AchievementBadge extends StatelessWidget {
  final String emoji;
  final String title;
  final String description;

  const _AchievementBadge({
    required this.emoji,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: IbeereCard(
        backgroundColor: Colors.amber.withOpacity(0.1),
        elevation: 1,
        padding: EdgeInsets.all(DesignTokens.spaceMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(emoji, style: TextStyle(fontSize: 32)),
            SizedBox(height: DesignTokens.spaceSm),
            Text(
              title,
              style: TextStyle(
                fontSize: DesignTokens.fontSizeSm,
                fontWeight: DesignTokens.fontWeightBold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: DesignTokens.spaceSm),
            Text(
              description,
              style: TextStyle(
                fontSize: DesignTokens.fontSizeXs,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
