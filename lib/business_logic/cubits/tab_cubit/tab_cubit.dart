import 'package:crm/presentations/tab_screens/tab_home/tab_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class TabCubit extends Cubit<int> {
  TabCubit() : super(0);
  final ScrollController scrollController = ScrollController();
  List<Widget> pages = [
    const TabHomeScreen(),
    const TabHomeScreen(),
  ];
  void changeTab(int tabIndex) {
    emit(tabIndex);
  }
}
