import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:crm/business_logic/blocs/payment_bloc/payment_bloc.dart';
import 'package:crm/utils/constants/colors.dart';
import 'package:crm/utils/constants/enums.dart';
import 'package:crm/utils/constants/image_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool hideCost = false;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (context.read<PaymentBloc>().state.paymentModel?.nextPageUrl != null) {
          context.read<PaymentBloc>().add(PaymentNextPageEvent());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu)),
        title: const Text('Bosh Sahifa'),
      ),
      body: SafeArea(
        child: BlocBuilder<PaymentBloc, PaymentState>(
          // listenWhen: (previous, current) {},
          bloc: BlocProvider.of<PaymentBloc>(context),
          buildWhen: (previous, current) =>
              current.status.isSuccess || current.status.isLoading || current.status.isFailure,
          builder: (context, state) {
            if (state.status == Status.loading) {
              return const Center(
                child: CircularProgressIndicator(
                    // color: Colors.white,
                    ),
              );
            }
            if (state.status == Status.failure) {
              return Center(
                child: Text(state.error ?? ''),
              );
              // NoConnection(
              //   onTap: () {
              //     context.read<GeneralBloc>().add(GeneralInitialEvent());
              //   },
              //   errorText: state.error ?? "");
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  const Gap(10),
                  Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(4, 4),
                              blurRadius: 4,
                            )
                          ],
                          image: DecorationImage(
                            image: const AssetImage(TImages.cardBack),
                            colorFilter:
                                ColorFilter.mode(Colors.amber.shade700, BlendMode.softLight),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Column(
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                    text: hideCost
                                        ? '------'
                                        : context
                                            .read<PaymentBloc>()
                                            .state
                                            .dailyBenefit
                                            .toDouble()
                                            .toStringAsFixed(2),
                                    style: context.displaySmall
                                        ?.copyWith(color: TColors.tPrimaryColor),
                                  ),
                                  TextSpan(
                                    text: ' so\'m',
                                    style:
                                        context.labelLarge?.copyWith(color: TColors.tPrimaryColor),
                                  )
                                ])),
                              ),
                            ),
                            const Text("Kunlik tushum"),
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
                              ? const Icon(CupertinoIcons.eye_slash)
                              : const Icon(CupertinoIcons.eye),
                        ),
                      ),
                      const Positioned(bottom: 10, left: 25, child: Text("CRM")),
                    ],
                  ),
                  const Gap(20),
                  Center(
                      child: Text(
                    "To'lovlar",
                    style: context.headlineSmall,
                  )),
                  state.data.isEmpty
                      ? Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(TImages.empty),
                            // No documents translate to uzbek
                            Text(
                              "Malumotlar bo'sh",
                              style: context.titleLarge?.copyWith(
                                color: TColors.tPrimaryColor,
                              ),
                            ),
                          ],
                        ))
                      : RefreshIndicator(
                          onRefresh: () async {
                            setState(() {});
                          },
                          child: ListView.separated(
                            shrinkWrap: true,
                            controller: scrollController,
                            separatorBuilder: (BuildContext context, int index) {
                              return const Gap(10);
                            },
                            physics: const BouncingScrollPhysics(),
                            itemCount: state.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                                onTap: () {},
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
                                        state.data[index].contract.custom.name[0].toUpperCase() + state.data[index].contract.custom.surname[0].toUpperCase(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white70
                                        ),
                                      ),
                                    ),
                                  )
                                ),
                                title: Text(
                                  state.paymentModel!.data[index].sum,
                                  style: context.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                 "${state.data[index].contract.custom.name} ${state.data[index].contract.custom.surname}",
                                  style: context.bodyMedium,
                                ),
                                trailing: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: TColors.tPrimaryColor,
                                      ),
                                      child: Text(
                                        state.paymentModel!.data[index].types.name,
                                        style: context.bodyLarge?.copyWith(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.white),
                                      ),
                                    ),
                                    Text(
                                      state.data[index].date,
                                      style: context.bodySmall?.copyWith(color: Colors.grey, fontSize: 12),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
