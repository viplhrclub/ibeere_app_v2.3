import 'package:equatable/equatable.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object?> get props => [];
}

class PaymentInitial extends PaymentState {
  const PaymentInitial();
}

class PaymentLoading extends PaymentState {
  const PaymentLoading();
}

class PaymentSuccess extends PaymentState {

  const PaymentSuccess({
    required this.transactionId,
    required this.amount,
    required this.coins,
  });
  final String transactionId;
  final double amount;
  final int coins;

  @override
  List<Object?> get props => [transactionId, amount, coins];
}

class PaymentVerified extends PaymentState {

  const PaymentVerified({
    required this.transactionId,
    required this.status,
  });
  final String transactionId;
  final String status;

  @override
  List<Object?> get props => [transactionId, status];
}

class PaymentError extends PaymentState {

  const PaymentError(this.message, {this.code});
  final String message;
  final String? code;

  @override
  List<Object?> get props => [message, code];
}


