import 'package:flutter/material.dart';

class BlocsScreen extends StatelessWidget {
  const BlocsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Scaffold.of(context).openDrawer();
        }, icon: const Icon(Icons.menu)),
        title: const Text('Bloklar'),
      ),
    );
  }
}
