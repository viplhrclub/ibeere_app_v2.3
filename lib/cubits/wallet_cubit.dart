import 'package:flutter_bloc/flutter_bloc.dart';
import '../api_service.dart';
import '../moneroo_config.dart';

sealed class WalletState {
  const WalletState();
}

class WalletInitial extends WalletState {
  const WalletInitial();
}

class WalletLoading extends WalletState {
  const WalletLoading();
}

class WalletLoaded extends WalletState {
  final Map<String, dynamic> walletData;
  const WalletLoaded(this.walletData);
}

class WalletError extends WalletState {
  final String message;
  const WalletError(this.message);
}

class PaymentProcessing extends WalletState {
  const PaymentProcessing();
}

class PaymentSuccess extends WalletState {
  final Map<String, dynamic> result;
  const PaymentSuccess(this.result);
}

class PaymentFailed extends WalletState {
  final String error;
  const PaymentFailed(this.error);
}

class WalletCubit extends Cubit<WalletState> {
  WalletCubit() : super(const WalletInitial());

  Future<void> getWalletBalance(String uid) async {
    try {
      emit(const WalletLoading());
      
      final userProfile = await ApiService.getUserProfile(uid);
      
      if (userProfile != null) {
        emit(WalletLoaded({
          'balance': userProfile['balance'] ?? 0.0,
          'coins': userProfile['coins'] ?? 0,
        }));
      } else {
        emit(const WalletError('Failed to load wallet'));
      }
    } catch (e) {
      emit(WalletError(e.toString()));
    }
  }

  Future<void> processPayment({
    required String uid,
    required String phoneNumber,
    required double amount,
  }) async {
    try {
      emit(const PaymentProcessing());
      
      // Generate transaction ID
      final txnId = 'txn_${DateTime.now().millisecondsSinceEpoch}';
      
      // Process payment with Moneroo
      final paymentResult = await MonerooPayment.processPayment(
        phoneNumber: phoneNumber,
        amount: amount,
        reference: txnId,
        description: 'Buy coins in Ibeere app',
      );
      
      if (paymentResult['success']) {
        // Update wallet in Firebase
        final result = await ApiService.processPayment(
          uid: uid,
          amount: amount,
          transactionId: paymentResult['transactionId'],
        );
        
        if (result['success']) {
          emit(PaymentSuccess({
            'transactionId': paymentResult['transactionId'],
            'coinsAdded': result['coinsAdded'],
            'amount': amount,
          }));
          
          // Refresh wallet
          await Future.delayed(const Duration(milliseconds: 500));
          await getWalletBalance(uid);
        } else {
          emit(PaymentFailed(result['error'] ?? 'Payment processing failed'));
        }
      } else {
        emit(PaymentFailed(paymentResult['error'] ?? 'Payment failed'));
      }
    } catch (e) {
      emit(PaymentFailed(e.toString()));
    }
  }
  
  Future<void> refund({
    required String transactionId,
  }) async {
    try {
      // Call Moneroo refund API
      emit(const WalletLoading());
    } catch (e) {
      emit(WalletError(e.toString()));
    }
  }
}
