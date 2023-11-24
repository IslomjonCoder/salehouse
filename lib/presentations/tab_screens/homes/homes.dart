import 'package:flutter/material.dart';

class HomesScreen extends StatelessWidget {
  const HomesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Scaffold.of(context).openDrawer();
        }, icon: const Icon(Icons.menu)),
        title: const Text('Uylar'),
      ),
    );
  }
}
