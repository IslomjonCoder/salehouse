import 'package:crm/utils/constants/colors.dart';
import 'package:crm/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TRoundedContainer extends StatelessWidget {
  const TRoundedContainer({
    super.key,
    this.width,
    this.height,
    this.radius = TSizes.cardRadiusSm,
    this.child,
    this.showBorder = false,
    this.borderColor = TColors.tBlack,
    this.backgroundColor = TColors.tWhite,
    this.padding,
    this.margin,
    this.showShadow = true,
  });

  final double? width;
  final double? height;
  final double radius;
  final Widget? child;
  final bool showBorder;
  final bool showShadow;
  final Color borderColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(radius),
          border: showBorder ? Border.all(color: borderColor) : null,
          // {
          //     box-shadow: 0 0 #0000, 0 0 #0000, 0 0 10px 1px #bb89d585;
          // }
          boxShadow: [
            // box-shadow: 0 0 #0000, 0 0 #0000, 0 0 10px 1px #bb89d585;

            BoxShadow(
              // bb89d585
              color: const Color(0xFFbb89d5).withOpacity(0.47),
              blurRadius: 10,
              spreadRadius: 1,
            )
          ]),
      child: child,
    );
  }
}
