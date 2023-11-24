import 'package:crm/presentations/auth/login.dart';
import 'package:crm/presentations/splash_screen/splash_screen.dart';
import 'package:crm/presentations/tab_box/tab_box.dart';
import 'package:crm/presentations/tab_screens/bloc_objects/bloc_objects.dart';
import 'package:crm/presentations/tab_screens/blocs/blocs.dart';
import 'package:crm/presentations/tab_screens/companies/companies.dart';
import 'package:crm/presentations/tab_screens/contracts/contracts.dart';
import 'package:crm/presentations/tab_screens/free_homes/free_homes.dart';
import 'package:crm/presentations/tab_screens/homes/homes.dart';
import 'package:crm/presentations/tab_screens/tab_home/tab_home.dart';
import 'package:flutter/material.dart';

class RouteNames {
  static const String splash = "/";
  static const String login = "/login";
  static const String tabBox = '/tabBox';
  static const String blocObjects = '/blocObjects';
  static const String blocs = '/blocs';
  static const String companies = '/companies';
  static const String contracts = '/contracts';
  static const String freeHomes = '/freeHomes';
  static const String homes = '/homes';
  static const String tabHome = '/tabHome';

}

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case RouteNames.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case RouteNames.tabHome:
        return MaterialPageRoute(builder: (context) => const TabHomeScreen());
      case RouteNames.tabBox:
        return MaterialPageRoute(builder: (context) => const TabBox());
      case RouteNames.freeHomes:
        return MaterialPageRoute(builder: (context) => const FreeHomesScreen());
      case RouteNames.homes:
        return MaterialPageRoute(builder: (context) => const HomesScreen());
      case RouteNames.blocs:
        return MaterialPageRoute(builder: (context) => const BlocsScreen());
      case RouteNames.companies:
        return MaterialPageRoute(builder: (context) => const CompaniesScreen());
      case RouteNames.contracts:
        return MaterialPageRoute(builder: (context) => const ContractsScreen());
      case RouteNames.blocObjects:
        return MaterialPageRoute(builder: (context) => const BlocObjectsScreen());
    }
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text("Route not found"),
        ),
      ),
    );
  }
}
