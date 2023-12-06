import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:crm/utils/constants/image_strings.dart';
import 'package:crm/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoConnection extends StatelessWidget {
  const NoConnection({super.key, required this.errorText});
  final String errorText;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset(
          TImages.wind,
        ),
        Center(
          child: Lottie.asset(
            TImages.connection,
            height: MediaQuery.of(context).size.height / 4,
          ),
        ),
        const Text(
          "Oops !",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        Text(
          errorText,
          style: const TextStyle(
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ).paddingSymmetric(horizontal: TSizes.sm),
      ],
    );
  }
}
