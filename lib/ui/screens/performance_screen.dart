import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/design_tokens.dart';

class PerformanceScreen extends StatefulWidget {
  const PerformanceScreen({super.key});

  @override
  State<PerformanceScreen> createState() => _PerformanceScreenState();
}

class _PerformanceScreenState extends State<PerformanceScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: _selectedTab,
      child: Scaffold(
        backgroundColor: DesignTokens.background,
        appBar: AppBar(
          backgroundColor: DesignTokens.background,
          elevation: 0,
          title: Text(
            'Performance Analytics',
            style: TextStyle(
              color: DesignTokens.primary,
              fontWeight: DesignTokens.fontWeightBold,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: DesignTokens.primary),
            onPressed: () => Navigator.pop(context),
          ),
          bottom: TabBar(
            indicatorColor: DesignTokens.primary,
            labelColor: DesignTokens.primary,
            unselectedLabelColor: Colors.grey[500],
            onTap: (index) => setState(() => _selectedTab = index),
            tabs: const [
              Tab(text: 'Overview'),
              Tab(text: 'Categories'),
              Tab(text: 'Weekly'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildOverviewTab(),
            _buildCategoriesTab(),
            _buildWeeklyTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(DesignTokens.spaceLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Overall Performance',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: DesignTokens.fontWeightBold,
            ),
          ),
          const SizedBox(height: DesignTokens.spaceLg),

          // Stats Cards
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.3,
            mainAxisSpacing: DesignTokens.spaceMd,
            crossAxisSpacing: DesignTokens.spaceMd,
            children: [
              _statCard('Quizzes Completed', '156', Colors.blue),
              _statCard('Average Score', '78%', Colors.green),
              _statCard('Study Streak', '12 days', Colors.orange),
              _statCard('Points Earned', '4,250', Colors.purple),
            ],
          ),
          const SizedBox(height: DesignTokens.spaceXxl),

          // Progress Chart
          Text(
            'Monthly Progress',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: DesignTokens.fontWeightBold,
            ),
          ),
          const SizedBox(height: DesignTokens.spaceMd),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
              border: Border.all(color: Colors.grey[200] ?? Colors.grey),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bar_chart_rounded,
                    color: Colors.grey[400],
                    size: 40,
                  ),
                  const SizedBox(height: DesignTokens.spaceSm),
                  Text(
                    'Chart Placeholder',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: DesignTokens.fontSizeBase,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: DesignTokens.spaceXxl),

          // Weak Areas
          Text(
            'Areas to Improve',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: DesignTokens.fontWeightBold,
            ),
          ),
          const SizedBox(height: DesignTokens.spaceMd),
          _improvementCard('Physics', '62%', 0.62),
          const SizedBox(height: DesignTokens.spaceMd),
          _improvementCard('Chemistry', '71%', 0.71),
          const SizedBox(height: DesignTokens.spaceMd),
          _improvementCard('Biology', '68%', 0.68),
        ],
      ),
    );
  }

  Widget _buildCategoriesTab() {
    final categories = [
      {'name': 'Mathematics', 'score': 85, 'quizzes': 24},
      {'name': 'Physics', 'score': 72, 'quizzes': 18},
      {'name': 'Chemistry', 'score': 79, 'quizzes': 21},
      {'name': 'Biology', 'score': 81, 'quizzes': 19},
      {'name': 'History', 'score': 88, 'quizzes': 15},
      {'name': 'Geography', 'score': 76, 'quizzes': 17},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(DesignTokens.spaceLg),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return Container(
          margin: const EdgeInsets.only(bottom: DesignTokens.spaceMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
            border: Border.all(color: Colors.grey[200] ?? Colors.grey),
          ),
          child: Padding(
            padding: const EdgeInsets.all(DesignTokens.spaceMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      category['name']! as String,
                      style: const TextStyle(
                        fontSize: DesignTokens.fontSizeBase,
                        fontWeight: DesignTokens.fontWeightBold,
                      ),
                    ),
                    Text(
                      '${category['score']}%',
                      style: TextStyle(
                        fontSize: DesignTokens.fontSizeBase,
                        color: DesignTokens.primary,
                        fontWeight: DesignTokens.fontWeightBold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: DesignTokens.spaceSm),
                LinearProgressIndicator(
                  value: (category['score']! as int) / 100,
                  minHeight: 6,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(DesignTokens.primary),
                  borderRadius: BorderRadius.circular(3),
                ),
                const SizedBox(height: DesignTokens.spaceSm),
                Text(
                  '${category['quizzes']} quizzes completed',
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeSm,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildWeeklyTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(DesignTokens.spaceLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'This Week',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: DesignTokens.fontWeightBold,
            ),
          ),
          const SizedBox(height: DesignTokens.spaceLg),

          // Weekly Chart
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
              border: Border.all(color: Colors.grey[200] ?? Colors.grey),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.show_chart_rounded,
                    color: Colors.grey[400],
                    size: 40,
                  ),
                  const SizedBox(height: DesignTokens.spaceSm),
                  Text(
                    'Line Chart Placeholder',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: DesignTokens.fontSizeBase,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: DesignTokens.spaceXxl),

          // Daily Stats
          Text(
            'Daily Breakdown',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: DesignTokens.fontWeightBold,
            ),
          ),
          const SizedBox(height: DesignTokens.spaceMd),
          ..._getDayStats().asMap().entries.map((entry) {
            final day = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: DesignTokens.spaceMd),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    day['day'] as String,
                    style: const TextStyle(
                      fontSize: DesignTokens.fontSizeBase,
                      fontWeight: DesignTokens.fontWeightMedium,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${day['quizzes']} quizzes',
                        style: TextStyle(
                          fontSize: DesignTokens.fontSizeSm,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(width: DesignTokens.spaceLg),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: DesignTokens.spaceSm,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '${day['score']}%',
                          style: TextStyle(
                            fontSize: DesignTokens.fontSizeSm,
                            color: Colors.green[700],
                            fontWeight: DesignTokens.fontWeightBold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _statCard(String label, String value, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        border: Border.all(color: Colors.grey[200] ?? Colors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.all(DesignTokens.spaceMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.trending_up_rounded,
                color: color,
                size: 20,
              ),
            ),
            const SizedBox(height: DesignTokens.spaceMd),
            Text(
              value,
              style: const TextStyle(
                fontSize: DesignTokens.fontSizeLg,
                fontWeight: DesignTokens.fontWeightBold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: DesignTokens.fontSizeSm,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _improvementCard(String subject, String score, double progress) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        border: Border.all(color: Colors.grey[200] ?? Colors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.all(DesignTokens.spaceMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  subject,
                  style: const TextStyle(
                    fontSize: DesignTokens.fontSizeBase,
                    fontWeight: DesignTokens.fontWeightBold,
                  ),
                ),
                Text(
                  score,
                  style: const TextStyle(
                    fontSize: DesignTokens.fontSizeBase,
                    color: Colors.orange,
                    fontWeight: DesignTokens.fontWeightBold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: DesignTokens.spaceSm),
            LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
              borderRadius: BorderRadius.circular(3),
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getDayStats() {
    return [
      {'day': 'Monday', 'quizzes': 3, 'score': 85},
      {'day': 'Tuesday', 'quizzes': 2, 'score': 78},
      {'day': 'Wednesday', 'quizzes': 4, 'score': 82},
      {'day': 'Thursday', 'quizzes': 3, 'score': 76},
      {'day': 'Friday', 'quizzes': 5, 'score': 88},
      {'day': 'Saturday', 'quizzes': 2, 'score': 80},
      {'day': 'Sunday', 'quizzes': 1, 'score': 72},
    ];
  }
}


