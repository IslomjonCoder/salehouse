import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:crm/business_logic/blocs/payment_bloc/payment_bloc.dart';
import 'package:crm/utils/constants/colors.dart';
import 'package:crm/utils/constants/enums.dart';
import 'package:crm/utils/constants/image_strings.dart';
import 'package:crm/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool hideCost = false;
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<PaymentBloc>().add(PaymentInitialEvent());
        },
        child: const Icon(Icons.list_alt),
      ),
      appBar: AppBar(

        leading: IconButton(
          onPressed: () => Scaffold.of(context).openDrawer(),
          icon: const Icon(Icons.menu),
        ),
        title: const Text('To\'lovlar Ro\'yxati'),
        actions: [
          IconButton(
            onPressed: () => _selectDate(context),
            icon: const Icon(Icons.calendar_today),
          ),
        ],
      ),
      body: BlocBuilder<PaymentBloc, PaymentState>(
        bloc: BlocProvider.of<PaymentBloc>(context),
        buildWhen: (previous, current) =>
            current.status.isSuccess || current.status.isLoading || current.status.isFailure,
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
                      context.read<PaymentBloc>().add(PaymentInitialEvent());
                    },
                    child: const Text('Qayta Urinish'),
                  ),
                ],
              ),
            );
          }
          return state.data.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(TImages.empty),
                      Text(
                        "Malumotlar bo'sh",
                        style: context.titleLarge?.copyWith(
                          color: TColors.tPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        controller: context.read<PaymentBloc>().scrollController,
                        separatorBuilder: (BuildContext context, int index) => const Gap(TSizes.sm),
                        itemCount: state.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          final data = state.data[index];
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
                                    state.data[index].contract.custom.name[0].toUpperCase() +
                                        state.data[index].contract.custom.surname[0].toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              NumberFormat.simpleCurrency(
                                locale: 'uz',
                                name: 'so`m',
                                decimalDigits: 0,
                              ).format(double.parse(state.data[index].sum)),
                              style: context.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              "${state.data[index].contract.custom.name} ${state.data[index].contract.custom.surname}",
                              style: context.bodyMedium,
                            ),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: TSizes.xs),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(TSizes.xs),
                                    color: TColors.tPrimaryColor,
                                  ),
                                  child: Text(
                                    data.types.name,
                                    style: context.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Text(
                                  state.data[index].date,
                                  style: context.bodySmall?.copyWith(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      // ignore: use_build_context_synchronously
      context.read<PaymentBloc>().add(FilterPaymentsByDateEvent(selectedDate!));
    }
  }
}
