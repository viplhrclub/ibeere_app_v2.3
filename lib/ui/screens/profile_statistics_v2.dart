import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';

class ProfileStatisticsV2 extends StatelessWidget {
  const ProfileStatisticsV2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  IbeereDesignTokens.primaryPurple,
                  IbeereDesignTokens.primaryPink,
                ],
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.settings, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Colors.white, width: 3),
                      ),
                      child: Icon(
                        Icons.person,
                        color: IbeereDesignTokens.primaryPurple,
                        size: 40,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Melissa',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.monetization_on, color: IbeereDesignTokens.accentYellow, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          '2,450 Kauris',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildBadge(Icons.star, Color(0xFFFFD700)),
                        const SizedBox(width: 12),
                        _buildBadge(Icons.military_tech, Color(0xFFC0C0C0)),
                        const SizedBox(width: 12),
                        _buildBadge(Icons.emoji_events, Color(0xFFCD7F32)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: IbeereDesignTokens.backgroundLight,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [IbeereDesignTokens.cardShadow],
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 200,
                            height: 200,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                PieChart(
                                  PieChartData(
                                    sections: [
                                      PieChartSectionData(
                                        value: 71.4,
                                        color: IbeereDesignTokens.accentGreen,
                                        radius: 40,
                                        showTitle: false,
                                      ),
                                      PieChartSectionData(
                                        value: 28.6,
                                        color: Colors.grey.withOpacity(0.2),
                                        radius: 40,
                                        showTitle: false,
                                      ),
                                    ],
                                    centerSpaceRadius: 70,
                                    sectionsSpace: 0,
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '71.4%',
                                      style: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        color: IbeereDesignTokens.textPrimary,
                                      ),
                                    ),
                                    Text(
                                      'Accuracy',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: IbeereDesignTokens.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(
                                child: _buildStatItem('Questions', '245', Icons.quiz),
                              ),
                              Expanded(
                                child: _buildStatItem('Correct', '175', Icons.check_circle),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: _buildStatItem('Coins', '2.4K', Icons.monetization_on),
                              ),
                              Expanded(
                                child: _buildStatItem('Battles', '32', Icons.sports_esports),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [IbeereDesignTokens.cardShadow],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.trending_up, color: IbeereDesignTokens.accentGreen),
                              const SizedBox(width: 8),
                              Text(
                                'Strongest: Science',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: IbeereDesignTokens.textPrimary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Icon(Icons.trending_down, color: IbeereDesignTokens.primaryRed),
                              const SizedBox(width: 8),
                              Text(
                                'Weakest: History',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: IbeereDesignTokens.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(IconData icon, Color color) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 24),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: IbeereDesignTokens.primaryPurple, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: IbeereDesignTokens.textPrimary,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: IbeereDesignTokens.textSecondary,
          ),
        ),
      ],
    );
  }
}
