import 'package:crm/presentations/tab_screens/bloc_objects/bloc_objects.dart';
import 'package:crm/presentations/tab_screens/blocs/blocs.dart';
import 'package:crm/presentations/tab_screens/companies/companies.dart';
import 'package:crm/presentations/tab_screens/contracts/contracts.dart';
import 'package:crm/presentations/tab_screens/free_homes/free_homes.dart';
import 'package:crm/presentations/tab_screens/homes/homes.dart';
import 'package:crm/presentations/tab_screens/payment/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class TabCubit extends Cubit<int> {
  TabCubit() : super(0);
  final ScrollController scrollController = ScrollController();
  List<Widget> pages = [
    const HomesScreen(),
    BlocsScreen(),
    BlocObjectsScreen(),
    FreeHomesScreen(),
    ContractsScreen(),
    PaymentScreen(),
    CompaniesScreen(),

  ];
  void changeTab(int tabIndex) {
    emit(tabIndex);
  }
}
