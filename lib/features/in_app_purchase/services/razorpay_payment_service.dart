/// Payment gateway service for handling coin purchases
/// This is a placeholder implementation that integrates with external payment gateways
/// 
/// Supported gateways:
/// - Razorpay (India)
/// - Stripe (Global)  
/// - PayPal (Global)
/// - In-app purchases (Platform native)
library;

class CoinPackage {

  CoinPackage({
    required this.coins,
    required this.price,
    this.currency = 'INR',
    this.discountPercent = 0,
  });
  final int coins;
  final double price;
  final String currency;
  final int discountPercent;

  double get finalPrice => price - (price * discountPercent / 100);
  String get priceString => '₹$price';
  String get finalPriceString => '₹${finalPrice.toStringAsFixed(2)}';
}

/// Generic payment service interface
abstract class PaymentGatewayService {
  Future<PaymentResponse> createPayment({
    required String amount,
    required String currency,
    required String description,
    required String customerEmail,
    required String customerName,
    required String customerPhone,
    required String orderId,
  });

  Future<PaymentVerificationResponse> verifyPayment({
    required String transactionId,
  });

  void dispose();
}

class PaymentResponse {

  PaymentResponse({
    required this.success,
    this.transactionId,
    this.paymentUrl,
    this.error,
  });
  final bool success;
  final String? transactionId;
  final String? paymentUrl;
  final String? error;
}

class PaymentVerificationResponse {

  PaymentVerificationResponse({
    required this.verified,
    required this.status,
    this.error,
  });
  final bool verified;
  final String status; // 'paid', 'pending', 'failed'
  final String? error;
}

/// Default payment service using basic HTTP calls
class GenericPaymentService implements PaymentGatewayService {

  factory GenericPaymentService() {
    return _instance;
  }

  GenericPaymentService._internal();
  static final GenericPaymentService _instance =
      GenericPaymentService._internal();

  // Predefined coin packages
  static final List<CoinPackage> coinPackages = [
    CoinPackage(coins: 50, price: 49),
    CoinPackage(coins: 100, price: 99, discountPercent: 5),
    CoinPackage(coins: 500, price: 499, discountPercent: 10),
    CoinPackage(coins: 1000, price: 999, discountPercent: 15),
  ];

  @override
  Future<PaymentResponse> createPayment({
    required String amount,
    required String currency,
    required String description,
    required String customerEmail,
    required String customerName,
    required String customerPhone,
    required String orderId,
  }) async {
    try {
      // Placeholder: In production, integrate with actual payment gateway
      // For now, return a successful response
      return PaymentResponse(
        success: true,
        transactionId: 'TXN_${DateTime.now().millisecondsSinceEpoch}',
      );
    } catch (e) {
      return PaymentResponse(
        success: false,
        error: 'Payment creation failed: $e',
      );
    }
  }

  @override
  Future<PaymentVerificationResponse> verifyPayment({
    required String transactionId,
  }) async {
    try {
      // Placeholder: In production, verify payment with gateway
      return PaymentVerificationResponse(
        verified: true,
        status: 'paid',
      );
    } catch (e) {
      return PaymentVerificationResponse(
        verified: false,
        status: 'failed',
        error: 'Verification failed: $e',
      );
    }
  }

  @override
  void dispose() {
    // Cleanup resources if any
  }

  /// Get coin package by coins count
  static CoinPackage? getCoinPackageByCoins(int coins) {
    try {
      return coinPackages.firstWhere((pkg) => pkg.coins == coins);
    } catch (e) {
      return null;
    }
  }

  /// Get best value package
  static CoinPackage getBestValuePackage() {
    return coinPackages.last; // Highest discount
  }
}


