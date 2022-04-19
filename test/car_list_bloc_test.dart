import 'package:bloc_test/bloc_test.dart';
import 'package:car_garage/bloc_cg/car_list/car_list_bloc.dart';
import 'package:car_garage/network/models/car_dto.dart';
import 'package:car_garage/repository/car_list_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'car_list_bloc_test.mocks.dart';

@GenerateMocks([CarListRepository])
void main() {
  late CarListRepository mockCarListRepository;
  late CarListBloc carListBloc;

  setUp(() {
    mockCarListRepository = MockCarListRepository();
    carListBloc = CarListBloc(mockCarListRepository);
  });

  group(
    'CarListBloc: FetchCarList group',
    () {
      List<CarDto> validCarsResponse = [
        CarDto(
          brand: "Honda",
          model: "Civic",
          registration: "WA12345",
          color: Colors.red,
          year: DateTime.now(),
          ownerId: "5e5e3d7fc0ea272d00000824",
          lng: 50.754,
          lat: 50.754,
        ),
      ];
      blocTest<CarListBloc, CarListState>(
        'on FetchCarList when successful',
        build: () {
          when(mockCarListRepository.fetchCarList())
              .thenAnswer((_) async => validCarsResponse);
          return carListBloc;
        },
        act: (bloc) => bloc.add(FetchCarList()),
        expect: () => [
          LoadingCarList(),
          CarListFetched(validCarsResponse),
        ],
      );
      blocTest<CarListBloc, CarListState>(
        'on FetchCarList when error',
        build: () {
          when(mockCarListRepository.fetchCarList())
              .thenAnswer((_) async => Future.error(Exception()));
          return CarListBloc(mockCarListRepository);
        },
        act: (bloc) => bloc.add(FetchCarList()),
        expect: () => [
          LoadingCarList(),
          FailedFetchCarList(),
        ],
        errors: () => [
          isA<Exception>(),
        ],
      );
    },
  );
}
