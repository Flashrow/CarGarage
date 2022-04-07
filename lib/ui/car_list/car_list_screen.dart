import 'package:car_garage/ui/car_list/car_list_item.dart';
import 'package:flutter/material.dart';

class CarListScreen extends StatelessWidget {
  const CarListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return const CarListItem(
            carBrand: "Honda",
            carModel: "civic",
            carColor: "Bialy",
            registrationNumber: "SK13TY",
          );
        },
      ),
    ));
  }
}
