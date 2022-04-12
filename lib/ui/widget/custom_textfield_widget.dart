import 'package:car_garage/bloc_cg/form_field/validated_form_field_cubit.dart';
import 'package:car_garage/common/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/styles.dart';

class CustomTextfieldWidget extends StatelessWidget {
  final String? label;
  final String? hint;
  final ValidatedFormFieldCubit? formFieldCubit;

  const CustomTextfieldWidget({
    Key? key,
    this.label,
    this.hint,
    this.formFieldCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ValidatedFormFieldCubit, ValidatedFormFieldState>(
      bloc: formFieldCubit,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                label ?? "label",
                style: regularSemiboldText.apply(
                  color: state is FormFieldInvalid ? Colors.red : cPrimaryColor,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(7)),
                border: (state is FormFieldInitial || state is UnfocusField)
                    ? null
                    : Border.all(
                        color: (state is FormFieldInvalid)
                            ? Colors.red
                            : cPrimaryColor),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.2),
                    offset: const Offset(0, 2),
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
                ],
                color: Colors.white,
              ),
              child: TextField(
                controller: formFieldCubit?.getController(),
                focusNode: formFieldCubit?.getFocusNode(),
                style: regularText,
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: regularText,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  border: InputBorder.none,
                ),
              ),
            ),
            if (state is FormFieldInvalid)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  state.validationMessage.tr(),
                  style: regularSemiboldText.apply(
                    color: Colors.red,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
