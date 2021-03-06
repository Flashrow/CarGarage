import 'package:bloc/bloc.dart';
import 'package:car_garage/bloc_cg/add_car/add_car_field_enum.dart';
import 'package:meta/meta.dart';

import '../../network/models/car_dto.dart';
import '../../repository/car_list_repository.dart';

part 'add_car_event.dart';
part 'add_car_state.dart';

class AddCarBloc extends Bloc<AddCarEvent, AddCarState> {
  final CarListRepository _carListRepository;
  bool isBrandValid = false;
  bool isModelValid = false;
  bool isColorValid = false;
  bool isRegistrationValid = false;
  bool isYearValid = false;
  bool isOwnerIdValid = false;
  bool isLatValid = false;
  bool isLngValid = false;

  AddCarBloc(this._carListRepository) : super(AddCarInitial()) {
    on<SetFieldValidity>((event, emit) {
      switch (event.fieldType) {
        case AddCarFieldEnum.brand:
          isBrandValid = event.isValid;
          break;
        case AddCarFieldEnum.model:
          isModelValid = event.isValid;
          break;
        case AddCarFieldEnum.color:
          isColorValid = event.isValid;
          break;
        case AddCarFieldEnum.registration:
          isRegistrationValid = event.isValid;
          break;
        case AddCarFieldEnum.year:
          isYearValid = event.isValid;
          break;
        case AddCarFieldEnum.ownerId:
          isOwnerIdValid = event.isValid;
          break;
        case AddCarFieldEnum.lat:
          isLatValid = event.isValid;
          break;
        case AddCarFieldEnum.lng:
          isLngValid = event.isValid;
          break;
      }
      emit(isFormValid() ? FormValid() : FormInvalid());
    });
    on<AddCar>((event, emit) async {
      emit(AddingCarLoading());
      try {
        await _carListRepository.addNewCar(event.newCar);
        emit(CarAddedSuccessfully());
      } catch (error) {
        emit(FailedAddingCar());
        rethrow;
      }
    });
  }

  bool isFormValid() {
    return isBrandValid &&
        isModelValid &&
        isColorValid &&
        isRegistrationValid &&
        isYearValid &&
        isOwnerIdValid &&
        isLatValid &&
        isLngValid;
  }
}
