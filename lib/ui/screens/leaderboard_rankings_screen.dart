import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';

class LeaderboardRankingsScreen extends StatefulWidget {
  const LeaderboardRankingsScreen({super.key});

  static const String routeName = '/leaderboard-rankings';

  @override
  State<LeaderboardRankingsScreen> createState() => _LeaderboardRankingsScreenState();
}

class _LeaderboardRankingsScreenState extends State<LeaderboardRankingsScreen> {
  String _selectedPeriod = 'Monthly';
  List<Map<String, dynamic>> _leaderboardData = [];
  Map<String, dynamic>? _myRank;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchLeaderboard();
  }

  Future<void> _fetchLeaderboard() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      String endpoint = 'https://api.ibeere.fun/api/get_monthly_leaderboard';
      if (_selectedPeriod == 'Daily') {
        endpoint = 'https://api.ibeere.fun/api/get_daily_leaderboard';
      } else if (_selectedPeriod == 'Weekly') {
        endpoint = 'https://api.ibeere.fun/api/get_globle_leaderboard';
      }

      final response = await http.post(Uri.parse(endpoint));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['error'] == false) {
          final leaderboardData = data['data'];
          
          setState(() {
            _myRank = leaderboardData['my_rank'] as Map<String, dynamic>?;
            
            List<Map<String, dynamic>> allUsers = [];
            if (leaderboardData['top_three_ranks'] != null) {
              allUsers.addAll(List<Map<String, dynamic>>.from(leaderboardData['top_three_ranks']));
            }
            if (leaderboardData['other_users_rank'] != null) {
              allUsers.addAll(List<Map<String, dynamic>>.from(leaderboardData['other_users_rank']));
            }
            
            _leaderboardData = allUsers;
            _isLoading = false;
          });
        } else {
          setState(() {
            _errorMessage = data['message'] ?? 'Failed to load leaderboard';
            _isLoading = false;
            _leaderboardData = _getMockData();
          });
        }
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Using demo data';
        _isLoading = false;
        _leaderboardData = _getMockData();
      });
    }
  }

  List<Map<String, dynamic>> _getMockData() {
    return [
      {'user_rank': '1', 'name': 'Melissa_lin', 'score': '52800', 'profile': ''},
      {'user_rank': '2', 'name': 'Sarah_Johnson', 'score': '45600', 'profile': ''},
      {'user_rank': '3', 'name': 'Alex_Parker', 'score': '38900', 'profile': ''},
      {'user_rank': '4', 'name': 'John_Doe', 'score': '34500', 'profile': ''},
      {'user_rank': '5', 'name': 'Emma_Wilson', 'score': '32100', 'profile': ''},
      {'user_rank': '6', 'name': 'David_Brown', 'score': '29800', 'profile': ''},
      {'user_rank': '7', 'name': 'Lisa_Anderson', 'score': '27600', 'profile': ''},
      {'user_rank': '8', 'name': 'Michael_Lee', 'score': '25400', 'profile': ''},
    ];
  }

  void _changePeriod(String period) {
    if (_selectedPeriod != period) {
      setState(() {
        _selectedPeriod = period;
      });
      _fetchLeaderboard();
    }
  }

  Color _getRankColor(int rank) {
    if (rank == 1) return const Color(0xFFFFD700);
    if (rank == 2) return const Color(0xFFC0C0C0);
    if (rank == 3) return const Color(0xFFCD7F32);
    
    final colors = [
      IbeereDesignTokens.primaryPurple,
      IbeereDesignTokens.primaryPink,
      IbeereDesignTokens.accentCyan,
      IbeereDesignTokens.accentGreen,
      IbeereDesignTokens.accentYellow,
    ];
    return colors[(rank - 4) % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IbeereDesignTokens.backgroundLight,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 100,
              right: -30,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: const Color(0xFF8B5CF6).withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: 150,
              left: -40,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: const Color(0xFFEC4899).withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Column(
              children: [
                _buildHeader(),
                _buildPeriodSelector(),
                const SizedBox(height: 24),
                if (_isLoading)
                  const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                else if (_leaderboardData.isEmpty)
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.emoji_events_outlined,
                            size: 64,
                            color: IbeereDesignTokens.textSecondary,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No rankings available yet',
                            style: TextStyle(
                              color: IbeereDesignTokens.textSecondary,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Expanded(child: _buildRankingsList()),
              ],
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
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: IbeereDesignTokens.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
          Expanded(
            child: Text(
              'Leaderboard',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: IbeereDesignTokens.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Expanded(child: _buildPeriodButton('Daily')),
          const SizedBox(width: 12),
          Expanded(child: _buildPeriodButton('Weekly')),
          const SizedBox(width: 12),
          Expanded(child: _buildPeriodButton('Monthly')),
        ],
      ),
    );
  }

  Widget _buildPeriodButton(String period) {
    final isSelected = _selectedPeriod == period;
    return GestureDetector(
      onTap: () => _changePeriod(period),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    IbeereDesignTokens.primaryPurple,
                    IbeereDesignTokens.primaryPink,
                  ],
                )
              : null,
          color: isSelected ? null : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? null
              : Border.all(
                  color: IbeereDesignTokens.textTertiary.withOpacity(0.2),
                  width: 1,
                ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: IbeereDesignTokens.primaryPurple.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Text(
          period,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : IbeereDesignTokens.textSecondary,
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildRankingsList() {
    final top3 = _leaderboardData.take(3).toList();
    final others = _leaderboardData.skip(3).toList();

    return SingleChildScrollView(
      child: Column(
        children: [
          if (top3.length >= 3) _buildTopThree() else _buildStandardTopThree(),
          const SizedBox(height: 24),
          if (others.isNotEmpty) _buildOtherRankings(others),
        ],
      ),
    );
  }

  Widget _buildTopThree() {
    if (_leaderboardData.length < 3) {
      return _buildStandardTopThree();
    }

    final second = _leaderboardData.firstWhere((p) => p['user_rank'].toString() == '2', orElse: () => _leaderboardData[1]);
    final first = _leaderboardData.firstWhere((p) => p['user_rank'].toString() == '1', orElse: () => _leaderboardData[0]);
    final third = _leaderboardData.firstWhere((p) => p['user_rank'].toString() == '3', orElse: () => _leaderboardData.length > 2 ? _leaderboardData[2] : {});

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (second != null) _buildTopCard(second, 2, 130),
          const SizedBox(width: 16),
          if (first != null) _buildTopCard(first, 1, 160),
          const SizedBox(width: 16),
          if (third.isNotEmpty) _buildTopCard(third, 3, 120),
        ],
      ),
    );
  }

  Widget _buildStandardTopThree() {
    final mock = [
      {'user_rank': '2', 'name': 'Sarah_Johnson', 'score': '45600', 'profile': ''},
      {'user_rank': '1', 'name': 'Melissa_lin', 'score': '52800', 'profile': ''},
      {'user_rank': '3', 'name': 'Alex_Parker', 'score': '38900', 'profile': ''},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTopCard(mock[0], 2, 130),
          const SizedBox(width: 16),
          _buildTopCard(mock[1], 1, 160),
          const SizedBox(width: 16),
          _buildTopCard(mock[2], 3, 120),
        ],
      ),
    );
  }

  Widget _buildTopCard(Map<String, dynamic> player, int rank, double height) {
    final rankColor = _getRankColor(rank);
    final points = player['score']?.toString() ?? '0';
    final name = player['name']?.toString() ?? 'User';

    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [rankColor, rankColor.withOpacity(0.7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 4),
            boxShadow: [
              BoxShadow(
                color: rankColor.withOpacity(0.4),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Center(
            child: Text(
              '#$rank',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: 100,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person, size: 32, color: rankColor),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  name,
                  style: TextStyle(
                    color: IbeereDesignTokens.textPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${_formatPoints(points)} pts',
                style: TextStyle(
                  color: rankColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOtherRankings(List<Map<String, dynamic>> players) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
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
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: players.length,
        separatorBuilder: (context, index) => Divider(
          height: 1,
          color: IbeereDesignTokens.textTertiary.withOpacity(0.1),
        ),
        itemBuilder: (context, index) {
          final player = players[index];
          final rank = int.tryParse(player['user_rank']?.toString() ?? '0') ?? (index + 4);
          final name = player['name']?.toString() ?? 'User';
          final points = player['score']?.toString() ?? '0';
          final color = _getRankColor(rank);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      '#$rank',
                      style: TextStyle(
                        color: color,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [color, color.withOpacity(0.7)],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.person, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      color: IbeereDesignTokens.textPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${_formatPoints(points)}',
                      style: TextStyle(
                        color: IbeereDesignTokens.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Points',
                      style: TextStyle(
                        color: IbeereDesignTokens.textSecondary,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _formatPoints(String points) {
    final num = int.tryParse(points) ?? 0;
    if (num >= 1000) {
      return '${(num / 1000).toStringAsFixed(1)}K';
    }
    return num.toString();
  }
}
