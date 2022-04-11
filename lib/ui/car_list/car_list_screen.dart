import 'package:auto_route/auto_route.dart';
import 'package:car_garage/bloc_cg/car_list/car_list_bloc.dart';
import 'package:car_garage/common/colors.dart';
import 'package:car_garage/common/styles.dart';
import 'package:car_garage/route/router.gr.dart';
import 'package:car_garage/ui/car_list/car_list_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../base_screen.dart';

class CarListScreen extends StatelessWidget {
  const CarListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          AutoRouter.of(context).navigate(const AddCarScreenRoute());
        },
      ),
      child: Column(
        children: [
          carListTitle(),
          BlocBuilder<CarListBloc, CarListState>(
            builder: (context, state) {
              if (state is CarListFetched) {
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      BlocProvider.of<CarListBloc>(context).add(FetchCarList());
                    },
                    child: ListView.builder(
                      itemCount: state.carList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CarListItem(
                          carDto: state.carList[index],
                        );
                      },
                    ),
                  ),
                );
              }
              return const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget carListTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, bottom: 16),
          child: Text(
            "carsListTitle".tr(),
            textAlign: TextAlign.left,
            style: title1Text,
          ),
        ),
        Divider(
          color: cPrimaryColor.withOpacity(0.7),
          thickness: 2,
          height: 2,
        ),
      ],
    );
  }
}
