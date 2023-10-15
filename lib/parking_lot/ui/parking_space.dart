import 'package:flutter/material.dart';

import '../parking_space_model.dart';

class ParkingSpace extends StatelessWidget {
  final ParkingSpaceModel model;
  final VoidCallback onTap;

  const ParkingSpace(
      {required this.model, Key? key, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 50,
          color: model.isOccupied ? Colors.red : Colors.green,
          child: Center(child: Text("Space ${model.spaceId.toString()}")),
        ),
      ),
    );
  }
}
