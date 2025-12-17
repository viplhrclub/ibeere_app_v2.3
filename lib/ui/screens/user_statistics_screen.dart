import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';

class UserStatisticsScreen extends StatefulWidget {
  const UserStatisticsScreen({super.key});

  static const String routeName = '/user-statistics';

  @override
  State<UserStatisticsScreen> createState() => _UserStatisticsScreenState();
}

class _UserStatisticsScreenState extends State<UserStatisticsScreen> {
  Map<String, dynamic>? _statistics;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchStatistics();
  }

  Future<void> _fetchStatistics() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await http.post(
        Uri.parse('https://api.ibeere.fun/api/get_users_statistics'),
        body: {'user_id': '1'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['error'] == false && data['data'] != null) {
          setState(() {
            _statistics = data['data'];
            _isLoading = false;
          });
        } else {
          setState(() {
            _statistics = _getMockStatistics();
            _errorMessage = 'Using demo data';
            _isLoading = false;
          });
        }
      } else {
        throw Exception('Server error');
      }
    } catch (e) {
      setState(() {
        _statistics = _getMockStatistics();
        _errorMessage = 'Using demo data';
        _isLoading = false;
      });
    }
  }

  Map<String, dynamic> _getMockStatistics() {
    return {
      'questions_answered': '1250',
      'correct_answers': '892',
      'strong_category': 'Science',
      'weak_category': 'History',
      'ratio1': '71.4',
      'best_position': '12',
      'coins_earned': '8540',
      'badges_earned': '15',
      'battles_won': '47',
      'daily_streak': '12',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IbeereDesignTokens.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            if (_isLoading)
              const Expanded(
                child: Center(child: CircularProgressIndicator()),
              )
            else
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _buildStatsGrid(),
                      const SizedBox(height: 20),
                      _buildAccuracyCard(),
                      const SizedBox(height: 20),
                      _buildCategoryStrength(),
                      const SizedBox(height: 20),
                      _buildAchievements(),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            IbeereDesignTokens.primaryPurple,
            IbeereDesignTokens.primaryPink,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: IbeereDesignTokens.primaryPurple.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              Expanded(
                child: Text(
                  'Your Statistics',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 48),
            ],
          ),
          if (_errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                _errorMessage!,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    final answered = _statistics?['questions_answered']?.toString() ?? '0';
    final correct = _statistics?['correct_answers']?.toString() ?? '0';
    final coins = _statistics?['coins_earned']?.toString() ?? '0';
    final battles = _statistics?['battles_won']?.toString() ?? '0';

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.4,
      children: [
        _buildStatCard('Questions\nAnswered', answered, Icons.quiz, IbeereDesignTokens.primaryPurple),
        _buildStatCard('Correct\nAnswers', correct, Icons.check_circle, IbeereDesignTokens.accentGreen),
        _buildStatCard('Coins\nEarned', coins, Icons.monetization_on, IbeereDesignTokens.accentYellow),
        _buildStatCard('Battles\nWon', battles, Icons.emoji_events, IbeereDesignTokens.primaryPink),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              color: IbeereDesignTokens.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: IbeereDesignTokens.textSecondary,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAccuracyCard() {
    final ratio = double.tryParse(_statistics?['ratio1']?.toString() ?? '0') ?? 0.0;
    final answered = int.tryParse(_statistics?['questions_answered']?.toString() ?? '0') ?? 0;
    final correct = int.tryParse(_statistics?['correct_answers']?.toString() ?? '0') ?? 0;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Accuracy Rate',
            style: TextStyle(
              color: IbeereDesignTokens.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: CircularProgressIndicator(
                  value: ratio / 100,
                  strokeWidth: 12,
                  backgroundColor: IbeereDesignTokens.textTertiary.withOpacity(0.2),
                  valueColor: AlwaysStoppedAnimation(IbeereDesignTokens.primaryPurple),
                ),
              ),
              Column(
                children: [
                  Text(
                    '${ratio.toStringAsFixed(1)}%',
                    style: TextStyle(
                      color: IbeereDesignTokens.textPrimary,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Accuracy',
                    style: TextStyle(
                      color: IbeereDesignTokens.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    correct.toString(),
                    style: TextStyle(
                      color: IbeereDesignTokens.accentGreen,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Correct',
                    style: TextStyle(
                      color: IbeereDesignTokens.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Container(
                width: 1,
                height: 40,
                color: IbeereDesignTokens.textTertiary.withOpacity(0.2),
              ),
              Column(
                children: [
                  Text(
                    (answered - correct).toString(),
                    style: TextStyle(
                      color: IbeereDesignTokens.primaryRed,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Wrong',
                    style: TextStyle(
                      color: IbeereDesignTokens.textSecondary,
                      fontSize: 12,
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

  Widget _buildCategoryStrength() {
    final strong = _statistics?['strong_category']?.toString() ?? 'Science';
    final weak = _statistics?['weak_category']?.toString() ?? 'History';

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Category Performance',
            style: TextStyle(
              color: IbeereDesignTokens.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildCategoryItem('Strongest', strong, IbeereDesignTokens.accentGreen, Icons.trending_up),
          const SizedBox(height: 12),
          _buildCategoryItem('Weakest', weak, IbeereDesignTokens.primaryRed, Icons.trending_down),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String label, String category, Color color, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: IbeereDesignTokens.textSecondary,
                  fontSize: 12,
                ),
              ),
              Text(
                category,
                style: TextStyle(
                  color: IbeereDesignTokens.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAchievements() {
    final badges = _statistics?['badges_earned']?.toString() ?? '15';
    final streak = _statistics?['daily_streak']?.toString() ?? '12';
    final bestRank = _statistics?['best_position']?.toString() ?? '12';

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Achievements',
            style: TextStyle(
              color: IbeereDesignTokens.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildAchievementItem('Badges', badges, Icons.emoji_events),
              ),
              Expanded(
                child: _buildAchievementItem('Day Streak', streak, Icons.local_fire_department),
              ),
              Expanded(
                child: _buildAchievementItem('Best Rank', '#$bestRank', Icons.military_tech),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                IbeereDesignTokens.primaryPurple,
                IbeereDesignTokens.primaryPink,
              ],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.white, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            color: IbeereDesignTokens.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: IbeereDesignTokens.textSecondary,
            fontSize: 11,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
