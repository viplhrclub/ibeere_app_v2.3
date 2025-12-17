import 'package:flutter/material.dart';
import '../../core/theme/design_tokens.dart';
import '../widgets/ibeere_buttons.dart';
import '../widgets/ibeere_cards.dart';

class BadgesScreen extends StatefulWidget {
  const BadgesScreen({Key? key}) : super(key: key);

  @override
  State<BadgesScreen> createState() => _BadgesScreenState();
}

class _BadgesScreenState extends State<BadgesScreen> {
  final List<Map<String, dynamic>> _badges = [
    {
      'name': 'First Steps',
      'description': 'Complete your first quiz',
      'icon': '🎯',
      'unlocked': true,
      'unlockedDate': '2025-01-15',
    },
    {
      'name': 'Week Warrior',
      'description': '7-day quiz streak',
      'icon': '⚡',
      'unlocked': true,
      'unlockedDate': '2025-01-20',
    },
    {
      'name': 'Perfect Score',
      'description': 'Score 100% on a quiz',
      'icon': '🌟',
      'unlocked': false,
      'unlockedDate': null,
    },
    {
      'name': 'Speed Demon',
      'description': 'Complete 10 quizzes in speed mode',
      'icon': '💨',
      'unlocked': false,
      'unlockedDate': null,
    },
    {
      'name': 'Social Butterfly',
      'description': 'Invite 5 friends',
      'icon': '🦋',
      'unlocked': true,
      'unlockedDate': '2025-02-01',
    },
    {
      'name': 'Champion',
      'description': '#1 on leaderboard for 1 week',
      'icon': '👑',
      'unlocked': false,
      'unlockedDate': null,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final unlockedCount = _badges.where((b) => b['unlocked']).length;

    return Scaffold(
      backgroundColor: DesignTokens.background,
      appBar: AppBar(
        backgroundColor: DesignTokens.background,
        elevation: 0,
        title: Text(
          'Badges',
          style: TextStyle(
            color: DesignTokens.primary,
            fontWeight: DesignTokens.fontWeightBold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: DesignTokens.primary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(DesignTokens.spaceLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Stats
            Container(
              padding: EdgeInsets.all(DesignTokens.spaceLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [DesignTokens.primary, Colors.blue[600]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        'Badges Earned',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: DesignTokens.fontSizeSm,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '$unlockedCount/${_badges.length}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: DesignTokens.fontSizeXxl,
                          fontWeight: DesignTokens.fontWeightBold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 1,
                    height: 60,
                    color: Colors.white.withOpacity(0.3),
                  ),
                  Column(
                    children: [
                      Text(
                        'Progress',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: DesignTokens.fontSizeSm,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '${((unlockedCount / _badges.length) * 100).toStringAsFixed(0)}%',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: DesignTokens.fontSizeXxl,
                          fontWeight: DesignTokens.fontWeightBold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: DesignTokens.spaceXxl),

            // Unlocked Badges
            Text(
              'Unlocked',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: DesignTokens.fontWeightBold,
              ),
            ),
            SizedBox(height: DesignTokens.spaceMd),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: 1,
              mainAxisSpacing: DesignTokens.spaceMd,
              crossAxisSpacing: DesignTokens.spaceMd,
              children: _badges
                  .where((b) => b['unlocked'])
                  .map((badge) => _badgeCard(badge, true))
                  .toList(),
            ),
            SizedBox(height: DesignTokens.spaceXxl),

            // Locked Badges
            Text(
              'Locked',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: DesignTokens.fontWeightBold,
              ),
            ),
            SizedBox(height: DesignTokens.spaceMd),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: 1,
              mainAxisSpacing: DesignTokens.spaceMd,
              crossAxisSpacing: DesignTokens.spaceMd,
              children: _badges
                  .where((b) => !b['unlocked'])
                  .map((badge) => _badgeCard(badge, false))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _badgeCard(Map<String, dynamic> badge, bool isUnlocked) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(badge['name']),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  badge['icon'],
                  style: TextStyle(fontSize: 60),
                ),
                SizedBox(height: DesignTokens.spaceMd),
                Text(badge['description']),
                if (isUnlocked && badge['unlockedDate'] != null) ...[
                  SizedBox(height: DesignTokens.spaceMd),
                  Text(
                    'Unlocked: ${badge['unlockedDate']}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: DesignTokens.fontSizeSm,
                    ),
                  ),
                ],
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Close'),
              ),
            ],
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
          border: Border.all(
            color: isUnlocked ? DesignTokens.primary : Colors.grey[300]!,
            width: isUnlocked ? 2 : 1,
          ),
          boxShadow: isUnlocked
              ? [
            BoxShadow(
              color: DesignTokens.primary.withOpacity(0.1),
              blurRadius: 8,
            ),
          ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                if (!isUnlocked)
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                  ),
                Text(
                  badge['icon'],
                  style: TextStyle(
                    fontSize: 32,
                    color: isUnlocked ? null : Colors.grey[400],
                  ),
                ),
                if (!isUnlocked)
                  Icon(
                    Icons.lock,
                    color: Colors.grey[600],
                    size: 16,
                  ),
              ],
            ),
            SizedBox(height: DesignTokens.spaceSm),
            Text(
              badge['name'],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: DesignTokens.fontSizeSm,
                fontWeight: DesignTokens.fontWeightMedium,
                color: isUnlocked ? Colors.grey[800] : Colors.grey[600],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
