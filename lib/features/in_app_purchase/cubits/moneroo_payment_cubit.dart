import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterquiz/features/in_app_purchase/services/moneroo_payment_service.dart';
import 'package:flutterquiz/features/in_app_purchase/cubits/moneroo_payment_state.dart';

class MonerooPaymentCubit extends Cubit<MonerooPaymentState> {
  late MonerooPaymentService _monerooService;

  MonerooPaymentCubit() : super(MonerooPaymentInitial()) {
    _monerooService = MonerooPaymentService();
  }

  void initialize({
    required String appId,
    required String apiKey,
    bool isTestMode = true,
  }) {
    try {
      _monerooService.configure(
        appId: appId,
        apiKey: apiKey,
        isTestMode: isTestMode,
      );
      emit(MonerooPaymentInitialized(
        isTestMode: isTestMode,
        appId: appId,
      ));
    } catch (e) {
      emit(MonerooPaymentError(error: e.toString()));
    }
  }

  Future<void> createPayment({
    required BuildContext context,
    required double amount,
    required String currency,
    required int coins,
    required String userId,
    String? userEmail,
    String? userPhone,
  }) async {
    if (state is! MonerooPaymentInitialized) {
      emit(MonerooPaymentError(error: 'Moneroo not initialized'));
      return;
    }

    try {
      emit(MonerooPaymentProcessing());

      final initState = state as MonerooPaymentInitialized;

      await MonerooPaymentService.showPaymentDialog(
        context: context,
        amount: amount,
        currency: currency,
        coins: coins,
        userId: userId,
        userEmail: userEmail,
        userPhone: userPhone,
        appId: initState.appId,
        apiKey: '', // This would come from secure storage
        isTestMode: initState.isTestMode,
        onComplete: (success, transactionId) {
          if (success) {
            emit(MonerooPaymentSuccess(
              transactionId: transactionId ?? '',
              coins: coins,
              amount: amount,
            ));
          } else {
            emit(MonerooPaymentError(error: 'Payment failed or cancelled'));
          }
        },
      );
    } catch (e) {
      emit(MonerooPaymentError(error: e.toString()));
    }
  }

  Future<void> verifyPayment(String paymentId) async {
    try {
      emit(MonerooPaymentProcessing());
      
      final result = await _monerooService.verifyPayment(paymentId);
      
      if (result['status'] == 'succeeded' || result['status'] == 'success') {
        emit(MonerooPaymentSuccess(
          transactionId: paymentId,
          coins: result['metadata']?['coins'] ?? 0,
          amount: result['amount']?.toDouble() ?? 0.0,
        ));
      } else {
        emit(MonerooPaymentError(error: 'Payment verification failed'));
      }
    } catch (e) {
      emit(MonerooPaymentError(error: e.toString()));
    }
  }

  void reset() {
    if (state is MonerooPaymentInitialized) {
      emit(MonerooPaymentInitialized(
        isTestMode: (state as MonerooPaymentInitialized).isTestMode,
        appId: (state as MonerooPaymentInitialized).appId,
      ));
    } else {
      emit(MonerooPaymentInitial());
    }
  }

  bool get isConfigured => _monerooService.isConfigured;
  bool get isTestMode => _monerooService.isTestMode;
}
