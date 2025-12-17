import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MonerooPaymentService {
  static const String _baseUrl = 'https://api.moneroo.io/v1';
  
  String? _appId;
  String? _apiKey;
  bool _isTestMode = true;

  MonerooPaymentService({
    String? appId,
    String? apiKey,
    bool isTestMode = true,
  }) {
    _appId = appId;
    _apiKey = apiKey;
    _isTestMode = isTestMode;
  }

  void configure({
    required String appId,
    required String apiKey,
    bool isTestMode = true,
  }) {
    _appId = appId;
    _apiKey = apiKey;
    _isTestMode = isTestMode;
  }

  Future<Map<String, dynamic>> createPayment({
    required double amount,
    required String currency,
    required String description,
    String? customerEmail,
    String? customerPhone,
    Map<String, dynamic>? metadata,
    String? returnUrl,
    String? cancelUrl,
  }) async {
    if (_appId == null || _apiKey == null) {
      throw Exception('Moneroo not configured. Call configure() first.');
    }

    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/payments'),
        headers: {
          'Authorization': 'Bearer $_apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'amount': amount,
          'currency': currency,
          'description': description,
          'customer': {
            if (customerEmail != null) 'email': customerEmail,
            if (customerPhone != null) 'phone': customerPhone,
          },
          'metadata': metadata ?? {},
          'return_url': returnUrl,
          'cancel_url': cancelUrl,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to create payment: ${response.body}');
      }
    } catch (e) {
      throw Exception('Moneroo payment error: $e');
    }
  }

  Future<void> openPaymentUrl(String paymentUrl) async {
    final Uri url = Uri.parse(paymentUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw Exception('Could not launch payment URL');
    }
  }

  Future<Map<String, dynamic>> getPaymentStatus(String paymentId) async {
    if (_apiKey == null) {
      throw Exception('Moneroo not configured. Call configure() first.');
    }

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/payments/$paymentId'),
        headers: {
          'Authorization': 'Bearer $_apiKey',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to get payment status: ${response.body}');
      }
    } catch (e) {
      throw Exception('Moneroo status check error: $e');
    }
  }

  Future<Map<String, dynamic>> verifyPayment(String paymentId) async {
    return await getPaymentStatus(paymentId);
  }

  Future<Map<String, dynamic>> createCheckoutSession({
    required double amount,
    required String currency,
    required String description,
    String? customerEmail,
    String? customerPhone,
    required String userId,
    required int coins,
    String? successUrl,
    String? cancelUrl,
  }) async {
    final metadata = {
      'user_id': userId,
      'coins': coins,
      'timestamp': DateTime.now().toIso8601String(),
    };

    return await createPayment(
      amount: amount,
      currency: currency,
      description: description,
      customerEmail: customerEmail,
      customerPhone: customerPhone,
      metadata: metadata,
      returnUrl: successUrl,
      cancelUrl: cancelUrl,
    );
  }

  static Future<void> showPaymentDialog({
    required BuildContext context,
    required double amount,
    required String currency,
    required int coins,
    required String userId,
    String? userEmail,
    String? userPhone,
    required String appId,
    required String apiKey,
    bool isTestMode = true,
    required Function(bool success, String? transactionId) onComplete,
  }) async {
    try {
      final service = MonerooPaymentService(
        appId: appId,
        apiKey: apiKey,
        isTestMode: isTestMode,
      );

      final payment = await service.createCheckoutSession(
        amount: amount,
        currency: currency,
        description: '$coins Kauris Coin Purchase',
        customerEmail: userEmail,
        customerPhone: userPhone,
        userId: userId,
        coins: coins,
      );

      if (payment['checkout_url'] != null) {
        await service.openPaymentUrl(payment['checkout_url']);
        
        if (context.mounted) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Payment Processing'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 16),
                    const Text('Complete the payment in your browser...'),
                    const SizedBox(height: 16),
                    const Text('Did you complete the payment?'),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      final status = await service.getPaymentStatus(payment['id']);
                      if (status['status'] == 'succeeded' || status['status'] == 'success') {
                        onComplete(true, payment['id']);
                      } else {
                        onComplete(false, null);
                      }
                    },
                    child: const Text('Yes, I paid'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onComplete(false, null);
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        onComplete(false, null);
      }
    } catch (e) {
      debugPrint('Moneroo payment error: $e');
      onComplete(false, null);
    }
  }

  bool get isConfigured => _appId != null && _apiKey != null;
  bool get isTestMode => _isTestMode;
  String? get appId => _appId;
}
