import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';
import 'package:flutterquiz/ui/widgets/ibeere_v2_buttons.dart';
import 'package:flutterquiz/ui/widgets/ibeere_v2_cards.dart';

class CoinHistoryScreenV2 extends StatelessWidget {
  const CoinHistoryScreenV2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IbeereDesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: IbeereDesignTokens.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Coin History',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: IbeereDesignTokens.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: IbeereBalanceCard(
              balance: '853K',
              onTopUp: () {},
            ),
          ),
          
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                _buildTransactionItem(
                  title: 'Welcome Bonus',
                  date: '10, June, 2023',
                  amount: '+500',
                  isPositive: true,
                  icon: Icons.card_giftcard_outlined,
                ),
                const SizedBox(height: 12),
                
                _buildTransactionItem(
                  title: 'Defeat Battle',
                  date: '10, June, 2023',
                  amount: '-1200',
                  isPositive: false,
                  icon: Icons.close_rounded,
                ),
                const SizedBox(height: 12),
                
                _buildTransactionItem(
                  title: 'Answers Review',
                  date: '10, June, 2023',
                  amount: '-150',
                  isPositive: false,
                  icon: Icons.remove_red_eye_outlined,
                ),
                const SizedBox(height: 12),
                
                _buildTransactionItem(
                  title: 'Match Win',
                  date: '10, June, 2023',
                  amount: '+500',
                  isPositive: true,
                  icon: Icons.card_giftcard_outlined,
                ),
                const SizedBox(height: 12),
                
                _buildTransactionItem(
                  title: 'Live Bonus',
                  date: '10, June, 2023',
                  amount: '+70k',
                  isPositive: true,
                  icon: Icons.card_giftcard_outlined,
                ),
                const SizedBox(height: 12),
                
                _buildTransactionItem(
                  title: 'Contest Participation',
                  date: '10, June, 2023',
                  amount: '-5k',
                  isPositive: false,
                  icon: Icons.close_rounded,
                ),
                const SizedBox(height: 12),
                
                _buildTransactionItem(
                  title: 'Coins Purchased',
                  date: '10, June, 2023',
                  amount: '+1M',
                  isPositive: true,
                  icon: Icons.card_giftcard_outlined,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem({
    required String title,
    required String date,
    required String amount,
    required bool isPositive,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isPositive
                  ? const Color(0xFFD1FAE5)
                  : const Color(0xFFFEE2E2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 20,
              color: isPositive
                  ? IbeereDesignTokens.accentGreen
                  : IbeereDesignTokens.primaryRed,
            ),
          ),
          const SizedBox(width: 12),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: IbeereDesignTokens.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: IbeereDesignTokens.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isPositive
                  ? const Color(0xFFD1FAE5)
                  : const Color(0xFFFEE2E2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              amount,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: isPositive
                    ? IbeereDesignTokens.accentGreen
                    : IbeereDesignTokens.primaryRed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class KaurisStoreScreenV2 extends StatelessWidget {
  const KaurisStoreScreenV2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IbeereDesignTokens.backgroundLight,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Kauris Store',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: IbeereDesignTokens.textPrimary,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.close_rounded,
                          color: IbeereDesignTokens.textSecondary,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.75,
                    children: [
                      IbeereKaurisStoreCard(
                        title: 'STARTER',
                        kaurisAmount: '1K',
                        price: r'$0.50',
                        onTap: () {},
                      ),
                      IbeereKaurisStoreCard(
                        title: 'FIJI',
                        kaurisAmount: '5K',
                        price: r'$2.00',
                        onTap: () {},
                      ),
                      IbeereKaurisStoreCard(
                        title: 'AKABA',
                        kaurisAmount: '10K',
                        price: r'$4.50',
                        onTap: () {},
                      ),
                      IbeereKaurisStoreCard(
                        title: 'BOOSTER',
                        kaurisAmount: '50K',
                        price: r'$22.69',
                        onTap: () {},
                        isBestValue: true,
                      ),
                      IbeereKaurisStoreCard(
                        title: 'ELITE',
                        kaurisAmount: '100K',
                        price: r'$48.55',
                        onTap: () {},
                      ),
                      IbeereKaurisStoreCard(
                        title: 'V.I.P',
                        kaurisAmount: '1M',
                        price: r'$425',
                        onTap: () {},
                        isVIP: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            Positioned(
              bottom: 24,
              left: 24,
              right: 24,
              child: IbeereButton(
                text: 'Buy now',
                onPressed: () {},
                variant: IbeereButtonVariant.primary,
                icon: Icons.shopping_bag_outlined,
              ),
            ),
            
            Positioned(
              bottom: 100,
              right: 24,
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E3A8A),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF1E3A8A).withOpacity(0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.card_giftcard,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
