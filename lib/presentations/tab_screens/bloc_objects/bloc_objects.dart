import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:crm/business_logic/blocs/objects_bloc/objects_bloc.dart';
import 'package:crm/presentations/routes/routes.dart';
import 'package:crm/presentations/tab_screens/blocs/blocs.dart';
import 'package:crm/utils/constants/api_constants.dart';
import 'package:crm/utils/constants/colors.dart';
import 'package:crm/utils/constants/enums.dart';
import 'package:crm/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BlocObjectsScreen extends StatelessWidget {
  const BlocObjectsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
        title: const Text('Blok Obyektlari'),
      ),
      body: BlocBuilder<ObjectsBloc, ObjectsState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return Center(
                child:
                    LoadingAnimationWidget.inkDrop(color: TColors.tPrimaryColor, size: TSizes.lg));
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
                      context.read<ObjectsBloc>().add(GetObjectsEvent());
                    },
                    child: const Text('Try Again'),
                  )
                ],
              ),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              final object = state.objects[index];
              return Padding(
                padding: const EdgeInsets.all(TSizes.sm),
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(TSizes.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                            onTap: () => context.pushNamed(RouteNames.imagePreview,arguments: object.image ),
                            child: Card(
                                child: CachedNetworkImage(
                              imageUrl: "$baseUrlForImage/${object.image}",
                              height: 200,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ))),
                        const Gap(TSizes.base),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: TSizes.xs),
                          margin: const EdgeInsets.only(bottom: TSizes.xs),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(TSizes.base),
                            color: TColors.tPrimaryColor,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            object.name.toUpperCase(),
                            style: context.titleMedium?.copyWith(color: Colors.white),
                          ),
                        ),
                        Wrap(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: "Kompaniya nomi: ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                    children: [
                                      TextSpan(
                                        text: object.companies.name,
                                        style: Theme.of(context).textTheme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: "Viloyat: ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                    children: [
                                      TextSpan(
                                        text: object.regions.name,
                                        style: Theme.of(context).textTheme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: "Shahar: ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                    children: [
                                      TextSpan(
                                        text: object.city,
                                        style: Theme.of(context).textTheme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: "Bloklar soni: ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                    children: [
                                      TextSpan(
                                        text: object.padez,
                                        style: Theme.of(context).textTheme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: "Qavatligi: ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                    children: [
                                      TextSpan(
                                        text: object.stage,
                                        style: Theme.of(context).textTheme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: "Boshlanish vaqti: ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                    children: [
                                      TextSpan(
                                        text: getDateFromDateTimeString(object.start.toString()),
                                        style: Theme.of(context).textTheme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: "Tugash vaqti: ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                    children: [
                                      TextSpan(
                                        text: getDateFromDateTimeString(object.end.toString()),
                                        style: Theme.of(context).textTheme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: state.objects.length,
          );
        },
      ),
    );
  }
}
