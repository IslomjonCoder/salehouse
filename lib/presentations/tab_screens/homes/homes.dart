import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:crm/business_logic/blocs/general_bloc/general_bloc.dart';
import 'package:crm/business_logic/blocs/homes_bloc/homes_bloc.dart';
import 'package:crm/utils/constants/colors.dart';
import 'package:crm/utils/constants/enums.dart';
import 'package:crm/utils/constants/sizes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomesScreen extends StatelessWidget {
  const HomesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu)),
        title: const Text('Uylar'),
      ),
      body: BlocBuilder<HomesBloc, HomesState>(
        buildWhen: (previous, current) =>
            current.status.isLoading || current.status.isSuccess || current.status.isFailure,
        builder: (context, state) {
          if (state.status.isLoading) {
            return _buildLoading();
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
                    onPressed: () => context.read<HomesBloc>().add(HomesEventInitial()),
                    child: const Text('Qayta Urinish'),
                  )
                ],
              ),
            );
          }
          return Column(
            children: [
              SizedBox(
                height: 60,
                child: BlocConsumer<GeneralBloc, GeneralState>(
                  builder: (context, state) {
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        return FilterChip.elevated(
                            selected: context.watch<HomesBloc>().state.blocIndex - 1 == index,
                            label: Text(state.blocs[index].name),
                            onSelected: (value) {
                              if (value) {
                                context.read<HomesBloc>().add(SelectBlocEvent(state.blocs[index].id));
                              }
                            });
                      },
                      separatorBuilder: (context, index) => const Gap(TSizes.sm),
                      itemCount: state.blocs.length,
                      scrollDirection: Axis.horizontal,
                    );

                  }, listener: (BuildContext context, GeneralState state) {
                  context.read<HomesBloc>().add(SelectBlocEvent(state.blocs[0].id));
                },
                  listenWhen: (previous, current) => current.status.isSuccess,
                ),
              ),
              Expanded (
                child: ListView.separated(
                  // controller: context.read<HomesBloc>().scrollController,
                  itemCount: state.contracts.length,
                  padding: const EdgeInsets.all(TSizes.sm),
                  itemBuilder: (BuildContext context, int index) {
                    final home = state.contracts[index];
                    return Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(TSizes.md),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: TSizes.xs),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(TSizes.base),
                                color: TColors.tPrimaryColor,
                              ),
                              child: Center(
                                  child: Text(
                                "${context.read<GeneralBloc>().state.blocs.where((element) => element.id == int.parse(home.blockId)).first.name}- Blok / ${home.number}-uy",
                                style: context.textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w700, color: Colors.white),
                              )),
                            ),
                            const Gap(TSizes.xs),
                            Row(
                              children: [
                                Text(
                                  "(q.|x.s.|m2): ",
                                  style: context.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "${home.stage}|${home.rooms}|${home.square}m²",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Ta'mirlangan narxi (1m2): ",
                                  style: context.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  formatMoney(double.parse(home.norepaired ?? '0')),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  overflow: TextOverflow.ellipsis,
                                  // softWrap: true,
                                ).flexible(),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Boshlang'ich to'lov: ",
                                  style: context.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  formatMoney(double.parse(home.start ?? '0')),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  overflow: TextOverflow.ellipsis,
                                  // softWrap: true,
                                ).flexible(),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Ta'mir holati: ",
                                  style: context.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: TSizes.xs),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(TSizes.xs),
                                    color: home.isrepaired == '0' ? Colors.orange : Colors.green,
                                  ),
                                  child: Text(
                                    home.isrepaired == '0' ? "Ta'mirsiz" : "Ta'mirlangan",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Bino turi (Turar/Noturar): ",
                                  style: context.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: home.status == '0' ? Colors.orange : Colors.green,
                                  ),
                                  child: Text(
                                    home.status == '0' ? "Turar" : "Noturar",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Status: ",
                                  style: context.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: formatStatusColor(home.status),
                                  ),
                                  // i need switch case here
                                  child: Text(
                                    formatStatus(home.status),
                                    // home.islive == '0' ? "Bo'sh" : "Band",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => const Gap(TSizes.sm),
                ),
              ),
              // Visibility(visible: state.nextPageLoading,child: LoadingAnimationWidget.staggeredDotsWave(color:  TColors.tPrimaryColor, size: 30),)
            ],
          );
        },
      ),
    );
  }

  Center _buildLoading() {
    return Center(
              child:
                  LoadingAnimationWidget.inkDrop(color: TColors.tPrimaryColor, size: TSizes.lg));
  }

  formatStatus(String status) {
    switch (status) {
      case "1":
        return "Bo'sh";
      case "2":
        return "Band qilish";
      case "3":
        return "Sotilgan";
      case "4":
        return "Aktiv emas";
    }
  }

  formatStatusColor(String status) {
    switch (status) {
      case "1":
        return Colors.green;
      case "2":
        return Colors.blue;
      case "3":
        return Colors.orange;
      case "4":
        return Colors.red;
    }
  }
}

String formatMoney(double amount) {
  final formatter = NumberFormat.simpleCurrency(decimalDigits: 0, locale: 'uz_UZ');
  return formatter.format(amount);
}
