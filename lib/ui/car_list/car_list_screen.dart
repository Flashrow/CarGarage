import 'package:car_garage/common/colors.dart';
import 'package:car_garage/ui/car_list/car_list_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CarListScreen extends StatelessWidget {
  const CarListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
          child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {},
          ),
          appBar: AppBar(
            backgroundColor: cPrimaryColor,
            actions: [
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/flag_pl.png',
                  height: 36,
                ),
              ),
              const SizedBox(width: 24),
            ],
            title: Text(
              "Car garage",
              style: GoogleFonts.fredokaOne(fontSize: 24),
            ),
          ),
          body: Column(
            children: [
              carListTitle(),
              Expanded(
                child: ListView.builder(
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
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget carListTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, bottom: 16),
          child: Text(
            "Lista samochodów:",
            textAlign: TextAlign.left,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Divider(
          color: cPrimaryColor.withOpacity(0.7),
          thickness: 2,
          height: 2,
        ),
      ],
    );
  }
}
