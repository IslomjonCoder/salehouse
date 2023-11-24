import 'package:crm/presentations/tab_screen/tab_screen.dart';
import 'package:flutter/material.dart';


class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Scaffold.of(context).openDrawer();
        }, icon: const Icon(Icons.menu)),
        title: const Text("To'lovlar Ro'yxati"),
      ),
    );
  }
}
