part of 'add_car_bloc.dart';

@immutable
abstract class AddCarState {}

class AddCarInitial extends AddCarState {}

class FormValid extends AddCarState {}

class FormInvalid extends AddCarState {}

class AddingCarLoading extends AddCarState {}

class CarAddedSuccessfully extends AddCarState {}

class FailedAddingCar extends AddCarState {}
