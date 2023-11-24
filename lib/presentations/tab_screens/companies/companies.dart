import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:crm/business_logic/blocs/companies_bloc/companies_bloc.dart';
import 'package:crm/utils/constants/colors.dart';
import 'package:crm/utils/constants/enums.dart';
import 'package:crm/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:translit/translit.dart';

class CompaniesScreen extends StatefulWidget {
  const CompaniesScreen({super.key});

  @override
  State<CompaniesScreen> createState() => _CompaniesScreenState();
}

class _CompaniesScreenState extends State<CompaniesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(), icon: const Icon(Icons.menu)),
        title: const Text("Kompaniyalar Ro'yxati"),
      ),
      body: BlocBuilder<CompaniesBloc, CompaniesState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return LoadingAnimationWidget.bouncingBall(
                color: TColors.tPrimaryColor, size: TSizes.lg);
          }
          else if (state.status.isFailure) {
            return Center(
              child: Text(state.error.toString()),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: TSizes.base),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(TSizes.md),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.companies.length.toString(),
                                style: context.textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "Kompaniyalar soni",
                                style: context.textTheme.titleMedium?.copyWith(color: Colors.grey),
                              ),
                            ],
                          ),
                          IconButton.filled(
                              onPressed: () {}, icon: const Icon(CupertinoIcons.briefcase_fill))
                        ],
                      ),
                    ),
                  ),
                ),
                const Gap(TSizes.base),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.companies.length,
                    itemBuilder: (context, index) {
                      final company = state.companies[index];
                      return Column(
                      children: [
                        // const Gap(TSizes.base),
                        SizedBox(
                          width: double.infinity,
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(TSizes.md),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    company.name ,
                                    style: context.textTheme.titleMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    company.director,
                                    style: context.textTheme.titleMedium,
                                  ),
                                  Text( Translit().toTranslit(source: company.address)  , style: context.textTheme.titleSmall),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Gap(TSizes.base),
                      ],
                    );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
