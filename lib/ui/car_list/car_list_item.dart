import 'package:flutter/material.dart';

class CarListItem extends StatelessWidget {
  final String registrationNumber;
  final String carBrand;
  final String carModel;
  final String carColor;
  const CarListItem(
      {Key? key,
      required this.registrationNumber,
      required this.carBrand,
      required this.carModel,
      required this.carColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                carBrand,
                style: const TextStyle(color: Colors.black),
              ),
              Text(
                carModel,
                style: const TextStyle(color: Colors.black),
              )
            ],
          ),
          Row(
            children: [
              Text(
                registrationNumber,
                style: const TextStyle(color: Colors.black),
              ),
              Text(
                carColor,
                style: const TextStyle(color: Colors.black),
              )
            ],
          )
        ],
      ),
    );
  }
}
