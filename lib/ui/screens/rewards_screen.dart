import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/design_tokens.dart';
import 'package:flutterquiz/ui/widgets/ibeere_cards.dart';
import 'package:flutterquiz/ui/widgets/ibeere_navigation.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  final List<_Reward> _rewards = [
    _Reward(
      id: '1',
      title: 'Quiz Master Badge',
      description: 'Complete 50 quizzes',
      icon: Icons.emoji_events,
      color: const Color(0xFFFFD700),
      isUnlocked: true,
      unlockedDate: '5 days ago',
      progress: 50,
      total: 50,
    ),
    _Reward(
      id: '2',
      title: 'Perfect Scorer',
      description: 'Score 100% on 5 quizzes',
      icon: Icons.star,
      color: const Color(0xFF5AC8FA),
      isUnlocked: true,
      unlockedDate: '2 weeks ago',
      progress: 5,
      total: 5,
    ),
    _Reward(
      id: '3',
      title: 'Streak King',
      description: 'Maintain 30 day streak',
      icon: Icons.local_fire_department,
      color: const Color(0xFFFF3B30),
      isUnlocked: false,
      progress: 12,
      total: 30,
    ),
    _Reward(
      id: '4',
      title: 'Knowledge Seeker',
      description: 'Complete all categories',
      icon: Icons.school,
      color: const Color(0xFF34C759),
      isUnlocked: false,
      progress: 5,
      total: 8,
    ),
    _Reward(
      id: '5',
      title: '1000 Points Club',
      description: 'Earn 1000 points total',
      icon: Icons.paid,
      color: const Color(0xFFFF9500),
      isUnlocked: true,
      unlockedDate: '1 month ago',
      progress: 1000,
      total: 1000,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final unlockedCount = _rewards.where((r) => r.isUnlocked).length;

    return Scaffold(
      backgroundColor: DesignTokens.background,
      appBar: const IbeereAppBar(
        title: 'Rewards & Badges',
        showBackButton: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Progress Summary
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    DesignTokens.primary.withOpacity(0.5),
                    DesignTokens.background,
                  ],
                ),
              ),
              padding: const EdgeInsets.all(DesignTokens.spaceLg),
              child: Column(
                children: [
                  Text(
                    'Achievements Progress',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: DesignTokens.spaceXl),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _ProgressStat(
                        label: 'Unlocked',
                        value: '$unlockedCount',
                        total: '${_rewards.length}',
                        color: DesignTokens.success,
                      ),
                      _ProgressStat(
                        label: 'Locked',
                        value: '${_rewards.length - unlockedCount}',
                        total: '${_rewards.length}',
                        color: DesignTokens.error,
                      ),
                      _ProgressStat(
                        label: 'Completion',
                        value: ((unlockedCount / _rewards.length) * 100)
                            .toStringAsFixed(0),
                        total: '%',
                        color: DesignTokens.primary,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Rewards List
            Padding(
              padding: const EdgeInsets.all(DesignTokens.spaceLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Badges & Achievements',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: DesignTokens.spaceMd),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _rewards.length,
                    itemBuilder: (context, index) {
                      final reward = _rewards[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: DesignTokens.spaceMd),
                        child: _RewardCard(reward: reward),
                      );
                    },
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

class _ProgressStat extends StatelessWidget {

  const _ProgressStat({
    required this.label,
    required this.value,
    required this.total,
    required this.color,
  });
  final String label;
  final String value;
  final String total;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: DesignTokens.fontSizeXl,
            fontWeight: DesignTokens.fontWeightBold,
            color: color,
          ),
        ),
        Text(
          total,
          style: TextStyle(
            fontSize: DesignTokens.fontSizeSm,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: DesignTokens.spaceSm),
        Text(
          label,
          style: const TextStyle(
            fontSize: DesignTokens.fontSizeSm,
            fontWeight: DesignTokens.fontWeightMedium,
          ),
        ),
      ],
    );
  }
}

class _RewardCard extends StatelessWidget {

  const _RewardCard({required this.reward});
  final _Reward reward;

  @override
  Widget build(BuildContext context) {
    return IbeereCard(
      elevation: reward.isUnlocked ? 2 : 0,
      backgroundColor: reward.isUnlocked
          ? reward.color.withOpacity(0.5)
          : Colors.grey.withOpacity(0.5),
      padding: const EdgeInsets.all(DesignTokens.spaceMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: reward.isUnlocked
                            ? reward.color
                            : Colors.grey[400],
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        reward.icon,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: DesignTokens.spaceMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            reward.title,
                            style: const TextStyle(
                              fontSize: DesignTokens.fontSizeBase,
                              fontWeight: DesignTokens.fontWeightBold,
                            ),
                          ),
                          const SizedBox(height: DesignTokens.spaceSm),
                          Text(
                            reward.description,
                            style: TextStyle(
                              fontSize: DesignTokens.fontSizeSm,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (reward.isUnlocked)
                Icon(
                  Icons.check_circle,
                  color: reward.color,
                  size: 24,
                ),
            ],
          ),
          const SizedBox(height: DesignTokens.spaceMd),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Progress',
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeSm,
                      fontWeight: DesignTokens.fontWeightMedium,
                    ),
                  ),
                  Text(
                    '${reward.progress}/${reward.total}',
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeSm,
                      fontWeight: DesignTokens.fontWeightBold,
                      color: reward.isUnlocked ? reward.color : Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: DesignTokens.spaceSm),
              ClipRRect(
                borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
                child: LinearProgressIndicator(
                  value: reward.progress / reward.total,
                  minHeight: 6,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    reward.isUnlocked ? reward.color : Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          if (reward.isUnlocked && reward.unlockedDate != null) ...[
            const SizedBox(height: DesignTokens.spaceMd),
            Text(
              'Unlocked ${reward.unlockedDate}',
              style: TextStyle(
                fontSize: DesignTokens.fontSizeSm,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _Reward {

  _Reward({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.isUnlocked,
    required this.progress, required this.total, this.unlockedDate,
  });
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final bool isUnlocked;
  final String? unlockedDate;
  final int progress;
  final int total;
}


