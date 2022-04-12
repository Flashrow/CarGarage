part of 'validated_form_field_cubit.dart';

@immutable
abstract class ValidatedFormFieldState {}

class FormFieldInitial extends ValidatedFormFieldState {}

class FormFieldValid extends ValidatedFormFieldState {}

class FormFieldInvalid extends ValidatedFormFieldState {
  final String validationMessage;

  FormFieldInvalid(this.validationMessage);
}

class UnfocusField extends ValidatedFormFieldState {}
