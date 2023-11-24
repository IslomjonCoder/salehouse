import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:crm/business_logic/cubits/tab_cubit/tab_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabBox extends StatefulWidget {
  const TabBox({super.key});

  @override
  TabBoxState createState() => TabBoxState();
}

class TabBoxState extends State<TabBox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: context.watch<TabCubit>().state,
        children: context.read<TabCubit>().pages,
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.transparent,
        selectedIndex: context.watch<TabCubit>().state,
        onDestinationSelected: context.read<TabCubit>().changeTab,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        height: 60,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        animationDuration: const Duration(milliseconds: 500),

      ),
    );
  }
}
