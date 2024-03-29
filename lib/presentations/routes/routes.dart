import 'package:crm/data/models/free_home_model.dart';
import 'package:crm/presentations/auth/login.dart';
import 'package:crm/presentations/image_screen/image_screen.dart';
import 'package:crm/presentations/splash_screen/splash_screen.dart';
import 'package:crm/presentations/tab_screen/tab_screen.dart';
import 'package:crm/presentations/tab_screens/contracts/contract_detail.dart';
import 'package:crm/presentations/tab_screens/contracts/contracts.dart';
import 'package:crm/presentations/tab_screens/free_homes/free_home_detail.dart';
import 'package:crm/presentations/tab_screens/free_homes/free_homes.dart';
import 'package:crm/presentations/tab_screens/free_homes/free_homes_all.dart';
import 'package:crm/presentations/tab_screens/homes/homes.dart';
import 'package:crm/presentations/tab_screens/payments/payments.dart';
import 'package:crm/utils/theme/custom_themes/payment_graphic.dart';
import 'package:flutter/material.dart';

import '../../data/models/contract_model.dart';

class RouteNames {
  static const String splash = "/";
  static const String login = "/login";
  static const String tabBox = '/tabBox';
  static const String blocObjects = '/blocObjects';
  static const String blocs = '/blocs';
  static const String companies = '/companies';
  static const String contracts = '/contracts';
  static const String contractDetail = '/contractDetail';
  static const String freeHomes = '/freeHomes';
  static const String homes = '/homes';
  static const String tabHome = '/tabHome';
  static const String freeHomesAll = '/freeHomesAll';
  static const String freeHomeDetail = '/freeHomeDetail';
  static const String imagePreview = '/imagePreview';
  static const String paymentGraphic = '/paymentGraphic';

}

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case RouteNames.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case RouteNames.imagePreview:
        return MaterialPageRoute(
            builder: (context) => ImagePreviewScreen(imageUrl: settings.arguments as String));
      case RouteNames.tabHome:
        return MaterialPageRoute(builder: (context) => const PaymentScreen());
      case RouteNames.tabBox:
        return MaterialPageRoute(builder: (context) => const TabScreen());
      case RouteNames.freeHomes:
        return MaterialPageRoute(builder: (context) => const FreeHomesScreen());
      case RouteNames.homes:
        return MaterialPageRoute(builder: (context) =>   HomesScreen());
      // case RouteNames.blocs:
      //   return MaterialPageRoute(builder: (context) => const BlocsScreen());
      // case RouteNames.companies:
      //   return MaterialPageRoute(builder: (context) => const CompaniesScreen());
      case RouteNames.contracts:
        return MaterialPageRoute(builder: (context) => ContractsScreen());
      // case RouteNames.blocObjects:
      //   return MaterialPageRoute(builder: (context) => const BlocObjectsScreen());
      case RouteNames.freeHomesAll:
        return MaterialPageRoute(builder: (context) =>  FreeHomesAll(homeId: settings.arguments as int));
      case RouteNames.freeHomeDetail:
        return MaterialPageRoute(
          builder: (context) => DetailScreen(homeModel: settings.arguments as FreeHomeModel),
        );
      case RouteNames.contractDetail:
        return MaterialPageRoute(
            builder: (context) =>
                ContractDetailScreen(contract: settings.arguments as ContractUser));
      case RouteNames.paymentGraphic:
        return MaterialPageRoute(builder: (context) =>  PaymentGraphic(data: settings.arguments as List<ListElement>,));
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
