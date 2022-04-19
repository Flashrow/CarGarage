import 'package:bloc/bloc.dart';
import 'package:car_garage/repository/car_list_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../network/models/car_dto.dart';

part 'car_list_event.dart';
part 'car_list_state.dart';

class CarListBloc extends Bloc<CarListEvent, CarListState> {
  final CarListRepository _carListRepository;
  CarListBloc(this._carListRepository) : super(CarListInitial()) {
    on<FetchCarList>((event, emit) async {
      emit(LoadingCarList());
      try {
        List<CarDto> carList = await _carListRepository.fetchCarList();
        emit(CarListFetched(carList));
      } catch (error) {
        emit(FailedFetchCarList());
        rethrow;
      }
    });
  }
}
