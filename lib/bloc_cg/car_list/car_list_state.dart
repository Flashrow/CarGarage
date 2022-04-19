part of 'car_list_bloc.dart';

@immutable
abstract class CarListState extends Equatable {}

class CarListInitial extends CarListState {
  @override
  List<Object> get props => [];
}

class LoadingCarList extends CarListState {
  @override
  List<Object> get props => [];
}

class CarListFetched extends CarListState {
  final List<CarDto> carList;

  CarListFetched(this.carList);
  @override
  List<Object> get props => [carList];
}

class FailedFetchCarList extends CarListState {
  @override
  List<Object> get props => [];
}
