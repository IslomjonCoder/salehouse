part of 'payment_bloc.dart';

abstract class PaymentEvent {}

class PaymentInitialEvent extends PaymentEvent {}

class FilterPaymentsByDateEvent extends PaymentEvent {
  final DateTime selectedDate;

  FilterPaymentsByDateEvent(this.selectedDate);

  List<Object?> get props => [selectedDate];
}
// class PaymentNextPageEvent extends PaymentEvent {
//   int page;
//
//   PaymentNextPageEvent(this.page);
// }
