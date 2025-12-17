import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterquiz/features/in_app_purchase/cubits/razorpay_payment_state.dart';
import 'package:flutterquiz/features/in_app_purchase/services/razorpay_payment_service.dart';

class PaymentCubit extends Cubit<PaymentState> {

  PaymentCubit(this._paymentService) : super(const PaymentInitial());
  final GenericPaymentService _paymentService;

  /// Initiate coin purchase payment
  Future<void> purchaseCoins({
    required int coinAmount,
    required String customerEmail,
    required String customerName,
    required String customerPhone,
    required String orderId,
  }) async {
    emit(const PaymentLoading());

    try {
      final coinPackage = GenericPaymentService.getCoinPackageByCoins(coinAmount);
      if (coinPackage == null) {
        emit(const PaymentError('Invalid coin package'));
        return;
      }

      final response = await _paymentService.createPayment(
        amount: coinPackage.finalPrice.toStringAsFixed(2),
        currency: 'INR',
        description: '${coinPackage.coins} Coins Purchase',
        customerEmail: customerEmail,
        customerName: customerName,
        customerPhone: customerPhone,
        orderId: orderId,
      );

      if (response.success && response.transactionId != null) {
        emit(PaymentSuccess(
          transactionId: response.transactionId!,
          amount: coinPackage.finalPrice,
          coins: coinPackage.coins,
        ));
      } else {
        emit(PaymentError(response.error ?? 'Payment creation failed'));
      }
    } catch (e) {
      emit(PaymentError('Failed to process payment: $e'));
    }
  }

  /// Verify payment status
  Future<void> verifyPayment(String transactionId) async {
    emit(const PaymentLoading());

    try {
      final response = await _paymentService.verifyPayment(
        transactionId: transactionId,
      );

      if (response.verified) {
        emit(PaymentVerified(
          transactionId: transactionId,
          status: response.status,
        ));
      } else {
        emit(PaymentError(response.error ?? 'Payment verification failed'));
      }
    } catch (e) {
      emit(PaymentError('Verification failed: $e'));
    }
  }

  /// Reset payment state
  void reset() {
    emit(const PaymentInitial());
  }

  @override
  Future<void> close() {
    _paymentService.dispose();
    return super.close();
  }
}


