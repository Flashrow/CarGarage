import 'package:car_garage/common/styles.dart';
import 'package:car_garage/common/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc_cg/persons_list/persons_list_bloc.dart';
import 'car_detail_item.dart';

class OwnerDetailsWidget extends StatelessWidget {
  const OwnerDetailsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonsListBloc, PersonsListState>(
      builder: (context, state) {
        if (state is PersonFetched) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarDetailItem(
                title: "firstName".tr() + ":",
                description: state.personDto.firstName.toString(),
              ),
              CarDetailItem(
                title: "lastName".tr() + ":",
                description: state.personDto.lastName.toString(),
              ),
              CarDetailItem(
                title: "birthDate".tr() + ":",
                description: state.personDto.birthDate != null
                    ? (state.personDto.birthDate!.day.toString() +
                        "." +
                        state.personDto.birthDate!.month.toString() +
                        "." +
                        state.personDto.birthDate!.year.toString())
                    : "",
              ),
              CarDetailItem(
                title: "sex".tr() + ":",
                description: state.personDto.sex.getSexName().tr(),
              ),
            ],
          );
        } else if (state is PersonNotExists) {
          return Text(
            "noDataAboutOwner".tr(),
            style: regularText,
          );
        }
        return const Center(
            child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: CircularProgressIndicator(),
        ));
      },
    );
  }
}
