import 'package:flutter/material.dart';
import '../../core/theme/design_tokens.dart';
import '../widgets/ibeere_navigation.dart';
import '../widgets/ibeere_cards.dart';
import '../widgets/ibeere_buttons.dart';

/// Home/Dashboard Screen for Ibeere
/// 
/// Main dashboard showing quiz categories, ongoing quizzes, and quick stats
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentBottomNavIndex = 0;

  final List<_QuizCategory> _categories = [
    _QuizCategory(
      title: 'Science',
      subtitle: '45 Questions',
      icon: Icons.science,
      iconColor: Colors.white,
      cardColor: Color(0xFF7C3AED),
      statsText: '92% Pass Rate',
    ),
    _QuizCategory(
      title: 'History',
      subtitle: '38 Questions',
      icon: Icons.history,
      iconColor: Colors.white,
      cardColor: Color(0xFFDC2626),
      statsText: '88% Pass Rate',
    ),
    _QuizCategory(
      title: 'Geography',
      subtitle: '42 Questions',
      icon: Icons.public,
      iconColor: Colors.white,
      cardColor: Color(0xFF059669),
      statsText: '85% Pass Rate',
    ),
    _QuizCategory(
      title: 'Literature',
      subtitle: '35 Questions',
      icon: Icons.library_books,
      iconColor: Colors.white,
      cardColor: Color(0xFFEA580C),
      statsText: '78% Pass Rate',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.background,
      appBar: IbeereAppBar(
        title: 'Ibeere',
        centerTitle: false,
        showBackButton: false,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: DesignTokens.primary),
            onPressed: () {
              // Navigate to notifications
            },
          ),
          IconButton(
            icon: Icon(Icons.settings_outlined, color: DesignTokens.primary),
            onPressed: () {
              // Navigate to settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Padding(
              padding: EdgeInsets.all(DesignTokens.spaceLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome Back!',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: DesignTokens.fontWeightBold,
                    ),
                  ),
                  SizedBox(height: DesignTokens.spaceSm),
                  Text(
                    'Continue your learning journey',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            // Quick Stats Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: DesignTokens.spaceLg),
              child: Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      title: 'Quizzes',
                      value: '24',
                      icon: Icons.quiz,
                      color: DesignTokens.primary,
                    ),
                  ),
                  SizedBox(width: DesignTokens.spaceMd),
                  Expanded(
                    child: _StatCard(
                      title: 'Points',
                      value: '2,340',
                      icon: Icons.star,
                      color: DesignTokens.warning,
                    ),
                  ),
                  SizedBox(width: DesignTokens.spaceMd),
                  Expanded(
                    child: _StatCard(
                      title: 'Streak',
                      value: '12',
                      icon: Icons.local_fire_department,
                      color: DesignTokens.error,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: DesignTokens.spaceLg),

            // Ongoing Quiz Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: DesignTokens.spaceLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Continue Learning',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      IbeereTextButton(
                        label: 'View All',
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: DesignTokens.spaceMd),
                  _OngoingQuizCard(
                    title: 'Advanced Biology',
                    category: 'Science',
                    progress: 0.65,
                    timeLeft: '15 mins',
                  ),
                ],
              ),
            ),
            SizedBox(height: DesignTokens.spaceXl),

            // Categories Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: DesignTokens.spaceLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Quiz Categories',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      IbeereTextButton(
                        label: 'View All',
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: DesignTokens.spaceMd),
                ],
              ),
            ),

            // Categories Grid
            Padding(
              padding: EdgeInsets.symmetric(horizontal: DesignTokens.spaceLg),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: DesignTokens.spaceMd,
                  mainAxisSpacing: DesignTokens.spaceMd,
                  childAspectRatio: 1.0,
                ),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  return IbeereQuizCard(
                    title: category.title,
                    subtitle: category.subtitle,
                    icon: category.icon,
                    iconColor: category.iconColor,
                    cardColor: category.cardColor,
                    statsText: category.statsText,
                    onTap: () {
                      // Navigate to quiz
                    },
                    height: 140,
                  );
                },
              ),
            ),
            SizedBox(height: DesignTokens.spaceXl),

            // Leaderboard Preview Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: DesignTokens.spaceLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Top Performers',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      IbeereTextButton(
                        label: 'View All',
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: DesignTokens.spaceMd),
                  ...[
                    _LeaderboardItem(
                      rank: 1,
                      name: 'Sarah Johnson',
                      points: '5,240',
                      badge: '🏆',
                      avatarColor: Color(0xFF007AFF),
                    ),
                    _LeaderboardItem(
                      rank: 2,
                      name: 'Ahmed Hassan',
                      points: '4,890',
                      badge: '⭐',
                      avatarColor: Color(0xFF5AC8FA),
                    ),
                    _LeaderboardItem(
                      rank: 3,
                      name: 'Emily Chen',
                      points: '4,670',
                      badge: '🎖️',
                      avatarColor: Color(0xFFFF2D55),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(height: DesignTokens.spaceXl),
          ],
        ),
      ),
      bottomNavigationBar: IbeereBottomNavigation(
        currentIndex: _currentBottomNavIndex,
        onTap: (index) {
          setState(() => _currentBottomNavIndex = index);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

/// Quiz Category Model
class _QuizCategory {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Color cardColor;
  final String? statsText;

  _QuizCategory({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.cardColor,
    this.statsText,
  });
}

/// Stat Card Widget
class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return IbeereCard(
      backgroundColor: color.withOpacity(0.1),
      borderRadius: DesignTokens.radiusLg,
      padding: EdgeInsets.all(DesignTokens.spaceMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
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

/// Ongoing Quiz Card
class _OngoingQuizCard extends StatelessWidget {
  final String title;
  final String category;
  final double progress;
  final String timeLeft;

  const _OngoingQuizCard({
    required this.title,
    required this.category,
    required this.progress,
    required this.timeLeft,
  });

  @override
  Widget build(BuildContext context) {
    return IbeereCard(
      backgroundColor: DesignTokens.primary.withOpacity(0.08),
      borderRadius: DesignTokens.radiusLg,
      padding: EdgeInsets.all(DesignTokens.spaceLg),
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: DesignTokens.fontSizeBase,
                        fontWeight: DesignTokens.fontWeightBold,
                      ),
                    ),
                    SizedBox(height: DesignTokens.spaceSm),
                    Text(
                      category,
                      style: TextStyle(
                        fontSize: DesignTokens.fontSizeSm,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward,
                color: DesignTokens.primary,
              ),
            ],
          ),
          SizedBox(height: DesignTokens.spaceLg),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Progress',
                          style: TextStyle(
                            fontSize: DesignTokens.fontSizeSm,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          '${(progress * 100).toStringAsFixed(0)}%',
                          style: TextStyle(
                            fontSize: DesignTokens.fontSizeSm,
                            fontWeight: DesignTokens.fontWeightBold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: DesignTokens.spaceSm),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 6,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          DesignTokens.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: DesignTokens.spaceLg),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(Icons.timer, color: DesignTokens.warning, size: 20),
                  SizedBox(height: DesignTokens.spaceSm),
                  Text(
                    timeLeft,
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeSm,
                      fontWeight: DesignTokens.fontWeightMedium,
                      color: DesignTokens.warning,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Leaderboard Item Widget
class _LeaderboardItem extends StatelessWidget {
  final int rank;
  final String name;
  final String points;
  final String badge;
  final Color avatarColor;

  const _LeaderboardItem({
    required this.rank,
    required this.name,
    required this.points,
    required this.badge,
    required this.avatarColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: DesignTokens.spaceMd),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: avatarColor.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '$rank',
              style: TextStyle(
                fontSize: DesignTokens.fontSizeBase,
                fontWeight: DesignTokens.fontWeightBold,
                color: avatarColor,
              ),
            ),
          ),
          SizedBox(width: DesignTokens.spaceMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeBase,
                    fontWeight: DesignTokens.fontWeightSemibold,
                  ),
                ),
                SizedBox(height: DesignTokens.spaceSm),
                Text(
                  '$points points',
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeSm,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Text(
            badge,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
