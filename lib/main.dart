import 'package:crm/business_logic/blocs/auth_bloc/auth_bloc.dart';
import 'package:crm/business_logic/blocs/contracts_bloc/contract_bloc.dart';
import 'package:crm/business_logic/blocs/free_homes/free_homes_bloc.dart';
import 'package:crm/business_logic/blocs/general_bloc/general_bloc.dart';
import 'package:crm/business_logic/blocs/payment_bloc/payment_bloc.dart';
import 'package:crm/business_logic/blocs/search_bloc/search_bloc.dart';
import 'package:crm/business_logic/cubits/tab_cubit/tab_cubit.dart';
import 'package:crm/data/service/api_service.dart';
import 'package:crm/presentations/auth/login.dart';
import 'package:crm/presentations/routes/routes.dart';
import 'package:crm/utils/constants/api_constants.dart';
import 'package:crm/utils/local_storage/storage_utility.dart';
import 'package:crm/utils/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const App());
  initialize();
}

initialize() async {
  final login = await TLocalStorage.getString(loginKey);
  final password = await TLocalStorage.getString(passwordKey);
  if (login != null && password != null) {
    final userToken = await ApiService().login(login, password);
    TLocalStorage.saveString(tokenKey, userToken.accessToken);
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TabCubit>(create: (context) => TabCubit()),
        BlocProvider<SearchBloc>(create: (context) => SearchBloc()..add(SearchValueChanged(''))),
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => PaymentBloc()..add(PaymentInitialEvent())),
        BlocProvider(create: (context) => FreeHomesBloc()..add(GetFreeHomesEvent())),
        BlocProvider(create: (context) => GeneralBloc()..add(GeneralInitialEvent())),
        BlocProvider(create: (context) => ContractBloc()..add(ContractEventInitial())),
        ChangeNotifierProvider(create: (context) => VisiblePasswordBloc()),
      ],
      child: const MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: TAppTheme.theme,
      onGenerateRoute: AppRoutes.generateRoute,
      // home: const NoConnection(),
    );
  }
}

