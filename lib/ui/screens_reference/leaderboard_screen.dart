import 'package:flutter/material.dart';
import '../../core/theme/design_tokens.dart';
import '../widgets/ibeere_cards.dart';
import '../widgets/ibeere_navigation.dart';
import '../widgets/ibeere_inputs.dart';

/// Leaderboard Screen for Ibeere
/// 
/// Display top performers and user rankings
class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({Key? key}) : super(key: key);

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTab = 0;

  final List<_LeaderboardUser> _allTimeUsers = [
    _LeaderboardUser(
      rank: 1,
      name: 'Sarah Johnson',
      points: 5240,
      quizzes: 142,
      streak: 28,
      avatar: 'SJ',
      badge: '👑',
    ),
    _LeaderboardUser(
      rank: 2,
      name: 'Ahmed Hassan',
      points: 4890,
      quizzes: 128,
      streak: 15,
      avatar: 'AH',
      badge: '🥈',
    ),
    _LeaderboardUser(
      rank: 3,
      name: 'Emily Chen',
      points: 4670,
      quizzes: 119,
      streak: 22,
      avatar: 'EC',
      badge: '🥉',
    ),
    _LeaderboardUser(
      rank: 4,
      name: 'Marcus Wilson',
      points: 4320,
      quizzes: 105,
      streak: 10,
      avatar: 'MW',
    ),
    _LeaderboardUser(
      rank: 5,
      name: 'Lisa Anderson',
      points: 4100,
      quizzes: 98,
      streak: 8,
      avatar: 'LA',
    ),
    _LeaderboardUser(
      rank: 6,
      name: 'John Anderson',
      points: 3890,
      quizzes: 92,
      streak: 12,
      avatar: 'JA',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.background,
      appBar: IbeereAppBar(
        title: 'Leaderboard',
        centerTitle: false,
        showBackButton: false,
      ),
      body: Column(
        children: [
          // Top 3 Section
          Padding(
            padding: EdgeInsets.all(DesignTokens.spaceLg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Top Performers',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: DesignTokens.spaceLg),
                SizedBox(
                  height: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // 2nd Place
                      _TopThreeCard(
                        rank: 2,
                        height: 120,
                        user: _allTimeUsers[1],
                      ),
                      // 1st Place
                      _TopThreeCard(
                        rank: 1,
                        height: 160,
                        user: _allTimeUsers[0],
                      ),
                      // 3rd Place
                      _TopThreeCard(
                        rank: 3,
                        height: 100,
                        user: _allTimeUsers[2],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Tabs
          Padding(
            padding: EdgeInsets.symmetric(horizontal: DesignTokens.spaceLg),
            child: IbeereTabBar(
              tabs: ['All Time', 'This Month', 'This Week'],
              controller: _tabController,
              onTap: (index) {
                setState(() => _selectedTab = index);
              },
            ),
          ),
          SizedBox(height: DesignTokens.spaceMd),

          // Leaderboard List
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _LeaderboardList(users: _allTimeUsers),
                _LeaderboardList(users: _allTimeUsers),
                _LeaderboardList(users: _allTimeUsers),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Top 3 Card Widget
class _TopThreeCard extends StatelessWidget {
  final int rank;
  final double height;
  final _LeaderboardUser user;

  const _TopThreeCard({
    required this.rank,
    required this.height,
    required this.user,
  });

  Color _getRankColor() {
    switch (rank) {
      case 1:
        return Color(0xFFFFD700); // Gold
      case 2:
        return Color(0xFFC0C0C0); // Silver
      case 3:
        return Color(0xFFCD7F32); // Bronze
      default:
        return DesignTokens.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (user.badge != null)
          Text(
            user.badge!,
            style: TextStyle(fontSize: 28),
          ),
        SizedBox(height: DesignTokens.spaceSm),
        Container(
          width: 60,
          height: height,
          decoration: BoxDecoration(
            color: _getRankColor().withOpacity(0.15),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(DesignTokens.radiusMd),
              topRight: Radius.circular(DesignTokens.radiusMd),
            ),
            border: Border.all(
              color: _getRankColor(),
              width: 2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: _getRankColor(),
                child: Text(
                  user.avatar,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                    '${user.points}',
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeBase,
                      fontWeight: DesignTokens.fontWeightBold,
                      color: _getRankColor(),
                    ),
                  ),
                  Text(
                    'pts',
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeSm,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Leaderboard List Widget
class _LeaderboardList extends StatelessWidget {
  final List<_LeaderboardUser> users;

  const _LeaderboardList({required this.users});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(DesignTokens.spaceLg),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        final isTopThree = index < 3;

        return Padding(
          padding: EdgeInsets.only(bottom: DesignTokens.spaceMd),
          child: _LeaderboardListItem(user: user, isTopThree: isTopThree),
        );
      },
    );
  }
}

/// Leaderboard List Item
class _LeaderboardListItem extends StatelessWidget {
  final _LeaderboardUser user;
  final bool isTopThree;

  const _LeaderboardListItem({
    required this.user,
    required this.isTopThree,
  });

  Color _getRankColor() {
    switch (user.rank) {
      case 1:
        return Color(0xFFFFD700);
      case 2:
        return Color(0xFFC0C0C0);
      case 3:
        return Color(0xFFCD7F32);
      default:
        return DesignTokens.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return IbeereCard(
      backgroundColor: isTopThree
          ? _getRankColor().withOpacity(0.05)
          : DesignTokens.surface,
      borderColor: isTopThree ? _getRankColor().withOpacity(0.3) : null,
      elevation: isTopThree ? 2 : 0,
      padding: EdgeInsets.all(DesignTokens.spaceMd),
      child: Row(
        children: [
          // Rank
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: _getRankColor(),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '${user.rank}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: DesignTokens.fontWeightBold,
                fontSize: DesignTokens.fontSizeBase,
              ),
            ),
          ),
          SizedBox(width: DesignTokens.spaceMd),

          // Avatar & Name
          CircleAvatar(
            backgroundColor: DesignTokens.primary.withOpacity(0.2),
            child: Text(
              user.avatar,
              style: TextStyle(
                color: DesignTokens.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: DesignTokens.spaceMd),

          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeBase,
                    fontWeight: DesignTokens.fontWeightBold,
                  ),
                ),
                SizedBox(height: DesignTokens.spaceSm),
                Row(
                  children: [
                    Icon(
                      Icons.quiz,
                      size: 14,
                      color: Colors.grey[600],
                    ),
                    SizedBox(width: DesignTokens.spaceSm),
                    Text(
                      '${user.quizzes} quizzes',
                      style: TextStyle(
                        fontSize: DesignTokens.fontSizeSm,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(width: DesignTokens.spaceMd),
                    Icon(
                      Icons.local_fire_department,
                      size: 14,
                      color: DesignTokens.error,
                    ),
                    SizedBox(width: DesignTokens.spaceSm),
                    Text(
                      '${user.streak} day streak',
                      style: TextStyle(
                        fontSize: DesignTokens.fontSizeSm,
                        color: DesignTokens.error,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Points
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${user.points}',
                style: TextStyle(
                  fontSize: DesignTokens.fontSizeLg,
                  fontWeight: DesignTokens.fontWeightBold,
                  color: _getRankColor(),
                ),
              ),
              Text(
                'points',
                style: TextStyle(
                  fontSize: DesignTokens.fontSizeSm,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Leaderboard User Model
class _LeaderboardUser {
  final int rank;
  final String name;
  final int points;
  final int quizzes;
  final int streak;
  final String avatar;
  final String? badge;

  _LeaderboardUser({
    required this.rank,
    required this.name,
    required this.points,
    required this.quizzes,
    required this.streak,
    required this.avatar,
    this.badge,
  });
}
