import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'validated_form_field_state.dart';

class ValidatedFormFieldCubit extends Cubit<ValidatedFormFieldState> {
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final Map<String, bool Function(String)>? validators;
  final Function? onChangeListener;
  bool isValid = false;

  ValidatedFormFieldCubit({this.validators, this.onChangeListener})
      : super(FormFieldInitial()) {
    if (validators != null) {
      _textEditingController.addListener(() {
        _validateField();
        if (_focusNode.hasFocus == false) _focusNode.requestFocus();
      });
    }
    if (onChangeListener != null) {
      _textEditingController.addListener(() {
        onChangeListener!();
      });
    }
    _focusNode.addListener(() {
      if (_focusNode.hasFocus == false && isValid) {
        emit(UnfocusField());
      }
    });
  }

  void _validateField() {
    bool valid = true;
    String message = "";
    validators?.forEach((validatorText, validationFunction) {
      if (validationFunction(_textEditingController.text) == false) {
        valid = false;
        message = validatorText;
      }
    });
    isValid = valid;
    emit(valid ? FormFieldValid() : FormFieldInvalid(message));
  }

  TextEditingController getController() => _textEditingController;

  FocusNode getFocusNode() => _focusNode;
}
