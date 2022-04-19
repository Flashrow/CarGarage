part of 'add_car_bloc.dart';

@immutable
abstract class AddCarEvent {}

class SetFieldValidity extends AddCarEvent {
  final AddCarFieldEnum fieldType;
  final bool isValid;

  SetFieldValidity({required this.fieldType, required this.isValid});
}

class AddCar extends AddCarEvent {
  final CarDto newCar;

  AddCar(this.newCar);
}
