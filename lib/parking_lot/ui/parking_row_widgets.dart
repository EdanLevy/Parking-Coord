import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../logger.dart';
import '../parking_lot.dart';
import '../parking_space_model.dart';
import 'parking_space.dart';
import 'pillar.dart';

class BottomParkingRow extends StatelessWidget {
  const BottomParkingRow({
    super.key,
    required Function(ParkingSpaceModel parkingSpace) this.onSpaceTapped,
  });

  final void Function(ParkingSpaceModel parkingSpace) onSpaceTapped;

  @override
  Widget build(BuildContext context) {
    var parkingSpace1 = Provider.of<ParkingLot>(context).spaces[1]!;
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: ParkingSpace(
              model: parkingSpace1,
              onTap: () {
                Log.infoWithTag("ParkingLotScreen", "Space 1 tapped");
                onSpaceTapped(parkingSpace1);
              }),
        ),
        Expanded(flex: 1, child: Pillar("Pillar 4")),
      ],
    );
  }
}

class BottomCenterParkingRow extends StatelessWidget {
  const BottomCenterParkingRow({
    super.key,
    required Function(ParkingSpaceModel parkingSpace) this.onSpaceTapped,
  });


  final void Function(ParkingSpaceModel parkingSpace) onSpaceTapped;

  @override
  Widget build(BuildContext context) {
    var parkingSpace2 = Provider.of<ParkingLot>(context).spaces[2]!;
    var parkingSpace3 = Provider.of<ParkingLot>(context).spaces[3]!;

    return Row(children: [
      Expanded(
          flex: 1,
          child: ParkingSpace(
              model: parkingSpace2,
              onTap: () {
                Log.infoWithTag("ParkingLotScreen", "Space 2 tapped");
                onSpaceTapped(parkingSpace2);
              })),
      Expanded(
          flex: 1,
          child: ParkingSpace(
              model: parkingSpace3,
              onTap: () {
                Log.infoWithTag("ParkingLotScreen", "Space 3 tapped");
                onSpaceTapped(parkingSpace3);
              }))
    ]);
  }
}

class PedestrianWalkway extends StatelessWidget {
  const PedestrianWalkway({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      color: Colors.lightBlue,
      child: const Center(child: Text("Pedestrian Walkway")),
    );
  }
}

class TopCenterParkingRow extends StatelessWidget {
  TopCenterParkingRow({
    super.key,
    required String pillar3,
    required Function(ParkingSpaceModel parkingSpace) this.onSpaceTapped,
  }) {
    this.pillar3 = Pillar(pillar3);
  }

  final void Function(ParkingSpaceModel parkingSpace) onSpaceTapped;
  late final Pillar pillar3;

  @override
  Widget build(BuildContext context) {
    var pillar3 = Pillar("Pillar 3");
    var parkingSpace4 = Provider.of<ParkingLot>(context).spaces[4]!;
    var parkingSpace5 = Provider.of<ParkingLot>(context).spaces[5]!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  child: Container(
                    height: 100,
                    color: Colors.grey,
                    child: const Center(
                        child: Text(
                      "Wall",
                      textAlign: TextAlign.center,
                    )),
                  ),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Transform.rotate(
                      angle: -pi / 5,
                      child: ParkingSpace(
                          model: parkingSpace5,
                          onTap: () {
                            Log.infoWithTag(
                                "ParkingLotScreen", "Space 5 tapped");
                            onSpaceTapped(parkingSpace5);
                          }))),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              ParkingSpace(
                  model: parkingSpace4,
                  onTap: () {
                    Log.infoWithTag("ParkingLotScreen", "Space 4 tapped");
                    onSpaceTapped(parkingSpace4);
                  }),
              pillar3,
            ],
          ),
        )
      ],
    );
  }
}

class TopParkingRow extends StatelessWidget {
  TopParkingRow({
    super.key,
    required String pillar1,
    required String pillar2,
    required this.onSpaceTapped,
  }) {
    this.pillar1 = Pillar(pillar1);
    this.pillar2 = Pillar(pillar2);
  }

  final void Function(ParkingSpaceModel) onSpaceTapped;
  late final Pillar pillar1;
  late final Pillar pillar2;

  @override
  Widget build(BuildContext context) {
    var parkingSpace = Provider.of<ParkingLot>(context).spaces[6]!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(child: pillar2),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 18.0, bottom: 8.0, right: 18.0),
            child: ParkingSpace(
                model: parkingSpace,
                onTap: () => onSpaceTapped(parkingSpace)),
          ),
        ),
        Expanded(child: pillar1)
      ],
    );
  }
}
