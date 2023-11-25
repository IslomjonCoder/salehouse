import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:crm/business_logic/blocs/companies_bloc/companies_bloc.dart';
import 'package:crm/business_logic/blocs/free_homes/free_homes_bloc.dart';
import 'package:crm/business_logic/blocs/general_bloc/general_bloc.dart';
import 'package:crm/presentations/routes/routes.dart';
import 'package:crm/utils/constants/colors.dart';
import 'package:crm/utils/constants/enums.dart';
import 'package:crm/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class FreeHomesScreen extends StatelessWidget {
  const FreeHomesScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: const Icon(Icons.menu)),
        title: const Text("Bo'sh Uylar"),
      ),
      body: BlocBuilder<GeneralBloc, GeneralState>(
        buildWhen: (previous, current) =>
            current.status.isSuccess || current.status.isFailure || current.status.isLoading,
        builder: (context, state) {
          if (state.status.isLoading) {
            return Center(
                child: LoadingAnimationWidget.inkDrop(
                  color: TColors.tPrimaryColor,
                  size: TSizes.lg,
                ));
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
                    onPressed: () => context.read<GeneralBloc>().add(GeneralInitialEvent()),
                    child: const Text('Qayta Urinish'),
                  )
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: state.blocs.length,
            itemBuilder: (BuildContext context, int index) {
              final blockModel = state.blocs[index];
              // final regionName = context.read<RegionsBloc>().state.regions
              //     .firstWhere((region) => region.id.toString() == blockModel.objects.regionId)
              //     .name;
              // final transliteratedRegionName = Translit().toTranslit(source: regionName);

              // final companyName = context.read<CompaniesBloc>().state.companies
              //     .firstWhere((company) => company.id.toString() == blockModel.objects.companiesId)
              //     .name;
              return GestureDetector(
                onTap: () {
                  context
                      .read<FreeHomesBloc>()
                      .add(GetFreeHomesByBlockIdEvent(blockId: blockModel.id));
                  context.pushNamed(RouteNames.freeHomesAll);
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  clipBehavior: Clip.antiAlias,
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  shadowColor: Colors.black,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: TColors.tPrimaryColor,
                              ),
                              child: Center(
                                child: Text(
                                  blockModel.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(fontWeight: FontWeight.bold,color: Colors.white),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: false,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                            const Gap(10),
                            Text(
                              context.read<CompaniesBloc>().state.companies.firstWhere((element) => element.id.toString() ==  blockModel.objects.companiesId).name,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Colors.indigo.shade600, fontWeight: FontWeight.bold),
                            ),
                            const Gap(10),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(CupertinoIcons.map_pin_ellipse),
                                    Text("  Viloyat: ",style: context.titleMedium?.copyWith(fontWeight: FontWeight.bold),),
                                    Text(
                                      blockModel.objects.city,
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                                const Gap(10),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.location_on_rounded),
                                    Text("  Shaxar: ",style: context.titleMedium?.copyWith(fontWeight: FontWeight.bold),),
                                    Flexible(
                                      child: Text(
                                        blockModel.objects.address,
                                        style: Theme.of(context).textTheme.bodyMedium,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ).paddingAll(8),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
