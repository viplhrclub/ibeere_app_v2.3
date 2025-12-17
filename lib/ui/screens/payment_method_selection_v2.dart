import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';

class PaymentMethodSelectionV2 extends StatefulWidget {
  const PaymentMethodSelectionV2({super.key});

  @override
  State<PaymentMethodSelectionV2> createState() => _PaymentMethodSelectionV2State();
}

class _PaymentMethodSelectionV2State extends State<PaymentMethodSelectionV2> {
  int _selectedMethod = 0;

  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'title': 'Mobile Money',
      'subtitle': 'MTN, Moov, Orange',
      'icon': Icons.phone_android,
      'color': Color(0xFF10B981),
    },
    {
      'title': 'Credit Card',
      'subtitle': 'Visa, Mastercard',
      'icon': Icons.credit_card,
      'color': Color(0xFF6366F1),
    },
    {
      'title': 'Google Pay',
      'subtitle': 'Fast & Secure',
      'icon': Icons.g_mobiledata,
      'color': Color(0xFFEF4444),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IbeereDesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: IbeereDesignTokens.textPrimary),
        ),
        title: Text(
          'Payment Method',
          style: TextStyle(
            color: IbeereDesignTokens.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Payment Method',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: IbeereDesignTokens.textPrimary,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.separated(
                itemCount: _paymentMethods.length,
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final method = _paymentMethods[index];
                  final isSelected = _selectedMethod == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedMethod = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? IbeereDesignTokens.primaryPurple
                              : Colors.transparent,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: (method['color'] as Color).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(
                              method['icon'] as IconData,
                              color: method['color'] as Color,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  method['title'] as String,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: IbeereDesignTokens.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  method['subtitle'] as String,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: IbeereDesignTokens.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Radio<int>(
                            value: index,
                            groupValue: _selectedMethod,
                            onChanged: (value) {
                              setState(() {
                                _selectedMethod = value!;
                              });
                            },
                            activeColor: IbeereDesignTokens.primaryPurple,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/payment-success');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: IbeereDesignTokens.primaryPurple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                child: Text(
                  'Pay',
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
}
