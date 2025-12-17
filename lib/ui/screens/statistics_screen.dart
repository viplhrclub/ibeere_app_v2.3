import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/design_tokens.dart';
import 'package:flutterquiz/ui/widgets/ibeere_cards.dart';
import 'package:flutterquiz/ui/widgets/ibeere_navigation.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _stats = _Statistics(
    totalQuizzes: 142,
    correctAnswers: 1240,
    totalQuestions: 1420,
    accuracy: 87.3,
    currentStreak: 28,
    longestStreak: 45,
    totalPoints: 5240,
    bestCategory: 'Science',
    categoryStats: [
      _CategoryStat(name: 'Science', accuracy: 92, completed: 32),
      _CategoryStat(name: 'Mathematics', accuracy: 88, completed: 28),
      _CategoryStat(name: 'History', accuracy: 85, completed: 25),
      _CategoryStat(name: 'Geography', accuracy: 87, completed: 30),
      _CategoryStat(name: 'Literature', accuracy: 78, completed: 22),
      _CategoryStat(name: 'Technology', accuracy: 91, completed: 28),
    ],
  );

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accuracy = _stats.correctAnswers / _stats.totalQuestions * 100;

    return Scaffold(
      backgroundColor: DesignTokens.background,
      appBar: const IbeereAppBar(
        title: 'Statistics',
        showBackButton: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Main Stats
            Padding(
              padding: const EdgeInsets.all(DesignTokens.spaceLg),
              child: Column(
                children: [
                  // Accuracy Circle
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: DesignTokens.primary.withOpacity(0.5),
                      border: Border.all(
                        color: DesignTokens.primary,
                        width: 4,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          accuracy.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: DesignTokens.fontSizeXxxxl,
                            fontWeight: DesignTokens.fontWeightBold,
                            color: DesignTokens.primary,
                          ),
                        ),
                        Text(
                          'Accuracy',
                          style: TextStyle(
                            fontSize: DesignTokens.fontSizeBase,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spaceXl),

                  // Quick Stats Grid
                  GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: DesignTokens.spaceMd,
                    mainAxisSpacing: DesignTokens.spaceMd,
                    children: [
                      _StatBox(
                        label: 'Quizzes',
                        value: _stats.totalQuizzes.toString(),
                        icon: Icons.quiz,
                        color: DesignTokens.primary,
                      ),
                      _StatBox(
                        label: 'Points',
                        value: _stats.totalPoints.toString(),
                        icon: Icons.stars,
                        color: DesignTokens.warning,
                      ),
                      _StatBox(
                        label: 'Streak',
                        value: _stats.currentStreak.toString(),
                        icon: Icons.local_fire_department,
                        color: DesignTokens.error,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: DesignTokens.spaceLg),
              child: IbeereTabBar(
                tabs: const ['Overview', 'By Category'],
                controller: _tabController,
              ),
            ),

            // Tab Views
            SizedBox(
              height: 400,
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Overview Tab
                  ListView(
                    padding: const EdgeInsets.all(DesignTokens.spaceLg),
                    children: [
                      _StatDetail(
                        label: 'Total Questions Answered',
                        value: _stats.totalQuestions.toString(),
                      ),
                      _StatDetail(
                        label: 'Correct Answers',
                        value: '${_stats.correctAnswers} (${accuracy.toStringAsFixed(1)}%)',
                      ),
                      _StatDetail(
                        label: 'Current Streak',
                        value: '${_stats.currentStreak} days',
                      ),
                      _StatDetail(
                        label: 'Longest Streak',
                        value: '${_stats.longestStreak} days',
                      ),
                      _StatDetail(
                        label: 'Best Category',
                        value: _stats.bestCategory,
                      ),
                    ],
                  ),

                  // By Category Tab
                  ListView(
                    padding: const EdgeInsets.all(DesignTokens.spaceLg),
                    children: _stats.categoryStats
                        .map((cat) => Padding(
                          padding: const EdgeInsets.only(bottom: DesignTokens.spaceMd),
                          child: _CategoryStatCard(stat: cat),
                        ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatBox extends StatelessWidget {

  const _StatBox({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IbeereCard(
      backgroundColor: color.withOpacity(0.5),
      elevation: 1,
      padding: const EdgeInsets.all(DesignTokens.spaceMd),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: DesignTokens.spaceSm),
          Text(
            value,
            style: TextStyle(
              fontSize: DesignTokens.fontSizeLg,
              fontWeight: DesignTokens.fontWeightBold,
              color: color,
            ),
          ),
          const SizedBox(height: DesignTokens.spaceSm),
          Text(
            label,
            style: TextStyle(
              fontSize: DesignTokens.fontSizeXs,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _StatDetail extends StatelessWidget {

  const _StatDetail({
    required this.label,
    required this.value,
  });
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: DesignTokens.spaceMd),
      child: IbeereCard(
        padding: const EdgeInsets.all(DesignTokens.spaceMd),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: DesignTokens.fontSizeBase,
                fontWeight: DesignTokens.fontWeightMedium,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: DesignTokens.fontSizeBase,
                fontWeight: DesignTokens.fontWeightBold,
                color: DesignTokens.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryStatCard extends StatelessWidget {

  const _CategoryStatCard({required this.stat});
  final _CategoryStat stat;

  @override
  Widget build(BuildContext context) {
    return IbeereCard(
      elevation: 1,
      padding: const EdgeInsets.all(DesignTokens.spaceMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                stat.name,
                style: const TextStyle(
                  fontSize: DesignTokens.fontSizeBase,
                  fontWeight: DesignTokens.fontWeightBold,
                ),
              ),
              Text(
                '${stat.accuracy}%',
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
            borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
            child: LinearProgressIndicator(
              value: stat.accuracy / 100,
              minHeight: 6,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(DesignTokens.primary),
            ),
          ),
          const SizedBox(height: DesignTokens.spaceSm),
          Text(
            '${stat.completed} quizzes completed',
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

class _Statistics {

  _Statistics({
    required this.totalQuizzes,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.accuracy,
    required this.currentStreak,
    required this.longestStreak,
    required this.totalPoints,
    required this.bestCategory,
    required this.categoryStats,
  });
  final int totalQuizzes;
  final int correctAnswers;
  final int totalQuestions;
  final double accuracy;
  final int currentStreak;
  final int longestStreak;
  final int totalPoints;
  final String bestCategory;
  final List<_CategoryStat> categoryStats;
}

class _CategoryStat {

  _CategoryStat({
    required this.name,
    required this.accuracy,
    required this.completed,
  });
  final String name;
  final int accuracy;
  final int completed;
}


