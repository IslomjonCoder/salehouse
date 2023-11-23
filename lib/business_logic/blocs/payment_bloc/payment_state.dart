part of 'payment_bloc.dart';

class PaymentState {
  final Status status;
  final int dailyBenefit;
  final PaymentModel? paymentModel;
  final List<Datum> data;
  final String? error;

  const PaymentState({
    this.dailyBenefit = 0,
    this.status = Status.initial,
    this.paymentModel,
    this.data = const [],
    this.error,
  });

  PaymentState copyWith({
    Status? status,
    int? dailyBenefit,
    PaymentModel? paymentModel,
    List<Datum>? data,
    String? error,
  }) {
    return PaymentState(
      status: status ?? this.status,
      dailyBenefit: dailyBenefit ?? this.dailyBenefit,
      paymentModel: paymentModel ?? this.paymentModel,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }
}
