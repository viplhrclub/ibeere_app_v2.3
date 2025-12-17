import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';
import 'package:flutterquiz/ui/widgets/ibeere_v2_buttons.dart';

class CoinStoreScreenV2 extends StatelessWidget {
  const CoinStoreScreenV2({super.key});

  static const String routeName = '/coin-store-v2';

  @override
  Widget build(BuildContext context) {
    final packages = [
      {'coins': 50, 'price': '\$0.99', 'discount': null},
      {'coins': 100, 'price': '\$1.49', 'discount': '25% OFF'},
      {'coins': 500, 'price': '\$4.99', 'discount': '50% OFF'},
      {'coins': 1000, 'price': '\$7.99', 'discount': '60% OFF'},
    ];

    return Scaffold(
      backgroundColor: IbeereDesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: IbeereDesignTokens.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Coin Store', style: TextStyle(color: IbeereDesignTokens.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [IbeereDesignTokens.accentYellow, Color(0xFFF59E0B)],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: IbeereDesignTokens.accentYellow.withOpacity(0.3), blurRadius: 15, offset: Offset(0, 8))],
            ),
            child: Row(
              children: [
                Icon(Icons.account_balance_wallet, color: Colors.white, size: 40),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Your Balance', style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12)),
                      const SizedBox(height: 4),
                      Text('3,580 Kauris', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              itemCount: packages.length,
              itemBuilder: (context, index) {
                final pkg = packages[index];
                final hasDiscount = pkg['discount'] != null;

                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Purchase Coins'),
                        content: Text('Buy ${pkg['coins']} Kauris for ${pkg['price']}?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Purchase processing...')),
                              );
                            },
                            child: Text('Buy Now'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: index == 3
                            ? [IbeereDesignTokens.primaryPurple, IbeereDesignTokens.primaryPink]
                            : [Colors.white, Colors.white],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: index == 3 ? null : Border.all(color: Color(0xFFE2E8F0), width: 2),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10, offset: Offset(0, 4))],
                    ),
                    child: Stack(
                      children: [
                        if (hasDiscount)
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: IbeereDesignTokens.primaryRed,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(pkg['discount'] as String, style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.stars,
                              size: 56,
                              color: index == 3 ? Colors.white : IbeereDesignTokens.accentYellow,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              '${pkg['coins']}',
                              style: TextStyle(
                                color: index == 3 ? Colors.white : IbeereDesignTokens.textPrimary,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Kauris',
                              style: TextStyle(
                                color: index == 3 ? Colors.white.withOpacity(0.9) : IbeereDesignTokens.textSecondary,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: index == 3 ? Colors.white.withOpacity(0.2) : IbeereDesignTokens.primaryPurple,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                pkg['price'] as String,
                                style: TextStyle(
                                  color: index == 3 ? Colors.white : Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
