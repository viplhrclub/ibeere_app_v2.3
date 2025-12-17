/// Example implementation of Moneroo payment integration
/// This file demonstrates how to use Moneroo payment service
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterquiz/features/in_app_purchase/cubits/moneroo_payment_cubit.dart';
import 'package:flutterquiz/features/in_app_purchase/cubits/moneroo_payment_state.dart';

/// Example: Moneroo Coin Store Implementation
class MonerooCoinStoreExample extends StatefulWidget {
  const MonerooCoinStoreExample({super.key});

  @override
  State<MonerooCoinStoreExample> createState() => _MonerooCoinStoreExampleState();
}

class _MonerooCoinStoreExampleState extends State<MonerooCoinStoreExample> {
  final List<CoinPackageData> packages = [
    CoinPackageData(coins: 100, price: 1.99, currency: 'USD'),
    CoinPackageData(coins: 500, price: 8.99, currency: 'USD'),
    CoinPackageData(coins: 1000, price: 15.99, currency: 'USD'),
    CoinPackageData(coins: 2500, price: 34.99, currency: 'USD'),
  ];

  @override
  void initState() {
    super.initState();
    _initializeMoneroo();
  }

  void _initializeMoneroo() {
    // Initialize Moneroo with credentials
    // In production, fetch these from backend API
    context.read<MonerooPaymentCubit>().initialize(
      appId: '01KCE1X626T22W0XFT708RG91G',
      apiKey: 'pvk_sandbox_n91oti|01KCKB6SGPS0JKA2K2T3REPJAD',
      isTestMode: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buy Coins with Moneroo'),
        actions: [
          BlocBuilder<MonerooPaymentCubit, MonerooPaymentState>(
            builder: (context, state) {
              if (state is MonerooPaymentInitialized) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Chip(
                    label: Text(state.isTestMode ? 'TEST MODE' : 'LIVE'),
                    backgroundColor: state.isTestMode ? Colors.orange : Colors.green,
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: BlocListener<MonerooPaymentCubit, MonerooPaymentState>(
        listener: (context, state) {
          if (state is MonerooPaymentSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Payment successful! ${state.coins} coins added.\nTransaction: ${state.transactionId}',
                ),
                backgroundColor: Colors.green,
              ),
            );
            // Update user's coin balance in Firebase/Backend
            // _updateUserCoins(state.coins);
          } else if (state is MonerooPaymentError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Payment failed: ${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<MonerooPaymentCubit, MonerooPaymentState>(
          builder: (context, state) {
            if (state is MonerooPaymentProcessing) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Processing payment...'),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: packages.length,
              itemBuilder: (context, index) {
                final package = packages[index];
                return _buildPackageCard(package);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildPackageCard(CoinPackageData package) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.monetization_on,
                size: 48,
                color: Colors.orange,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${package.coins} Coins',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${package.currency} ${package.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => _purchasePackage(package),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              child: const Text('Buy'),
            ),
          ],
        ),
      ),
    );
  }

  void _purchasePackage(CoinPackageData package) {
    final cubit = context.read<MonerooPaymentCubit>();
    
    if (!cubit.isConfigured) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Moneroo is not configured. Please contact support.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    cubit.createPayment(
      context: context,
      amount: package.price,
      currency: package.currency,
      coins: package.coins,
      userId: 'user_123', // Replace with actual user ID
      userEmail: 'user@example.com', // Replace with actual user email
      userPhone: '+1234567890', // Replace with actual user phone
    );
  }
}

/// Data class for coin packages
class CoinPackageData {
  final int coins;
  final double price;
  final String currency;

  CoinPackageData({
    required this.coins,
    required this.price,
    required this.currency,
  });
}

/// Example: How to integrate Moneroo in existing coin store screen
/// Add this to your BlocProvider list:
/// ```dart
/// BlocProvider<MonerooPaymentCubit>(
///   create: (_) => MonerooPaymentCubit()..initialize(
///     appId: 'YOUR_APP_ID',
///     apiKey: 'YOUR_API_KEY',
///     isTestMode: true,
///   ),
/// ),
/// ```
///
/// Then in your payment button:
/// ```dart
/// ElevatedButton(
///   onPressed: () {
///     context.read<MonerooPaymentCubit>().createPayment(
///       context: context,
///       amount: 9.99,
///       currency: 'USD',
///       coins: 500,
///       userId: userDetails.userId,
///       userEmail: userDetails.email,
///     );
///   },
///   child: const Text('Pay with Moneroo'),
/// )
/// ```

/// Example: Fetching Moneroo config from backend
class MonerooConfigService {
  static Future<MonerooConfig> fetchConfig() async {
    // In production, fetch from your backend API
    // This ensures API keys are never exposed in the app
    
    // Example API call:
    // final response = await http.get(
    //   Uri.parse('https://api.ibeere.fun/api/get_moneroo_settings'),
    //   headers: {'Authorization': 'Bearer $userToken'},
    // );
    // 
    // if (response.statusCode == 200) {
    //   final data = jsonDecode(response.body);
    //   return MonerooConfig.fromJson(data);
    // }

    // For demo purposes, return test config
    return MonerooConfig(
      appId: '01KCE1X626T22W0XFT708RG91G',
      isTestMode: true,
    );
  }
}

class MonerooConfig {
  final String appId;
  final bool isTestMode;

  MonerooConfig({
    required this.appId,
    required this.isTestMode,
  });

  factory MonerooConfig.fromJson(Map<String, dynamic> json) {
    return MonerooConfig(
      appId: json['app_id'] as String,
      isTestMode: json['is_test_mode'] as bool,
    );
  }
}
