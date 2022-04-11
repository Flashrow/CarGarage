import 'package:flutter/material.dart';

import '../../common/styles.dart';

class CarDetailItem extends StatelessWidget {
  final String title;
  final String description;
  const CarDetailItem({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 20, bottom: 4),
      child: Row(
        children: [
          Text(
            title,
            style: regularSemiboldText,
          ),
          const SizedBox(width: 6),
          Text(
            description,
            style: regularText,
          )
        ],
      ),
    );
  }
}
