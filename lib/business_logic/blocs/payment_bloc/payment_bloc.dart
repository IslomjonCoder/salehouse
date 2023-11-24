import 'package:crm/data/models/payment_model.dart';
import 'package:crm/data/service/api_service.dart';
import 'package:crm/utils/constants/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payment_event.dart';

part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  ApiService apiService = ApiService();

  PaymentBloc() : super(const PaymentState()) {
    on<PaymentInitialEvent>(_onPaymentInitialEvent);
    on<PaymentNextPageEvent>(_onPaymentNextPageEvent);
  }

  _onPaymentInitialEvent(PaymentInitialEvent event, Emitter<PaymentState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final dailyBenefit = await apiService.payment();
      final response = await apiService.payments();
       List<Datum>data = [];
      data.addAll(response.data);

      emit(state.copyWith(
          status: Status.success, paymentModel: response, dailyBenefit: dailyBenefit, data: data));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, error: e.toString()));
    }
  }
  _onPaymentNextPageEvent(PaymentNextPageEvent event, Emitter<PaymentState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final response = await apiService.payments();
      List<Datum>data = [];
      data.addAll(response.data);
      emit(state.copyWith(
          status: Status.success, paymentModel: response, data: data.toSet().toList()));

    }
    catch (e) {
      emit(state.copyWith(status: Status.failure, error: e.toString()));
    }
  }
}
