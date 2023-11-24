import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:crm/business_logic/blocs/general_bloc/general_bloc.dart';
import 'package:crm/utils/constants/api_constants.dart';
import 'package:crm/utils/constants/enums.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:translit/translit.dart';

class FreeHomesScreen extends StatelessWidget {
  const FreeHomesScreen({super.key});

  String _getDateFromDateTimeString(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu)),
        title: const Text("Bo'sh Uylar"),
      ),
      body: BlocBuilder<GeneralBloc, GeneralState>(
        buildWhen: (previous, current) =>
            current.status.isSuccess || current.status.isFailure || current.status.isLoading,
        builder: (context, state) {
          if (state.status.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status.isFailure) {
            return Center(
              child: Text(state.error ?? ''),
            );
            // return
            //   NoConnection(
            //   onTap: () {
            //     context.read<GeneralBloc>().add(GeneralInitialEvent());
            //   },
            //   errorText: state.error??'',
            // );
          }

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisExtent: 460,
              childAspectRatio: context.width / context.height,
            ),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              final blockModel = state.blocs[index];
              final regionName = state.regions
                  .firstWhere((region) => region.id.toString() == blockModel.objects.regionId)
                  .name;
              final transliteratedRegionName = Translit().toTranslit(source: regionName);

              final companyName = state.companies
                  .firstWhere((company) => company.id.toString() == blockModel.objects.companiesId)
                  .name;


              return GestureDetector(
                // onTap: () {
                //   context
                //       .read<FreeHomesBloc>()
                //       .add(GetFreeHomesByBlockIdEvent(blockId: blockModel.id));
                //   context.pushNamed(RouteNames.freeHomes);
                // },
                child: Card(
                  surfaceTintColor: Colors.white,
                  elevation: 15,
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
                      Stack(
                        children: [
                          Container(
                            height: 250,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: CachedNetworkImageProvider(
                                  "$baseUrlForImage/${blockModel.objects.image}",
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 5,
                                    offset: Offset(5, 5),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  blockModel.name,
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              blockModel.objects.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: false,
                              textAlign: TextAlign.start,
                            ),
                            Gap(10),
                            Text(
                              companyName,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Colors.indigo.shade600, fontWeight: FontWeight.bold),
                            ),
                            Gap(10),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(CupertinoIcons.map_pin_ellipse),
                                    Text("  Viloyat: ",style: context.titleMedium?.copyWith(fontWeight: FontWeight.bold),),
                                    Text(
                                      transliteratedRegionName,
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                                Gap(10),
                                Row(
                                  children: [
                                    Icon(Icons.location_on_rounded),
                                    Text("  Shaxar: ",style: context.titleMedium?.copyWith(fontWeight: FontWeight.bold),),
                                    Text(
                                      blockModel.objects.city,
                                      style: Theme.of(context).textTheme.bodyMedium,
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
            itemCount: state.blocs.length,
          );
        },
      ),
    );
  }
}
