import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlocObjectsScreen extends StatelessWidget {
  const BlocObjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Scaffold.of(context).openDrawer();
        }, icon: const Icon(Icons.menu)),
        title: const Text('Blok Obyektlari'),
      ),
    );
  }
}
