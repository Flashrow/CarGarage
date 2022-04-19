import 'package:car_garage/common/colors.dart';
import 'package:car_garage/common/styles.dart';
import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final void Function()? onTap;
  final String? title;
  final double? width;
  final bool isActive;
  const CustomButtonWidget({
    Key? key,
    this.onTap,
    this.title,
    this.width,
    this.isActive = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isActive ? cPrimaryColor : Colors.grey,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: InkWell(
        onTap: isActive ? onTap : null,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: SizedBox(
          width: width,
          child: Center(
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
        ),
      ),
    );
  }
}
