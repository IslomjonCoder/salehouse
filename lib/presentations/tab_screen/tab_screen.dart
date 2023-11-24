import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:crm/business_logic/cubits/tab_cubit/tab_cubit.dart';
import 'package:crm/utils/constants/colors.dart';
import 'package:crm/utils/constants/image_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  TabScreenState createState() => TabScreenState();
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class TabScreenState extends State<TabScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: NavigationDrawer(
        selectedIndex: context.watch<TabCubit>().state,
        children: [
          DrawerHeader(
            child: Image.asset(TImages.appLogo),
          ),
          const NavigationDrawerDestination(
            backgroundColor: TColors.tPrimaryColor,
            icon: Icon(CupertinoIcons.home),
            label: Text("Uylar"),
          ),
          const NavigationDrawerDestination(
            icon: Icon(CupertinoIcons.square_grid_2x2_fill),
            label: Text("Bloklar"),
          ),
          const NavigationDrawerDestination(
            icon: Icon(CupertinoIcons.rectangle_3_offgrid_fill),
            label: Text("Obyektlar"),
          ),
          const NavigationDrawerDestination(
            icon: Icon(CupertinoIcons.home),
            label: Text("Bo'sh Uylar"),
          ),
          const NavigationDrawerDestination(
            icon: Icon(CupertinoIcons.doc_plaintext),
            label: Text("Shartnoma"),
          ),
          const NavigationDrawerDestination(
            icon: Icon(CupertinoIcons.rectangle_fill_on_rectangle_angled_fill),
            label: Text("To'lov"),
          ),
          const NavigationDrawerDestination(
            icon: Icon(CupertinoIcons.briefcase_fill),
            label: Text("Kompaniyalar"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 10),
            child: Row(
              children: [
                Icon(CupertinoIcons.person_alt),
                Text("Toshmatjon Admin"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 50),
            child: OutlinedButton(
                onPressed: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.logout), Text("Chiqish")],
                )),
          )
        ],
        onDestinationSelected:( index) {
          context.read<TabCubit>().changeTab(index);
          scaffoldKey.currentState?.closeDrawer();
        },
      ),
      body: IndexedStack(
        index: context.watch<TabCubit>().state,
        children: context.read<TabCubit>().pages,
      ),
    );
  }
}
