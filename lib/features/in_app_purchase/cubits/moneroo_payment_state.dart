abstract class MonerooPaymentState {}

class MonerooPaymentInitial extends MonerooPaymentState {}

class MonerooPaymentInitialized extends MonerooPaymentState {
  final bool isTestMode;
  final String appId;

  MonerooPaymentInitialized({
    required this.isTestMode,
    required this.appId,
  });
}

class MonerooPaymentProcessing extends MonerooPaymentState {}

class MonerooPaymentSuccess extends MonerooPaymentState {
  final String transactionId;
  final int coins;
  final double amount;

  MonerooPaymentSuccess({
    required this.transactionId,
    required this.coins,
    required this.amount,
  });
}

class MonerooPaymentError extends MonerooPaymentState {
  final String error;

  MonerooPaymentError({required this.error});
}
