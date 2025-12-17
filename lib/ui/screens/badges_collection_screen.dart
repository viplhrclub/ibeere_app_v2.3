import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';

class BadgesCollectionScreen extends StatefulWidget {
  const BadgesCollectionScreen({super.key});

  static const String routeName = '/badges-collection';

  @override
  State<BadgesCollectionScreen> createState() => _BadgesCollectionScreenState();
}

class _BadgesCollectionScreenState extends State<BadgesCollectionScreen> {
  List<Map<String, dynamic>> _badges = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchBadges();
  }

  Future<void> _fetchBadges() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await http.post(
        Uri.parse('https://api.ibeere.fun/api/get_badges'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['error'] == false || data['status'] == true) {
          if (data['data'] != null) {
            setState(() {
              _badges = List<Map<String, dynamic>>.from(data['data']);
              _isLoading = false;
            });
          } else {
            setState(() {
              _badges = _getMockBadges();
              _errorMessage = 'Using demo badges';
              _isLoading = false;
            });
          }
        } else {
          setState(() {
            _badges = _getMockBadges();
            _errorMessage = 'Using demo badges';
            _isLoading = false;
          });
        }
      } else {
        throw Exception('Server error');
      }
    } catch (e) {
      setState(() {
        _badges = _getMockBadges();
        _errorMessage = 'Using demo badges';
        _isLoading = false;
      });
    }
  }

  List<Map<String, dynamic>> _getMockBadges() {
    return [
      {'badge_label': 'Dashing Debut', 'badge_note': 'Play first quiz', 'badge_reward': '2', 'status': '1'},
      {'badge_label': 'Combat Winner', 'badge_note': 'Win random battle', 'badge_reward': '5', 'status': '1'},
      {'badge_label': 'Clash Winner', 'badge_note': 'Win group battle', 'badge_reward': '2', 'status': '0'},
      {'badge_label': 'Most Wanted', 'badge_note': 'Win contest', 'badge_reward': '10', 'status': '0'},
      {'badge_label': 'Ultimate Player', 'badge_note': 'Highest points', 'badge_reward': '1', 'status': '1'},
      {'badge_label': 'Quiz Warrior', 'badge_note': 'Win 3 battles', 'badge_reward': '1', 'status': '0'},
      {'badge_label': 'Super Sonic', 'badge_note': 'Quick answers', 'badge_reward': '5', 'status': '1'},
      {'badge_label': 'Brainiac', 'badge_note': '100% accuracy', 'badge_reward': '10', 'status': '0'},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IbeereDesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: IbeereDesignTokens.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Badges Collection',
          style: TextStyle(
            color: IbeereDesignTokens.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: IbeereDesignTokens.primaryPurple),
            onPressed: _fetchBadges,
          ),
        ],
      ),
      body: Column(
        children: [
          if (_errorMessage != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              color: IbeereDesignTokens.accentYellow.withOpacity(0.2),
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 16, color: IbeereDesignTokens.textSecondary),
                  const SizedBox(width: 8),
                  Text(
                    _errorMessage!,
                    style: TextStyle(color: IbeereDesignTokens.textSecondary, fontSize: 12),
                  ),
                ],
              ),
            ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    padding: const EdgeInsets.all(20),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: _badges.length,
                    itemBuilder: (context, index) {
                      final badge = _badges[index];
                      final isUnlocked = badge['status']?.toString() == '1';
                      final reward = badge['badge_reward']?.toString() ?? '0';

                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: isUnlocked
                              ? Border.all(
                                  color: IbeereDesignTokens.primaryPurple.withOpacity(0.3),
                                  width: 2,
                                )
                              : null,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            if (!isUnlocked)
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            if (isUnlocked)
                              Positioned(
                                top: 10,
                                right: 10,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        IbeereDesignTokens.accentGreen,
                                        IbeereDesignTokens.accentGreen.withOpacity(0.8),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.stars, color: Colors.white, size: 12),
                                      const SizedBox(width: 4),
                                      Text(
                                        '+$reward',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      gradient: isUnlocked
                                          ? LinearGradient(
                                              colors: [
                                                IbeereDesignTokens.primaryPurple,
                                                IbeereDesignTokens.primaryPink,
                                              ],
                                            )
                                          : null,
                                      color: isUnlocked ? null : IbeereDesignTokens.textTertiary.withOpacity(0.3),
                                      shape: BoxShape.circle,
                                      boxShadow: isUnlocked
                                          ? [
                                              BoxShadow(
                                                color: IbeereDesignTokens.primaryPurple.withOpacity(0.3),
                                                blurRadius: 12,
                                                offset: const Offset(0, 6),
                                              ),
                                            ]
                                          : [],
                                    ),
                                    child: Icon(
                                      isUnlocked ? Icons.emoji_events : Icons.lock,
                                      size: 40,
                                      color: isUnlocked ? Colors.white : IbeereDesignTokens.textSecondary,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    badge['badge_label'] ?? badge['app_badge_label'] ?? 'Badge',
                                    style: TextStyle(
                                      color: IbeereDesignTokens.textPrimary,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    badge['badge_note'] ?? badge['app_badge_note'] ?? 'Description',
                                    style: TextStyle(
                                      color: IbeereDesignTokens.textSecondary,
                                      fontSize: 11,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
