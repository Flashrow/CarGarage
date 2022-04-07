// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;

import '../ui/add_car/add_car_screen.dart' as _i3;
import '../ui/car_details/car_details_screen.dart' as _i2;
import '../ui/car_list/car_list_screen.dart' as _i1;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    CarListScreenRoute.name: (routeData) {
      return _i4.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i1.CarListScreen(),
          opaque: true,
          barrierDismissible: false);
    },
    CarDetailsScreenRoute.name: (routeData) {
      return _i4.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i2.CarDetailsScreen(),
          transitionsBuilder: _i4.TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300,
          opaque: true,
          barrierDismissible: false);
    },
    AddCarScreenRoute.name: (routeData) {
      return _i4.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i3.AddCarScreen(),
          transitionsBuilder: _i4.TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig('/#redirect',
            path: '/', redirectTo: 'CarListScreen', fullMatch: true),
        _i4.RouteConfig(CarListScreenRoute.name, path: 'CarListScreen'),
        _i4.RouteConfig(CarDetailsScreenRoute.name, path: 'CarDetailsScreen'),
        _i4.RouteConfig(AddCarScreenRoute.name, path: 'addCarsScreen')
      ];
}

/// generated route for
/// [_i1.CarListScreen]
class CarListScreenRoute extends _i4.PageRouteInfo<void> {
  const CarListScreenRoute()
      : super(CarListScreenRoute.name, path: 'CarListScreen');

  static const String name = 'CarListScreenRoute';
}

/// generated route for
/// [_i2.CarDetailsScreen]
class CarDetailsScreenRoute extends _i4.PageRouteInfo<void> {
  const CarDetailsScreenRoute()
      : super(CarDetailsScreenRoute.name, path: 'CarDetailsScreen');

  static const String name = 'CarDetailsScreenRoute';
}

/// generated route for
/// [_i3.AddCarScreen]
class AddCarScreenRoute extends _i4.PageRouteInfo<void> {
  const AddCarScreenRoute()
      : super(AddCarScreenRoute.name, path: 'addCarsScreen');

  static const String name = 'AddCarScreenRoute';
}
