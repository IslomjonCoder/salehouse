// ignore_for_file: must_be_immutable

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:crm/business_logic/blocs/contracts_bloc/contract_bloc.dart';
import 'package:crm/presentations/routes/routes.dart';
import 'package:crm/utils/constants/colors.dart';
import 'package:crm/utils/constants/enums.dart';
import 'package:crm/utils/constants/sizes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ContractsScreen extends StatelessWidget {
  ContractsScreen({super.key});

  String _getDateFromDateTimeString(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedDate = DateFormat('yyyy/MM/dd').format(dateTime);
    return formattedDate;
  }

  TextEditingController searchController = TextEditingController();

  Icon _getStatus(String status) {
    try {
      final intStatus = int.parse(status);
      Color iconColor;

      switch (intStatus) {
        case 1:
          iconColor = Colors.green;
          break;
        case 2:
          iconColor = Colors.blue;
          break;
        case 3:
          iconColor = Colors.red;
          break;
        default:
          iconColor = Colors.grey;
      }

      return Icon(
        intStatus == 2
            ? CupertinoIcons.checkmark_seal_fill
            : intStatus == 1
                ? CupertinoIcons.arrow_2_circlepath_circle_fill
                : intStatus == 3
                    ? CupertinoIcons.xmark_seal_fill
                    : CupertinoIcons.circle,
        color: iconColor,
      );
    } catch (e) {
      return const Icon(
        CupertinoIcons.circle,
        color: Colors.grey,
      );
    }
  }

  Color _getDividerColor(String status) {
    try {
      final intStatus = int.parse(status);

      switch (intStatus) {
        case 1:
          return Colors.green;
        case 2:
          return Colors.blue;
        case 3:
          return Colors.red;
        default:
          return Colors.grey;
      }
    } catch (e) {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
        title: const Text('Shartnomalar'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextFormField(
              onTapOutside: (e) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              controller: searchController,
              onChanged: (value) {
                context.read<ContractBloc>().add(SearchContractsEvent(query: value));
              },
              decoration: InputDecoration(
                  hintText: 'Qidirish',
                  prefixIcon: const Icon(CupertinoIcons.search),
                  suffixIcon: IconButton(
                    onPressed: () {
                      searchController.clear();
                      context.read<ContractBloc>().add(ContractEventInitial());
                    },
                    icon: const Icon(Icons.clear),
                  )),
            ),
          ),
          Expanded(
            child: BlocBuilder<ContractBloc, ContractState>(
              buildWhen: (previous, current) =>
                  current.status.isSuccess || current.status.isFailure || current.status.isLoading,
              builder: (context, state) {
                if (state.status.isLoading) {
                  return Center(
                    child: LoadingAnimationWidget.inkDrop(
                      color: TColors.tPrimaryColor,
                      size: TSizes.lg,
                    ),
                  );
                } else if (state.status.isFailure) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.error.toString(),
                          textAlign: TextAlign.center,
                        ),
                        const Gap(TSizes.base),
                        FilledButton(
                          onPressed: () {
                            context.read<ContractBloc>().add(ContractEventInitial());
                          },
                          child: const Text('Try Again'),
                        ),
                      ],
                    ),
                  );
                }
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        controller: context.read<ContractBloc>().scrollController,
                        itemBuilder: (context, index) {
                          final contract = state.contracts[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: GestureDetector(
                              onTap: () {
                                context.pushNamed(RouteNames.contractDetail, arguments: contract);
                              },
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Divider(
                                      color: _getDividerColor(
                                          state.contracts[index].status.toString()),
                                      thickness: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${state.contracts[index].custom.name}  ${state.contracts[index].custom.surname}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        _getStatus(state.contracts[index].status.toString()),
                                      ],
                                    ),
                                    Text(state.contracts[index].name),
                                    Row(
                                      children: [
                                        Text(
                                          "Maydoni:   ",
                                          style: context.titleSmall
                                              ?.copyWith(fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "${state.contracts[index].square} m2",
                                          style: context.titleSmall,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Umumiy summasi: ",
                                          style: context.titleSmall
                                              ?.copyWith(fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          NumberFormat.simpleCurrency(
                                                  locale: 'uz', name: 'so`m', decimalDigits: 0)
                                              .format(double.parse(state.contracts[index].sum)),
                                          style: context.titleSmall?.copyWith(color: Colors.teal),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Sana: ",
                                          style: context.titleSmall
                                              ?.copyWith(fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          _getDateFromDateTimeString(
                                            "${state.contracts[index].date}",
                                          ),
                                          style: context.titleSmall?.copyWith(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Mas'ul: ",
                                          style: context.titleSmall
                                              ?.copyWith(fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          state.contracts[index].staff.name,
                                          style: context.titleSmall?.copyWith(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: state.contracts.length,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
