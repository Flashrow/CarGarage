import 'package:car_garage/ui/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../network/models/car_dto.dart';

class CarDetailsScreen extends StatelessWidget {
  final CarDto carDto;
  const CarDetailsScreen({
    Key? key,
    required this.carDto,
  }) : super(key: key);
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(52.041847, 19.543805),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Szczegóły samochodu"),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text("Pozycja samochodu: "),
              ),
              SizedBox(
                height: 350,
                child: GoogleMap(
                  markers: {
                    Marker(
                      markerId: MarkerId(carDto.registration ?? ""),
                      position: LatLng(carDto.lat?.toDouble() ?? 52.041847,
                          carDto.lng?.toDouble() ?? 19.543805),
                    ),
                  },
                  initialCameraPosition: CameraPosition(
                    target: LatLng(carDto.lat?.toDouble() ?? 52.041847,
                        carDto.lng?.toDouble() ?? 19.543805),
                    zoom: 8,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
