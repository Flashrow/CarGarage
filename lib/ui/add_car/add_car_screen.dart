import 'package:car_garage/bloc_cg/form_field/validated_form_field_cubit.dart';
import 'package:car_garage/common/styles.dart';
import 'package:car_garage/ui/add_car/add_car_map_widget.dart';
import 'package:car_garage/ui/base_screen.dart';
import 'package:car_garage/ui/widget/custom_textfield_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc_cg/add_car/add_car_bloc.dart';
import '../../bloc_cg/add_car/add_car_field_enum.dart';
import '../../common/colors.dart';

class AddCarScreen extends StatefulWidget {
  const AddCarScreen({Key? key}) : super(key: key);

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  final AddCarBloc addCarBloc = AddCarBloc();
  late ValidatedFormFieldCubit brandFieldCubit;
  late ValidatedFormFieldCubit modelFieldCubit;
  late ValidatedFormFieldCubit registrationFieldCubit;
  late ValidatedFormFieldCubit yearFieldCubit;

  @override
  void initState() {
    super.initState();
    initializeFieldCubits();
  }

  void initializeFieldCubits() {
    brandFieldCubit = ValidatedFormFieldCubit(
      validators: {
        "required": (text) => text.isNotEmpty,
      },
      onChangeListener: () {
        addCarBloc.add(
          SetFieldValidity(
            fieldType: AddCarFieldEnum.brand,
            isValid: brandFieldCubit.isValid,
          ),
        );
      },
    );
    modelFieldCubit = ValidatedFormFieldCubit(
      validators: {
        "required": (text) => text.isNotEmpty,
      },
      onChangeListener: () {
        SetFieldValidity(
          fieldType: AddCarFieldEnum.model,
          isValid: modelFieldCubit.isValid,
        );
      },
    );
    registrationFieldCubit = ValidatedFormFieldCubit(
      validators: {
        "required": (text) => text.isNotEmpty,
      },
      onChangeListener: () {
        SetFieldValidity(
          fieldType: AddCarFieldEnum.registration,
          isValid: registrationFieldCubit.isValid,
        );
      },
    );
    yearFieldCubit = ValidatedFormFieldCubit(
      validators: {
        "required": (text) => text.isNotEmpty,
        "invalidYear": (text) {
          return RegExp(r'^\d{4}$').hasMatch(text);
        },
      },
      onChangeListener: () {
        SetFieldValidity(
          fieldType: AddCarFieldEnum.year,
          isValid: yearFieldCubit.isValid,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20, bottom: 16),
            child: Text(
              "addCarTitle".tr(),
              style: title1Text,
            ),
          ),
          Divider(
            color: cPrimaryColor.withOpacity(0.7),
            thickness: 2,
            height: 2,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextfieldWidget(
                          label: "brand".tr(),
                          hint: "Honda",
                          formFieldCubit: brandFieldCubit,
                        ),
                        const SizedBox(height: 10),
                        CustomTextfieldWidget(
                          label: "model".tr(),
                          hint: "Civic",
                          formFieldCubit: modelFieldCubit,
                        ),
                        const SizedBox(height: 10),
                        CustomTextfieldWidget(
                          label: "registrationNumber".tr(),
                          hint: "AB1234",
                          formFieldCubit: registrationFieldCubit,
                        ),
                        const SizedBox(height: 10),
                        CustomTextfieldWidget(
                          label: "productionYear".tr(),
                          hint: "1999",
                          formFieldCubit: yearFieldCubit,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 28),
                    child: Text(
                      "Car color:",
                      style: regularSemiboldText.apply(color: cPrimaryColor),
                    ),
                  ),
                  const AddCarMapWidget(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          BlocBuilder<AddCarBloc, AddCarState>(
            bloc: addCarBloc,
            builder: (context, state) {
              return InkWell(
                child: Container(
                  height: 40,
                  color: Colors.red,
                ),
              );
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
