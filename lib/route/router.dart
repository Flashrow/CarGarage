import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:car_garage/ui/add_car/add_car_screen.dart';
import 'package:car_garage/ui/car_details/car_details_screen.dart';
import 'package:car_garage/ui/car_list/car_list_screen.dart';

const String carListScreen = "CarListScreen";
const String carDetailsScreen = "CarDetailsScreen";
const String addCarScreen = "addCarsScreen";

@CustomAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(
      initial: true,
      page: CarListScreen,
      path: carListScreen,
    ),
    CustomRoute(
      initial: false,
      page: CarDetailsScreen,
      path: carDetailsScreen,
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      durationInMilliseconds: 300,
    ),
    CustomRoute(
      initial: false,
      page: AddCarScreen,
      path: addCarScreen,
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      durationInMilliseconds: 300,
    ),
  ],
)
class $AppRouter {}
