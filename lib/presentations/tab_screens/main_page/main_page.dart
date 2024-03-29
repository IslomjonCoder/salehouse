import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:crm/business_logic/blocs/payment_bloc/payment_bloc.dart';
import 'package:crm/data/service/api_service.dart';
import 'package:crm/presentations/tab_screens/no_connection/no_connection.dart';
import 'package:crm/utils/constants/colors.dart';
import 'package:crm/utils/constants/enums.dart';
import 'package:crm/utils/constants/image_strings.dart';
import 'package:crm/utils/constants/sizes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool hideCost = false;
  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu)),
        title: const Text('Bosh Sahifa'),
      ),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: () async {
          context.read<PaymentBloc>().add(PaymentInitialEvent());
          _refreshController.refreshCompleted();
        },
        child: BlocBuilder<PaymentBloc, PaymentState>(
          // listenWhen: (previous, current) {},
          bloc: BlocProvider.of<PaymentBloc>(context),
          buildWhen: (previous, current) =>
              current.status.isSuccess || current.status.isLoading || current.status.isFailure,
          builder: (context, state) {
            if (state.status == Status.loading) {
              return Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: TColors.tPrimaryColor,
                  size: TSizes.imageXs,
                ),
              );
            }
            if (state.status == Status.failure) {
              return NoConnection(errorText: state.error ?? "");
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  const Gap(10),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(4, 4),
                              blurRadius: 4,
                            )
                          ],
                          image: const DecorationImage(
                            image: AssetImage(TImages.cardBack),
                            colorFilter:
                                ColorFilter.mode(TColors.tPrimaryColor, BlendMode.softLight),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10.0, left: 5.0, right: 5.0),
                                child: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: hideCost
                                          ? '------'
                                          : NumberFormat.simpleCurrency(
                                              locale: 'uz_UZ',
                                              name: 'UZS',
                                              decimalDigits: 0,
                                            )
                                              .format(
                                                context
                                                    .read<PaymentBloc>()
                                                    .state
                                                    .dailyBenefit
                                                    .toDouble(),
                                              )
                                              .toString(),
                                      style: context.displaySmall
                                          ?.copyWith(color: TColors.tPrimaryColor, fontSize: 32),
                                    ),
                                  ]),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            const Text("Kunlik tushum"),
                            // IconButton(onPressed: (){
                            //   print(state.dailyBenefit.toDouble());
                            // }, icon: const Icon(Icons.chevron_right)),
                            Lottie.asset(
                              TImages.statistic,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 20,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              hideCost = !hideCost;
                            });
                          },
                          icon: hideCost
                              ? const Icon(
                                  CupertinoIcons.eye_slash,
                                  color: Colors.white,
                                )
                              : const Icon(
                                  CupertinoIcons.eye,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                      const Positioned(
                          bottom: 10,
                          left: 25,
                          child: Text(
                            "CRM",
                          )),
                    ],
                  ),
                  const Gap(20),
                  BlocBuilder<PaymentBloc, PaymentState>(
                    builder: (context, state) {
                      final models = state.data;
                      final today = DateTime.now();
                      final filteredModels = models.where((model) {
                        final modelDate = DateTime.parse(model.date);
                        return modelDate.day == today.day &&
                            modelDate.month == today.month &&
                            modelDate.year == today.year;
                      }).toList();
                      return filteredModels.isEmpty
                          ? Center(child: Lottie.asset(TImages.main))
                          : ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                final model = filteredModels[index];
                                return ListTile(
                                  leading: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: AvatarImage(
                                          backgroundColor: TColors.tPrimaryColor,
                                          size: 80,
                                          child: Text(
                                            model.contract.custom.name[0].toUpperCase() +
                                                model.contract.custom.surname[0].toUpperCase(),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w900,
                                                color: Colors.white70),
                                          ),
                                        ),
                                      )),
                                  title: Text(
                                    NumberFormat.simpleCurrency(
                                            locale: 'uz', name: 'so`m', decimalDigits: 0)
                                        .format(double.parse(model.sum)),
                                    style: context.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    "${model.contract.custom.name} ${model.contract.custom.surname}",
                                    style: context.bodyMedium,
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: TSizes.xs),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(TSizes.xs),
                                          color: TColors.tPrimaryColor,
                                        ),
                                        child: Text(
                                          model.types.name,
                                          style: context.bodyLarge?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Text(
                                        model.date,
                                        style: context.bodySmall
                                            ?.copyWith(color: Colors.grey, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (BuildContext context, int index) {
                                return const Divider();
                              },
                              itemCount: filteredModels.length,
                            );
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
