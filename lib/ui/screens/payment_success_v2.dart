import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';

class PaymentSuccessV2 extends StatelessWidget {
  const PaymentSuccessV2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IbeereDesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.close, color: IbeereDesignTokens.textPrimary),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: IbeereDesignTokens.accentGreen,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 60,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Payment Successfully',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: IbeereDesignTokens.textPrimary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              '+1K Kauris',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: IbeereDesignTokens.accentGreen,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '\$0.50',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: IbeereDesignTokens.textSecondary,
              ),
            ),
            const SizedBox(height: 48),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [IbeereDesignTokens.cardShadow],
              ),
              child: Column(
                children: [
                  _buildDetailRow('Transaction ID', '#1234567890'),
                  const SizedBox(height: 16),
                  _buildDetailRow('Payment Method', 'Mobile Money'),
                  const SizedBox(height: 16),
                  _buildDetailRow('Date', DateTime.now().toString().split(' ')[0]),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: IbeereDesignTokens.primaryPurple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: IbeereDesignTokens.textSecondary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: IbeereDesignTokens.textPrimary,
          ),
        ),
      ],
    );
  }
}
