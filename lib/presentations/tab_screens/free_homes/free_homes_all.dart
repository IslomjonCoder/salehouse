import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:crm/business_logic/blocs/free_homes/free_homes_bloc.dart';
import 'package:crm/business_logic/blocs/general_bloc/general_bloc.dart';
import 'package:crm/presentations/routes/routes.dart';
import 'package:crm/utils/constants/colors.dart';
import 'package:crm/utils/constants/enums.dart';
import 'package:crm/utils/constants/image_strings.dart';
import 'package:crm/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class FreeHomesAll extends StatefulWidget {
  const FreeHomesAll({super.key});

  @override
  State<FreeHomesAll> createState() => _FreeHomesAllState();
}

class _FreeHomesAllState extends State<FreeHomesAll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        scrolledUnderElevation: 0,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_outlined)),
        title: const Text('Uylar'),
      ),
      body: BlocConsumer<FreeHomesBloc, FreeHomesState>(
          buildWhen: (prev, current) => current.status.isSuccess || current.status.isLoading || current.status.isFailure,
          builder: (context, state) {
            if (state.status.isLoading) {
              return Center(
                  child: LoadingAnimationWidget.inkDrop(
                    color: TColors.tPrimaryColor,
                    size: TSizes.lg
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
            return state.data.isEmpty
                ? const Center(child: Text("Bo'sh uylar mavjud emas"))
                : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${state.data.length} ",
                                    style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Bo'sh uylar soni",
                                    style: context.textTheme.titleMedium?.copyWith(color: Colors.grey),
                                  ),
                                ],
                              ),
                              IconButton.filled(onPressed: (){}, icon: const Icon(CupertinoIcons.home))
                            ],
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: ListView.builder(
                                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                                    itemBuilder: (context, index) {
                      final model = state.data[index];
                      return GestureDetector(
                        onTap: () {
                          context.pushNamed(RouteNames.freeHomeDetail, arguments: model);
                        },
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Card(
                                surfaceTintColor: Colors.white,
                                shadowColor: Colors.black,
                                elevation: 35,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image(
                                            image: model.image != null
                                                ? CachedNetworkImageProvider(model.image!)
                                                : const AssetImage(
                                              TImages.apartment,
                                            ) as ImageProvider,height: TSizes.imageLg,)),
                                      const Gap(TSizes.defaultSpace),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            // Text('Uy raqami: ${model.number}'),
                                            Text('Qavat: ${model.stage}'),
                                            Text('Xonalar soni: ${model.rooms}'),
                                            Text.rich(
                                              TextSpan(
                                                text: 'Maydoni: ',
                                                style: DefaultTextStyle.of(context).style,
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: '${model.square}m²',
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.brown,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text.rich(
                                              TextSpan(
                                                text: 'Xolati: ',
                                                style: DefaultTextStyle.of(context).style,
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: model.isrepaired == 1.toString() ? "Tamirlangan" : "Tamirlanmagan",
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: model.isrepaired == 1.toString() ? Colors.green : Colors.red,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
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
                                        offset: Offset(1, 1),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text('${model.number} - uy',style: const TextStyle(color: Colors.black),),
                                )
                            )
                          ],
                        ),
                      );
                                    },
                                    itemCount: state.data.length,
                                  ),
                    ),
                  ],
                );
          },
          listener: (context, state) {}),
    );
  }
}
