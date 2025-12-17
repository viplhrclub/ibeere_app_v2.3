import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/design_tokens.dart';
import 'package:flutterquiz/ui/widgets/ibeere_buttons.dart';

class CoinStoreScreen extends StatefulWidget {
  const CoinStoreScreen({super.key});

  @override
  State<CoinStoreScreen> createState() => _CoinStoreScreenState();
}

class _CoinStoreScreenState extends State<CoinStoreScreen> {
  final List<Map<String, dynamic>> _packages = [
    {
      'coins': 100,
      'price': '₹49',
      'bonus': 10,
      'popular': false,
    },
    {
      'coins': 500,
      'price': '₹199',
      'bonus': 75,
      'popular': true,
    },
    {
      'coins': 1000,
      'price': '₹349',
      'bonus': 200,
      'popular': false,
    },
    {
      'coins': 2500,
      'price': '₹749',
      'bonus': 625,
      'popular': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.background,
      appBar: AppBar(
        backgroundColor: DesignTokens.background,
        elevation: 0,
        title: Text(
          'Coin Store',
          style: TextStyle(
            color: DesignTokens.primary,
            fontWeight: DesignTokens.fontWeightBold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: DesignTokens.primary),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(DesignTokens.spaceMd),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: DesignTokens.spaceMd,
                  vertical: DesignTokens.spaceSm,
                ),
                decoration: BoxDecoration(
                  color: Colors.orange[100],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Text(
                      '🪙',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '1,250',
                      style: TextStyle(
                        color: Colors.orange[700],
                        fontWeight: DesignTokens.fontWeightBold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(DesignTokens.spaceLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose Your Package',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: DesignTokens.fontWeightBold,
              ),
            ),
            const SizedBox(height: DesignTokens.spaceMd),

            // Packages
            ..._packages.map((package) {
              final isPopular = package['popular'] as bool;
              return Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: DesignTokens.spaceMd,
                      top: isPopular ? DesignTokens.spaceMd : 0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                        border: Border.all(
                          color: isPopular ? DesignTokens.primary : (Colors.grey[200] ?? Colors.grey),
                          width: isPopular ? 2 : 1,
                        ),
                        boxShadow: isPopular
                            ? [
                          BoxShadow(
                            color: DesignTokens.primary.withOpacity(0.1),
                            blurRadius: 12,
                          ),
                        ]
                            : null,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(DesignTokens.spaceLg),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${package['coins']}',
                                      style: const TextStyle(
                                        fontSize: DesignTokens.fontSizeXl,
                                        fontWeight: DesignTokens.fontWeightBold,
                                        color: Colors.orange,
                                      ),
                                    ),
                                    Text(
                                      'coins',
                                      style: TextStyle(
                                        fontSize: DesignTokens.fontSizeSm,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: DesignTokens.spaceSm,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green[100],
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    '+${package['bonus']} bonus',
                                    style: TextStyle(
                                      fontSize: DesignTokens.fontSizeSm,
                                      color: Colors.green[700],
                                      fontWeight: DesignTokens.fontWeightBold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: DesignTokens.spaceXl),
                            IbeerePrimaryButton(
                              label: '${package['price']}',
                              isFullWidth: true,
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Processing payment...'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (isPopular)
                    Positioned(
                      top: 0,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: DesignTokens.spaceMd,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'POPULAR',
                          style: TextStyle(
                            fontSize: DesignTokens.fontSizeSm,
                            color: Colors.white,
                            fontWeight: DesignTokens.fontWeightBold,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            }),

            const SizedBox(height: DesignTokens.spaceXxl),

            // FAQ
            Container(
              padding: const EdgeInsets.all(DesignTokens.spaceLg),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '❓ How does it work?',
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeBase,
                      fontWeight: DesignTokens.fontWeightBold,
                      color: Colors.blue[900],
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spaceSm),
                  Text(
                    'Select a package, complete the payment, and coins will be instantly credited to your account.',
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeBase,
                      color: Colors.blue[800],
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

