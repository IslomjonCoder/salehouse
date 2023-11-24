import 'package:crm/business_logic/blocs/objects_bloc/objects_bloc.dart';
import 'package:crm/presentations/common_widgets/rounded_container.dart';
import 'package:crm/utils/constants/enums.dart';
import 'package:crm/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class BlocsScreen extends StatelessWidget {
  const BlocsScreen({super.key});

  String _getDateFromDateTimeString(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu)),
          title: const Text('Bloklar'),
        ),
        body: BlocBuilder<ObjectsBloc, ObjectsState>(
          builder: (context, state) {
            if (state.status.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.status.isFailure) {
              return Center(child: Text(state.error.toString()));
            }
            return ListView.builder(
              padding: EdgeInsets.all(TSizes.sm),
              
              itemCount: state.objects.length,
              itemBuilder: (context, index) {
                final object = state.objects[index];
                return TRoundedContainer(
                  padding: const EdgeInsets.all(TSizes.md),
                  child: Text(object.name),
                );
              }
            );
          },
        ));
  }
}
