import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';

class CoinStorePackagesV2 extends StatelessWidget {
  const CoinStorePackagesV2({super.key});

  @override
  Widget build(BuildContext context) {
    final packages = [
      {'name': 'STARTER', 'coins': '1K', 'price': '\$0.50', 'color': Colors.blue},
      {'name': 'FIJI', 'coins': '5K', 'price': '\$2.00', 'color': Color(0xFF6366F1)},
      {'name': 'AKABA', 'coins': '10K', 'price': '\$4.50', 'color': Colors.orange},
      {'name': 'BOOSTER', 'coins': '50K', 'price': '\$22.69', 'color': Color(0xFF10B981)},
      {'name': 'ELITE', 'coins': '100K', 'price': '\$48.55', 'color': Color(0xFFEF4444)},
      {'name': 'V.I.P', 'coins': '1M', 'price': '\$425', 'color': Color(0xFFEC4899), 'vip': true},
    ];

    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: SizedBox.shrink(),
        title: Text(
          'Kauris Store',
          style: TextStyle(
            color: Color(0xFF6B7280),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.close, color: Color(0xFF9CA3AF)),
          ),
        ],
      ),
      floatingActionButton: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: Color(0xFF1E3A8A),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Color(0xFF1E3A8A).withOpacity(0.3),
              blurRadius: 15,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Icon(Icons.card_giftcard, color: Colors.white, size: 28),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemCount: packages.length,
              itemBuilder: (context, index) {
                final package = packages[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/payment-method-selection');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          package['color'] as Color,
                          (package['color'] as Color).withOpacity(0.7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: (package['color'] as Color).withOpacity(0.3),
                          blurRadius: 15,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (package['vip'] == true)
                            Icon(Icons.star, color: Colors.white, size: 32),
                          if (package['vip'] != true)
                            Icon(Icons.monetization_on, color: Colors.white, size: 32),
                          const SizedBox(height: 12),
                          Text(
                            package['name'] as String,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            package['coins'] as String,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Kauris',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              package['price'] as String,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: package['color'] as Color,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(24),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/payment-method-selection');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: IbeereDesignTokens.primaryPurple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                child: Text(
                  'Buy now',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
