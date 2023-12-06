import 'package:crm/business_logic/cubits/tab_cubit/tab_cubit.dart';
import 'package:crm/presentations/auth/login.dart';
import 'package:crm/utils/constants/api_constants.dart';
import 'package:crm/utils/constants/colors.dart';
import 'package:crm/utils/constants/image_strings.dart';
import 'package:crm/utils/constants/sizes.dart';
import 'package:crm/utils/local_storage/storage_utility.dart';
import 'package:crm/widgets/global_dialog.dart';
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
            icon: Icon(CupertinoIcons.macwindow),
            label: Text("Bosh Sahifa"),
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
          const Gap(kToolbarHeight),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: TSizes.md),
            child: OutlinedButton(
              onPressed: () {
                scaffoldKey.currentState?.closeDrawer();
                GlobalDialog.showSystemDialog(
                  context,
                  onOkPressed: () {
                    TLocalStorage.remove(tokenKey);
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                          (route) => false,
                    );

                  },
                  title: 'Chiqish',
                  message: 'Accountdan chiqishni istaysizmi?',
                  okButtonText: 'Xa',
                  buttonColor: Colors.red,
                  cancelButtonText: 'Yo\'q',
                );
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.logout), Text("Chiqish")],
              ),
            ),
          ),
        ],
        onDestinationSelected: (index) {
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
