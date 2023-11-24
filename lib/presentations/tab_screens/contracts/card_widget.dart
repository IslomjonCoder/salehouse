import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReportCard extends StatelessWidget {
  final String title;
  final String price;
  final String icon;
  final Color cardColor;
  const ReportCard({
    super.key, required this.title, required this.price, required this.icon, required this.cardColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
              20
          ),
          color: cardColor,
          boxShadow: const [
            BoxShadow(
              offset: Offset(4, 6),
            )
          ],
          gradient: LinearGradient(
              colors: [
                cardColor,
                cardColor,
                cardColor,
                cardColor,
                cardColor,
                Colors.white,

              ]
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(title, style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
          Wrap(
            children: [
              Text("\$ $price ", style: context.labelLarge?.copyWith(color: Colors.white)),
              SvgPicture.asset(icon,),
            ],
          ),
        ],
      ),
    );
  }
}


class ReportCardDataModel {
  final String title;
  final String price;
  final Icon icon;
  final Color cardColor;

  ReportCardDataModel({
    required this.title,
    required this.price,
    required this.icon,
    required this.cardColor,
  });
}
