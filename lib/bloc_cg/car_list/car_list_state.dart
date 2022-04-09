part of 'car_list_bloc.dart';

@immutable
abstract class CarListState {}

class CarListInitial extends CarListState {}

class LoadingCarList extends CarListState {}

class CarListFetched extends CarListState {
  final List<CarDto> carList;

  CarListFetched(this.carList);
}

class FailedFetchCarList extends CarListState {}
