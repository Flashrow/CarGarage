import 'package:car_garage/common/styles.dart';
import 'package:car_garage/ui/base_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../common/colors.dart';
import '../../network/models/car_dto.dart';
import 'car_detail_item.dart';
import 'owner_details_widget.dart';

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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, bottom: 16),
            child: Text(
              "carDetails".tr(),
              style: title1Text,
            ),
          ),
          Divider(
            color: cPrimaryColor.withOpacity(0.7),
            thickness: 2,
            height: 2,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          "vehicleData".tr() + ": ",
                          style: title2Text,
                        ),
                        const SizedBox(height: 8),
                        CarDetailItem(
                          title: "brand".tr() + ":",
                          description: carDto.brand.toString(),
                        ),
                        CarDetailItem(
                          title: "model".tr() + ":",
                          description: carDto.model.toString(),
                        ),
                        CarDetailItem(
                          title: "registrationNumber".tr(),
                          description: carDto.registration.toString(),
                        ),
                        CarDetailItem(
                          title: "productionYear".tr() + ":",
                          description: carDto.year?.year.toString() ?? "",
                        ),
                        const SizedBox(height: 14),
                        Text(
                          "ownerData".tr() + ":",
                          style: title2Text,
                        ),
                        const OwnerDetailsWidget(),
                        const SizedBox(height: 8),
                        Text(
                          "carLocation".tr() + ":",
                          style: title2Text,
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                  mapWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget mapWidget() {
    return SizedBox(
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
    );
  }
}
