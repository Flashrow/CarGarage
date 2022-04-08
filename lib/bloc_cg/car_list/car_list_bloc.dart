import 'package:bloc/bloc.dart';
import 'package:car_garage/repository/car_list_repository.dart';
import 'package:meta/meta.dart';

part 'car_list_event.dart';
part 'car_list_state.dart';

class CarListBloc extends Bloc<CarListEvent, CarListState> {
  final CarListRepository _carListRepository;
  CarListBloc(this._carListRepository) : super(CarListInitial()) {
    on<CarListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
