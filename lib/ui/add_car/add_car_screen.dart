import 'package:auto_route/auto_route.dart';
import 'package:car_garage/bloc_cg/form_field/validated_form_field_cubit.dart';
import 'package:car_garage/bloc_cg/persons_list/persons_list_bloc.dart';
import 'package:car_garage/common/styles.dart';
import 'package:car_garage/network/models/car_dto.dart';
import 'package:car_garage/repository/car_list_repository.dart';
import 'package:car_garage/ui/add_car/add_car_map_widget.dart';
import 'package:car_garage/ui/base_screen.dart';
import 'package:car_garage/ui/widget/custom_textfield_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../bloc_cg/add_car/add_car_bloc.dart';
import '../../bloc_cg/add_car/add_car_field_enum.dart';
import '../../bloc_cg/car_list/car_list_bloc.dart';
import '../../common/colors.dart';
import '../../network/models/person_dto.dart';
import '../widget/custom_button_widget.dart';

class AddCarScreen extends StatefulWidget {
  const AddCarScreen({Key? key}) : super(key: key);

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  final AddCarBloc addCarBloc = AddCarBloc(CarListRepository());
  late ValidatedFormFieldCubit brandFieldCubit;
  late ValidatedFormFieldCubit modelFieldCubit;
  late ValidatedFormFieldCubit registrationFieldCubit;
  late ValidatedFormFieldCubit yearFieldCubit;
  LatLng? carPosition;
  Color? carColor = Colors.green;
  PersonDto? carOwner;

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
        addCarBloc.add(SetFieldValidity(
          fieldType: AddCarFieldEnum.model,
          isValid: modelFieldCubit.isValid,
        ));
      },
    );
    registrationFieldCubit = ValidatedFormFieldCubit(
      validators: {
        "required": (text) => text.isNotEmpty,
      },
      onChangeListener: () {
        addCarBloc.add(SetFieldValidity(
          fieldType: AddCarFieldEnum.registration,
          isValid: registrationFieldCubit.isValid,
        ));
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
        addCarBloc.add(SetFieldValidity(
          fieldType: AddCarFieldEnum.year,
          isValid: yearFieldCubit.isValid,
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: BlocConsumer<AddCarBloc, AddCarState>(
        bloc: addCarBloc,
        listener: (context, carBlocState) {
          if (carBlocState is CarAddedSuccessfully) {
            BlocProvider.of<CarListBloc>(context).add(FetchCarList());
            AutoRouter.of(context).pop();
          }
        },
        builder: (context, carBlocState) {
          if (carBlocState is AddingCarLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
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
                          style:
                              regularSemiboldText.apply(color: cPrimaryColor),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: carColor,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                              ),
                            ),
                            const SizedBox(width: 10),
                            CustomButtonWidget(
                              title: "pickCarColor".tr(),
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                onPickCarColorButton(context);
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 28),
                        child: Text(
                          "Car owner:",
                          style:
                              regularSemiboldText.apply(color: cPrimaryColor),
                        ),
                      ),
                      BlocBuilder<PersonsListBloc, PersonsListState>(
                        builder: (context, state) {
                          if (state is PersonsListFetched) {
                            return pickOwnerDropdown(state);
                          }
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 28),
                        child: Text(
                          "selectCarLocationOnMap".tr(),
                          style: regularSemiboldText.apply(
                            color: cPrimaryColor,
                          ),
                        ),
                      ),
                      AddCarMapWidget(setCarPosition: (pinPosition) {
                        carPosition = pinPosition;
                        addCarBloc.add(SetFieldValidity(
                            fieldType: AddCarFieldEnum.lat, isValid: true));
                        addCarBloc.add(SetFieldValidity(
                            fieldType: AddCarFieldEnum.lng, isValid: true));
                      }),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: CustomButtonWidget(
                  isActive: carBlocState is FormValid,
                  onTap: () {
                    addCarBloc.add(
                      AddCar(
                        CarDto(
                          brand: brandFieldCubit.getText(),
                          model: modelFieldCubit.getText(),
                          registration: registrationFieldCubit.getText(),
                          year: DateTime.tryParse(
                              yearFieldCubit.getText() + "-01-01"),
                          color: carColor,
                          ownerId: carOwner?.id,
                          lat: carPosition?.latitude,
                          lng: carPosition?.longitude,
                        ),
                      ),
                    );
                  },
                  title: "addCar".tr(),
                  width: 240,
                ),
              ),
              const SizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }

  Widget pickOwnerDropdown(PersonsListFetched state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: DropdownButton<PersonDto>(
        value: carOwner,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (PersonDto? newValue) {
          setState(() {
            carOwner = newValue!;
          });
          addCarBloc.add(SetFieldValidity(
              fieldType: AddCarFieldEnum.ownerId, isValid: true));
        },
        items: state.personsList
            .map<DropdownMenuItem<PersonDto>>((PersonDto person) {
          return DropdownMenuItem<PersonDto>(
            value: person,
            child:
                Text((person.firstName ?? "") + " " + (person.lastName ?? "")),
          );
        }).toList(),
      ),
    );
  }

  void onPickCarColorButton(BuildContext context) {
    Color pickerColor = carColor ?? Colors.green;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('pickCarColor'.tr()),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: (color) => setState(() => pickerColor = color),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('selectColor'.tr()),
              onPressed: () {
                setState(() => carColor = pickerColor);
                addCarBloc.add(
                  SetFieldValidity(
                    fieldType: AddCarFieldEnum.color,
                    isValid: true,
                  ),
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
