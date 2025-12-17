/// Example implementation of the payment system in a screen
/// This file demonstrates how to use the payment system in screens
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterquiz/features/in_app_purchase/cubits/razorpay_payment_cubit.dart';
import 'package:flutterquiz/features/in_app_purchase/cubits/razorpay_payment_state.dart';
import 'package:flutterquiz/features/in_app_purchase/services/razorpay_payment_service.dart';

/// Example: Coin Store Screen Implementation
class CoinStoreScreenExample extends StatelessWidget {
  const CoinStoreScreenExample({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentCubit(GenericPaymentService()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Buy Coins'),
        ),
        body: BlocListener<PaymentCubit, PaymentState>(
          listener: (context, state) {
            if (state is PaymentSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Payment successful! Transaction: ${state.transactionId}',
                  ),
                  backgroundColor: Colors.green,
                ),
              );
              // Update user's coin balance here
            } else if (state is PaymentError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Payment failed: ${state.message}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: BlocBuilder<PaymentCubit, PaymentState>(
            builder: (context, state) {
              if (state is PaymentLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return ListView(
                padding: const EdgeInsets.all(16),
                children: GenericPaymentService.coinPackages
                    .map(
                      (package) => _CoinPackageCard(
                        package: package,
                        onTap: () {
                          // Trigger payment
                          context.read<PaymentCubit>().purchaseCoins(
                            coinAmount: package.coins,
                            customerEmail: 'user@example.com',
                            customerName: 'John Doe',
                            customerPhone: '+91-9876543210',
                            orderId: 'ORD_${DateTime.now().millisecondsSinceEpoch}',
                          );
                        },
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _CoinPackageCard extends StatelessWidget {

  const _CoinPackageCard({
    required this.package,
    required this.onTap,
  });
  final CoinPackage package;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final hasDiscount = package.discountPercent > 0;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${package.coins} Coins',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (hasDiscount)
                      Text(
                        'Save ${package.discountPercent}%',
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (hasDiscount)
                      Text(
                        package.priceString,
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                        ),
                      ),
                    Text(
                      package.finalPriceString,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onTap,
                child: const Text('Buy Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Example: Using payment in a quiz completion screen
class QuizCompletionScreenExample extends StatelessWidget {

  const QuizCompletionScreenExample({
    required this.coinsEarned,
    super.key,
  });
  final int coinsEarned;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz Complete')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You earned $coinsEarned coins!',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Buy More Coins'),
              onPressed: () {
                // Navigate to coin store
                // Navigator.of(context).pushNamed(Routes.coinStore);
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Continue to next quiz or dashboard
              },
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Example: Verifying payment after webhook
class PaymentVerificationExample {
  static Future<void> verifyAndUpdateCoins({
    required BuildContext context,
    required String transactionId,
    required int coins,
  }) async {
    final paymentCubit = context.read<PaymentCubit>();

    // Verify payment
    await paymentCubit.verifyPayment(transactionId);

    // Listen for verification result
    paymentCubit.stream.listen((state) {
      if (state is PaymentVerified) {
        if (state.status == 'paid') {
          // Update user's coin balance in Firebase
          // await updateUserCoins(userId, coins);
        }
      }
    });
  }
}

/// Example: Integration with user wallet
class UserWalletExample {
  static Future<void> addCoinsToWallet({
    required String userId,
    required int coins,
    required String transactionId,
  }) async {
    // Add coins to user's wallet in Firestore
    // FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(userId)
    //     .update({
    //       'coins': FieldValue.increment(coins),
    //       'coinTransactions': FieldValue.arrayUnion([
    //         {
    //           'amount': coins,
    //           'type': 'purchase',
    //           'transactionId': transactionId,
    //           'timestamp': DateTime.now(),
    //         }
    //       ]),
    //     });
  }
}

