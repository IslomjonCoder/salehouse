import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:crm/presentations/common_widgets/rounded_container.dart';
import 'package:crm/utils/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: TAppTheme.theme,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            FilledButton(onPressed: () {}, child: const Text('Filled Button')),
            FilledButton.tonal(onPressed: () {}, child: const Text('Tonal Button')),
            FilledButton.tonalIcon(
                onPressed: () {}, icon: const Icon(Icons.add), label: const Text('Tonal Button')),
            FilledButton.icon(
                onPressed: () {}, icon: const Icon(Icons.add), label: const Text('Filled Button')),
            OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: const Text('Outlined Button')),
            OutlinedButton(onPressed: () {}, child: const Text('Outlined Button')),
            ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: const Text('Elevated Button')),
            ElevatedButton(onPressed: () {}, child: const Text('Elevated Button')),
            Container(
              height: 100,
              width: 200,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black),
              ),
              child: Text('Container', style: GoogleFonts.roboto()),
            ),
            TRoundedContainer(
                padding: const EdgeInsets.all(16),
                child: Text('Container', style: GoogleFonts.roboto())),
            Chip(label: const Text('Chip'), backgroundColor: Colors.red, side: BorderSide.none),
            InputChip(label: const Text('Input Chip'), onSelected: (value) {}),
            ActionChip.elevated(label: const Text('Action Chip'), onPressed: () {}),
            ChoiceChip(label: const Text('Choice Chip'), selected: true, onSelected: (value) {}),
            FilterChip(label: const Text('Filter Chip'), onSelected: (_) {}),
            IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
            IconButton.filled(onPressed: () {}, icon: const Icon(Icons.add)),
            IconButton.outlined(onPressed: () {}, icon: const Icon(Icons.add)),
            IconButton.filledTonal(onPressed: () {}, icon: const Icon(Icons.add)),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Qidiruv',
                suffixIcon: Icon(Icons.search),
              ),
            ).paddingAll(8),
            const Card(
              child: Padding(padding: EdgeInsets.all(8.0), child: Text('Card')),
            ),
            const CircularProgressIndicator(),
            const LinearProgressIndicator()
          ]),
        ),
      ),
    );
  }
}

