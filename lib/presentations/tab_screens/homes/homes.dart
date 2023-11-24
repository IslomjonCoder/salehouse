import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:crm/utils/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomesScreen extends StatelessWidget {
  const HomesScreen({super.key});

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
        title: const Text('Uylar'),
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      margin: const EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: TColors.tPrimaryColor,
                      ),
                      child: Center(child: Text("A Bloc $index-uy",style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold,color: Colors.white),)),
                    ),
                    Row(
                      children: [
                        Text("(q.|x.s.|m2): ",style: context.titleMedium?.copyWith(fontWeight: FontWeight.bold),),
                        Text(
                          "1|1|37.5m2",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Ta'mirlangan narxi (1m2): ",style: context.titleMedium?.copyWith(fontWeight: FontWeight.bold),),
                        Text(
                          "8773465 UZS",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Boshlang'ich to'lov: ",style: context.titleMedium?.copyWith(fontWeight: FontWeight.bold),),
                        Text(
                          "62 268 750 UZS",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Ta'mir holati: ",style: context.titleMedium?.copyWith(fontWeight: FontWeight.bold),),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.orange,
                          ),
                          child: Text(
                            "Ta'mirsiz",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Bino turi (Turar/Noturar): ",style: context.titleMedium?.copyWith(fontWeight: FontWeight.bold),),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.green,
                          ),
                          child: Text(
                            "Turar",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Status: ",style: context.titleMedium?.copyWith(fontWeight: FontWeight.bold),),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.green,
                          ),
                          child: Text(
                            "Bo'sh",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
