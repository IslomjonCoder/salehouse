part of 'payment_bloc.dart';

abstract class PaymentEvent {}

class PaymentInitialEvent extends PaymentEvent {}

// class PaymentNextPageEvent extends PaymentEvent {
//   int page;
//
//   PaymentNextPageEvent(this.page);
// }
