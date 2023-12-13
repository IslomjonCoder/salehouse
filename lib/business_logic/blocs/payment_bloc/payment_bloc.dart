import 'package:crm/data/models/payment_model.dart';
import 'package:crm/data/service/api_service.dart';
import 'package:crm/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payment_event.dart';

part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  ApiService apiService = ApiService();
  ScrollController scrollController = ScrollController();

  PaymentBloc() : super(const PaymentState()) {
    on<PaymentInitialEvent>(_onPaymentInitialEvent);
    on<FilterPaymentsByDateEvent>(_onFilterPaymentsByDateEvent);
    // on<PaymentNextPageEvent>(_onPaymentNextPageEvent, transformer: droppable());
    // initialize();
  }

  // initialize() async {
  //   scrollController.addListener(() {
  //     if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
  //       if (state.paymentModel != null) {
  //         if (state.currentPage < state.paymentModel!.lastPage) {
  //           add(PaymentNextPageEvent(state.currentPage + 1));
  //         }
  //       }
  //     }
  //   });
  // }

  _onPaymentInitialEvent(PaymentInitialEvent event, Emitter<PaymentState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final dailyBenefit = await apiService.payment();
      final response = await apiService.payments();
      // List<Datum> data = [];
      // data.addAll(response.data);

      emit(state.copyWith(
        status: Status.success,
        // paymentModel: response,
        dailyBenefit: dailyBenefit,
        data: response,
      ));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, error: e.toString()));
    }
  }

  _onFilterPaymentsByDateEvent(FilterPaymentsByDateEvent event, Emitter<PaymentState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final response = await apiService.payments();
      final List<Datum> filteredData = response.where((payment) {
        final paymentDate = DateTime.parse(payment.date);
        return paymentDate.isAtSameMomentAs(event.selectedDate);
      }).toList();

      emit(state.copyWith(
        status: Status.success,
        data: filteredData,
      ));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, error: e.toString()));
    }
  }


// _onPaymentNextPageEvent(PaymentNextPageEvent event, Emitter<PaymentState> emit) async {
//
//   emit(state.copyWith(nextPageLoading: true));
//   try {
//     final response = await apiService.payments(event.page);
//     final List paymentsRemote = response.data;
//     emit(state.copyWith(
//       status: Status.success,
//       paymentModel: response,
//       data: state.data..addAll(paymentsRemote as List<Datum>),
//       nextPageLoading: false,
//       currentPage: event.page,
//
//     ));
//   } catch (e) {
//     emit(state.copyWith(status: Status.failure, error: e.toString()));
//   }
// }
}
