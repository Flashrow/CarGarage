import 'package:car_garage/common/colors.dart';
import 'package:car_garage/common/styles.dart';
import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final void Function()? onTap;
  final String? title;
  const CustomButtonWidget({
    Key? key,
    this.onTap,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: cPrimaryColor,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: InkWell(
        onTap: onTap,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            title ?? "title",
            style: regularSemiboldText.apply(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
