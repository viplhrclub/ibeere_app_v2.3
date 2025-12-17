import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/design_tokens.dart';
import 'package:flutterquiz/ui/widgets/ibeere_buttons.dart';

class ChallengeScreen extends StatefulWidget {
  const ChallengeScreen({super.key});

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  final List<Map<String, dynamic>> _activeChallenges = [
    {
      'opponent': 'Alice Johnson',
      'category': 'Physics',
      'progress': 5,
      'total': 10,
      'yourScore': 8,
      'theirScore': 6,
      'status': 'In Progress',
    },
    {
      'opponent': 'Bob Smith',
      'category': 'Mathematics',
      'progress': 10,
      'total': 10,
      'yourScore': 9,
      'theirScore': 7,
      'status': 'Completed',
    },
  ];

  final List<Map<String, dynamic>> _pendingChallenges = [
    {
      'opponent': 'Carol Davis',
      'category': 'Chemistry',
      'difficulty': 'Hard',
      'questions': 15,
    },
    {
      'opponent': 'David Wilson',
      'category': 'Biology',
      'difficulty': 'Medium',
      'questions': 10,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: DesignTokens.background,
        appBar: AppBar(
          backgroundColor: DesignTokens.background,
          elevation: 0,
          title: Text(
            'Challenges',
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
            tabs: [
              Tab(text: 'Active (${_activeChallenges.length})'),
              Tab(text: 'Pending (${_pendingChallenges.length})'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildActiveChallengesTab(),
            _buildPendingChallengesTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveChallengesTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(DesignTokens.spaceLg),
      itemCount: _activeChallenges.length,
      itemBuilder: (context, index) {
        final challenge = _activeChallenges[index];
        final progress = challenge['progress'] as int;
        final total = challenge['total'] as int;
        final isCompleted = challenge['status'] == 'Completed';

        return Container(
          margin: const EdgeInsets.only(bottom: DesignTokens.spaceMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
            border: Border.all(color: Colors.grey[200] ?? Colors.grey),
          ),
          child: Padding(
            padding: const EdgeInsets.all(DesignTokens.spaceLg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'vs ${challenge['opponent']}',
                          style: const TextStyle(
                            fontSize: DesignTokens.fontSizeBase,
                            fontWeight: DesignTokens.fontWeightBold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          challenge['category'] as String,
                          style: TextStyle(
                            fontSize: DesignTokens.fontSizeSm,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: DesignTokens.spaceSm,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: isCompleted ? Colors.green[100] : Colors.blue[100],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        challenge['status'] as String,
                        style: TextStyle(
                          fontSize: DesignTokens.fontSizeSm,
                          color: isCompleted ? Colors.green[700] : Colors.blue[700],
                          fontWeight: DesignTokens.fontWeightBold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: DesignTokens.spaceXl),

                // Progress
                Column(
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
                            fontWeight: DesignTokens.fontWeightMedium,
                          ),
                        ),
                        Text(
                          '$progress/$total',
                          style: const TextStyle(
                            fontSize: DesignTokens.fontSizeSm,
                            fontWeight: DesignTokens.fontWeightBold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: DesignTokens.spaceSm),
                    LinearProgressIndicator(
                      value: progress / total,
                      minHeight: 6,
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation<Color>(DesignTokens.primary),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ],
                ),
                const SizedBox(height: DesignTokens.spaceXl),

                // Score Comparison
                Container(
                  padding: const EdgeInsets.all(DesignTokens.spaceMd),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            'You',
                            style: TextStyle(
                              fontSize: DesignTokens.fontSizeSm,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${challenge['yourScore']}',
                            style: TextStyle(
                              fontSize: DesignTokens.fontSizeLg,
                              fontWeight: DesignTokens.fontWeightBold,
                              color: DesignTokens.primary,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.grey[300],
                      ),
                      Column(
                        children: [
                          Text(
                            challenge['opponent'] as String,
                            style: TextStyle(
                              fontSize: DesignTokens.fontSizeSm,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${challenge['theirScore']}',
                            style: TextStyle(
                              fontSize: DesignTokens.fontSizeLg,
                              fontWeight: DesignTokens.fontWeightBold,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: DesignTokens.spaceXl),

                // Action Button
                if (!isCompleted)
                  IbeerePrimaryButton(
                    label: 'Continue Challenge',
                    isFullWidth: true,
                    onPressed: () {},
                  )
                else
                  IbeereSecondaryButton(
                    label: 'Challenge Again',
                    isFullWidth: true,
                    onPressed: () {},
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPendingChallengesTab() {
    if (_pendingChallenges.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.sports_esports_rounded,
              color: Colors.grey[400],
              size: 60,
            ),
            const SizedBox(height: DesignTokens.spaceLg),
            Text(
              'No pending challenges',
              style: TextStyle(
                fontSize: DesignTokens.fontSizeBase,
                color: Colors.grey[600],
                fontWeight: DesignTokens.fontWeightMedium,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(DesignTokens.spaceLg),
      itemCount: _pendingChallenges.length,
      itemBuilder: (context, index) {
        final challenge = _pendingChallenges[index];
        return Container(
          margin: const EdgeInsets.only(bottom: DesignTokens.spaceMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
            border: Border.all(color: Colors.grey[200] ?? Colors.grey),
          ),
          child: Padding(
            padding: const EdgeInsets.all(DesignTokens.spaceLg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          challenge['opponent'] as String,
                          style: const TextStyle(
                            fontSize: DesignTokens.fontSizeBase,
                            fontWeight: DesignTokens.fontWeightBold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${challenge['category']} • ${challenge['difficulty']}',
                          style: TextStyle(
                            fontSize: DesignTokens.fontSizeSm,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: DesignTokens.spaceSm,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange[100],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Pending',
                        style: TextStyle(
                          fontSize: DesignTokens.fontSizeSm,
                          color: Colors.orange[700],
                          fontWeight: DesignTokens.fontWeightBold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: DesignTokens.spaceMd),
                Text(
                  '${challenge['questions']} questions',
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeSm,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: DesignTokens.spaceXl),
                Row(
                  children: [
                    Expanded(
                      child: IbeereSecondaryButton(
                        label: 'Decline',
                        onPressed: () {
                          setState(() => _pendingChallenges.removeAt(index));
                        },
                      ),
                    ),
                    const SizedBox(width: DesignTokens.spaceMd),
                    Expanded(
                      child: IbeerePrimaryButton(
                        label: 'Accept',
                        onPressed: () {
                          _activeChallenges.add({
                            'opponent': challenge['opponent'],
                            'category': challenge['category'],
                            'progress': 0,
                            'total': challenge['questions'],
                            'yourScore': 0,
                            'theirScore': 0,
                            'status': 'In Progress',
                          });
                          setState(() => _pendingChallenges.removeAt(index));
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

