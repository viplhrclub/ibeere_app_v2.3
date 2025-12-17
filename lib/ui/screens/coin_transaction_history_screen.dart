import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';

class CoinTransactionHistoryScreen extends StatefulWidget {
  const CoinTransactionHistoryScreen({super.key});

  static const String routeName = '/coin-transaction-history';

  @override
  State<CoinTransactionHistoryScreen> createState() => _CoinTransactionHistoryScreenState();
}

class _CoinTransactionHistoryScreenState extends State<CoinTransactionHistoryScreen> {
  final List<Map<String, dynamic>> _transactions = [
    {
      'title': 'Welcome Bonus',
      'date': '10, June, 2023',
      'amount': '+500',
      'type': 'credit',
      'icon': Icons.card_giftcard,
    },
    {
      'title': 'Defeat Battle',
      'date': '10, June, 2023',
      'amount': '-1200',
      'type': 'debit',
      'icon': Icons.remove_circle_outline,
    },
    {
      'title': 'Answers Review',
      'date': '10, June, 2023',
      'amount': '-150',
      'type': 'debit',
      'icon': Icons.remove_circle_outline,
    },
    {
      'title': 'Match Win',
      'date': '10, June, 2023',
      'amount': '+500',
      'type': 'credit',
      'icon': Icons.emoji_events,
    },
    {
      'title': 'Live Bonus',
      'date': '10, June, 2023',
      'amount': '+70k',
      'type': 'credit',
      'icon': Icons.card_giftcard,
    },
    {
      'title': 'Contest Participation',
      'date': '10, June, 2023',
      'amount': '-5k',
      'type': 'debit',
      'icon': Icons.remove_circle_outline,
    },
    {
      'title': 'Coins Purchased',
      'date': '10, June, 2023',
      'amount': '+1M',
      'type': 'credit',
      'icon': Icons.shopping_cart,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF5B4FB8),
                    const Color(0xFF6B5FB8),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Text(
                        'Coin History',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      children: const [
                        Text(
                          '853K KAURIS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Your Balance',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Center(
                            child: Text(
                              'TOP UP',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.refresh,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(24),
                itemCount: _transactions.length,
                itemBuilder: (context, index) {
                  final transaction = _transactions[index];
                  final isCredit = transaction['type'] == 'credit';
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
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
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: isCredit
                                ? const Color(0xFFD1F4E0)
                                : const Color(0xFFFFE4E4),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            transaction['icon'],
                            color: isCredit
                                ? const Color(0xFF10B981)
                                : const Color(0xFFEF4444),
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                transaction['title'],
                                style: TextStyle(
                                  color: IbeereDesignTokens.textPrimary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                transaction['date'],
                                style: TextStyle(
                                  color: IbeereDesignTokens.textSecondary,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isCredit
                                ? const Color(0xFFD1F4E0)
                                : const Color(0xFFFFE4E4),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            transaction['amount'],
                            style: TextStyle(
                              color: isCredit
                                  ? const Color(0xFF10B981)
                                  : const Color(0xFFEF4444),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
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
      ),
    );
  }
}
