import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../logger.dart';
import '../../user/user.dart';
import '../parking_lot.dart';
import '../parking_space_model.dart';
import '../selected_parking_space_info.dart';
import 'parking_row_widgets.dart';

class ParkingLotScreen extends StatefulWidget {
  static const TAG = "ParkingLotScreen";
  final ParkingLot parkingLot;

  const ParkingLotScreen(this.parkingLot, {Key? key}) : super(key: key);

  @override
  State<ParkingLotScreen> createState() => _ParkingLotScreenState();
}

class _ParkingLotScreenState extends State<ParkingLotScreen> {
  ParkingSpaceModel? selectedSpace;
  late User currentUser;

  onSpaceTapped(ParkingSpaceModel parkingSpace) {
    Log.infoWithTag("ParkingLotScreen", "Space ${parkingSpace.spaceId} tapped");
    if (parkingSpace.isOccupied) {
      widget.parkingLot.vacate(parkingSpace.spaceId, currentUser.id);
      setState(() {
        selectedSpace = null;
      });
    } else {
      widget.parkingLot.occupy(parkingSpace.spaceId, currentUser.id);
      setState(() {
        selectedSpace = parkingSpace;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    currentUser = Provider.of<User>(context);
    return ChangeNotifierProvider<ParkingLot>(
        create: (context) => widget.parkingLot,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TopParkingRow(
                pillar2: "Pillar 2",
                pillar1: "Pillar 1",
                onSpaceTapped: onSpaceTapped),
            const PedestrianWalkway(),
            TopCenterParkingRow(
                pillar3: "Pillar 3", onSpaceTapped: onSpaceTapped),
            BottomCenterParkingRow(onSpaceTapped: onSpaceTapped),
            BottomParkingRow(onSpaceTapped: onSpaceTapped),
          ]),
          SelectedParkingSpaceInfo(selectedSpace),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton(
              onPressed: () {
                Log.infoWithTag(ParkingLotScreen.TAG, "Leave button pressed");
              },
              child: const Text("Leave!", style: TextStyle(fontSize: 24)),
            ),
          ])
        ]));
  }
}
