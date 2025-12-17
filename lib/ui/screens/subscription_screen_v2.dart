import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';
import 'package:flutterquiz/ui/widgets/ibeere_v2_buttons.dart';

class SubscriptionScreenV2 extends StatelessWidget {
  const SubscriptionScreenV2({super.key});

  static const String routeName = '/subscription-v2';

  @override
  Widget build(BuildContext context) {
    final plans = [
      {
        'name': 'Monthly',
        'price': '\$4.99',
        'duration': 'per month',
        'color': IbeereDesignTokens.primaryPurple,
        'popular': false,
      },
      {
        'name': 'Yearly',
        'price': '\$39.99',
        'duration': 'per year',
        'color': IbeereDesignTokens.accentGreen,
        'popular': true,
        'discount': 'Save 33%',
      },
    ];

    final features = [
      'Unlimited quiz access',
      'All premium categories unlocked',
      'Ad-free experience',
      'Exclusive badges & rewards',
      'Priority customer support',
      'Advanced statistics',
    ];

    return Scaffold(
      backgroundColor: IbeereDesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: IbeereDesignTokens.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [IbeereDesignTokens.accentYellow, Color(0xFFF59E0B)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: IbeereDesignTokens.accentYellow.withOpacity(0.3), blurRadius: 15, offset: Offset(0, 8))],
                    ),
                    child: Icon(Icons.workspace_premium, color: Colors.white, size: 40),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Go Premium',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: IbeereDesignTokens.textPrimary),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Unlock all features and categories',
                    style: TextStyle(fontSize: 14, color: IbeereDesignTokens.textSecondary),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ...plans.map((plan) {
                    final isPop = plan['popular'] as bool;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isPop ? (plan['color'] as Color) : Color(0xFFE2E8F0),
                          width: isPop ? 2 : 1,
                        ),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: Offset(0, 4))],
                      ),
                      child: Stack(
                        children: [
                          if (isPop)
                            Positioned(
                              top: -1,
                              right: 20,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [IbeereDesignTokens.accentYellow, Color(0xFFF59E0B)],
                                  ),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                  ),
                                ),
                                child: Text('BEST VALUE', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              children: [
                                Container(
                                  width: 56,
                                  height: 56,
                                  decoration: BoxDecoration(
                                    color: (plan['color'] as Color).withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.card_membership, color: plan['color'] as Color, size: 28),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(plan['name'] as String, style: TextStyle(color: IbeereDesignTokens.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Text(plan['price'] as String, style: TextStyle(color: plan['color'] as Color, fontSize: 24, fontWeight: FontWeight.bold)),
                                          const SizedBox(width: 6),
                                          Text(plan['duration'] as String, style: TextStyle(color: IbeereDesignTokens.textSecondary, fontSize: 12)),
                                        ],
                                      ),
                                      if (plan['discount'] != null) ...[
                                        const SizedBox(height: 4),
                                        Text(plan['discount'] as String, style: TextStyle(color: IbeereDesignTokens.accentGreen, fontSize: 12, fontWeight: FontWeight.w600)),
                                      ],
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Premium Features', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: IbeereDesignTokens.textPrimary)),
                        const SizedBox(height: 16),
                        ...features.map((feature) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            children: [
                              Icon(Icons.check_circle, color: IbeereDesignTokens.accentGreen, size: 20),
                              const SizedBox(width: 12),
                              Text(feature, style: TextStyle(color: IbeereDesignTokens.textSecondary, fontSize: 14)),
                            ],
                          ),
                        )).toList(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  IbeereButton(
                    text: 'Subscribe Now',
                    onPressed: () {},
                    icon: Icons.workspace_premium,
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {},
                    child: Text('Restore Purchase', style: TextStyle(color: IbeereDesignTokens.primaryPurple)),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
