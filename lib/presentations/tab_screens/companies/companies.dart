import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
        backgroundColor: Colors.white,
        centerTitle: true,
        scrolledUnderElevation: 0,
        leading: IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu)),
        title: const Text("Kompaniyalar Ro'yxati"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
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
                            "10 ",
                            style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Kompaniyalar soni",
                            style: context.textTheme.titleMedium?.copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                      IconButton.filled(onPressed: (){}, icon: const Icon(CupertinoIcons.briefcase_fill))
                    ],
                  ),
                ),
              ),
            ),
            const Gap(10),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => Column(
                  children: [
                    const Gap(10),
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ООО CTS UNITED DEVELOPMENT ",
                                style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Djurayev Farhod Ruzikulovich",
                                style: context.textTheme.titleMedium,
                              ),
                              Text("Файзли, дом 3", style: context.textTheme.titleSmall),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Gap(10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
