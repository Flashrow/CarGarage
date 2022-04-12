import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddCarMapWidget extends StatefulWidget {
  const AddCarMapWidget({Key? key}) : super(key: key);
  @override
  State<AddCarMapWidget> createState() => _AddCarMapWidgetState();
}

class _AddCarMapWidgetState extends State<AddCarMapWidget> {
  final Completer<GoogleMapController> _controller = Completer();
  Marker carLocation = const Marker(
    markerId: MarkerId('carLocation'),
    visible: false,
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: LatLng(52.041847, 19.543805),
            zoom: 5.5,
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          onLongPress: (LatLng latLng) => setMarker(latLng),
          onTap: (LatLng latLng) => setMarker(latLng),
          markers: {
            carLocation,
          },
          gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
            Factory<OneSequenceGestureRecognizer>(
              () => EagerGestureRecognizer(),
            ),
          }),
    );
  }

  void setMarker(LatLng latLng) {
    setState(() {
      carLocation = Marker(
        markerId: const MarkerId('carLocation'),
        position: latLng,
        visible: true,
      );
    });
  }
}
