import 'package:crm/business_logic/blocs/companies_bloc/companies_bloc.dart';
import 'package:crm/business_logic/blocs/regions_bloc/regions_bloc.dart';
import 'package:crm/data/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabHomeScreen extends StatelessWidget {
  const TabHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TabHome'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(context.watch<RegionsBloc>().state.status.name),
            Text(context.watch<CompaniesBloc>().state.status.name),
            FilledButton(onPressed: ()async{
              // String? token = await TLocalStorage.getString(tokenKey);
              // token  = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2lzZmFhbmJhYy51ei9hcGkvbG9naW4iLCJpYXQiOjE3MDA4MDAyMjYsImV4cCI6MTcwMDgwMzgyNiwibmJmIjoxNzAwODAwMjI2LCJqdGkiOiJBNmVUTkRhTEs2SXdGNTNkIiwic3ViIjoiMSIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.0KNe6Qr_oTTnUdA5xUnWVEHtiC2qV-x3z9NRaLHaY2s";
              // print(token);
              // final regions = await Dio().get(baseUrl + regionsEndpoint,options: Options(headers: {

              //   'Authorization': 'Bearer $token'
              // }));
      final regions = await ApiService().regions();
              print(regions);
            }, child: Text('Fetch Regions')),

            // Text(context.read<PaymentBloc>().state.status.name),
            // Text(context.read<PaymentBloc>().state.error ?? ""),
            //
            // Text(context.read<FreeHomesBloc>().state.status.name),
            // Text(context.read<ContractBloc>().state.status.name),

          ],
        ),
      ),
    );
  }
}
