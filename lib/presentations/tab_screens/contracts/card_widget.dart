import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:crm/presentations/tab_screens/homes/homes.dart';
import 'package:flutter/material.dart';

class ReportCard extends StatelessWidget {
  final String title;
  final String price;
  final Color cardColor;
  const ReportCard({
    super.key, required this.title, required this.price, required this.cardColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
              20
          ),
          color: cardColor,
          boxShadow: const [
            // BoxShadow(
            //   offset: Offset(4, 6),
            // )
          ],
          gradient: const LinearGradient(
              colors: [
                Color(0xFFad5389),
                Color(0xFF3c1053),
              ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,

          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(title, style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
          const Icon(Icons.account_balance_wallet, color: Colors.white,),
          Text(formatMoney(double.parse(price)) , style: context.labelLarge?.copyWith(color: Colors.white),overflow: TextOverflow.ellipsis,maxLines: 2,),
        ],
      ),
    );
  }
}


class ReportCardDataModel {
  final String title;
  final String price;
  final Color cardColor;

  ReportCardDataModel({
    required this.title,
    required this.price,
    required this.cardColor,
  });
}