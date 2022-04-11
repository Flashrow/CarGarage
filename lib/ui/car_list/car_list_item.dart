import 'package:auto_route/auto_route.dart';
import 'package:car_garage/bloc_cg/persons_list/persons_list_bloc.dart';
import 'package:car_garage/common/colors.dart';
import 'package:car_garage/common/styles.dart';
import 'package:car_garage/route/router.gr.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../network/models/car_dto.dart';

class CarListItem extends StatelessWidget {
  final CarDto? carDto;
  const CarListItem({
    Key? key,
    this.carDto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: cPrimaryColor.withOpacity(0.3),
      onTap: () {
        if (carDto != null) {
          AutoRouter.of(context)
              .navigate(CarDetailsScreenRoute(carDto: carDto!));
          BlocProvider.of<PersonsListBloc>(context)
              .add(FetchPerson(carDto!.ownerId ?? ""));
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 2,
              color: cSecondaryColor.withOpacity(0.3),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        (carDto?.brand ?? "") + " ",
                        style: title2Text,
                      ),
                      Text(
                        carDto?.model ?? "",
                        style: title2Text,
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        "registrationNumber".tr() + ":",
                        style: regularText,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        carDto?.registration ?? "",
                        style: regularSemiboldText,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
              Container(
                width: 10,
                height: 65,
                decoration: BoxDecoration(
                  color: carDto?.color,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
