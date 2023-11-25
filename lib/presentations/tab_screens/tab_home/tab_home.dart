import 'package:flutter/material.dart';

class TabHomeScreen extends StatelessWidget {
  const TabHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TabHome'),
      ),
      body: const Center(
        child: Center(child: Text('Tab Home'),),
      ),
    );
  }
}
