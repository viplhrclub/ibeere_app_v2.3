import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';
import 'package:flutterquiz/ui/widgets/ibeere_v2_buttons.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  static const String routeName = '/rewards';

  @override
  Widget build(BuildContext context) {
    final rewards = List.generate(7, (i) => {
      'day': 'Day ${i + 1}',
      'coins': (i + 1) * 10,
      'claimed': i < 3,
      'isToday': i == 3,
    });

    return Scaffold(
      backgroundColor: IbeereDesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: IbeereDesignTokens.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Daily Rewards', style: TextStyle(color: IbeereDesignTokens.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [IbeereDesignTokens.accentYellow, Color(0xFFF59E0B)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: IbeereDesignTokens.accentYellow.withOpacity(0.3), blurRadius: 15, offset: Offset(0, 8))],
            ),
            child: Column(
              children: [
                Icon(Icons.calendar_today, color: Colors.white, size: 48),
                const SizedBox(height: 16),
                Text('Current Streak', style: TextStyle(color: Colors.white, fontSize: 16)),
                const SizedBox(height: 8),
                Text('3 Days', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('Keep going to unlock bigger rewards!', style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 13)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: rewards.length,
              itemBuilder: (context, index) {
                final reward = rewards[index];
                final claimed = reward['claimed'] as bool;
                final isToday = reward['isToday'] as bool;

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isToday ? IbeereDesignTokens.primaryPurple.withOpacity(0.1) : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isToday ? IbeereDesignTokens.primaryPurple : claimed ? IbeereDesignTokens.accentGreen.withOpacity(0.3) : Color(0xFFE2E8F0),
                      width: 2,
                    ),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: claimed ? IbeereDesignTokens.accentGreen.withOpacity(0.1) : 
                                 isToday ? IbeereDesignTokens.primaryPurple.withOpacity(0.1) : 
                                 IbeereDesignTokens.backgroundLight,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          claimed ? Icons.check_circle : Icons.card_giftcard,
                          color: claimed ? IbeereDesignTokens.accentGreen : 
                                 isToday ? IbeereDesignTokens.primaryPurple : 
                                 IbeereDesignTokens.textSecondary,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              reward['day'] as String,
                              style: TextStyle(
                                color: IbeereDesignTokens.textPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.stars, size: 14, color: IbeereDesignTokens.accentYellow),
                                const SizedBox(width: 4),
                                Text(
                                  '${reward['coins']} Kauris',
                                  style: TextStyle(color: IbeereDesignTokens.textSecondary, fontSize: 13),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (claimed)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: IbeereDesignTokens.accentGreen.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text('Claimed', style: TextStyle(color: IbeereDesignTokens.accentGreen, fontSize: 11, fontWeight: FontWeight.w600)),
                        )
                      else if (isToday)
                        ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Claimed ${reward['coins']} Kauris!')),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: IbeereDesignTokens.primaryPurple,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          ),
                          child: Text('Claim', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                        )
                      else
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: IbeereDesignTokens.backgroundLight,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text('Locked', style: TextStyle(color: IbeereDesignTokens.textSecondary, fontSize: 11)),
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
