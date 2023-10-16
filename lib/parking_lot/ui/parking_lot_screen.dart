import 'dart:math';

import 'package:flutter/material.dart';
import 'package:parking_coordinator/user/user_provider.dart';
import 'package:provider/provider.dart';

import '../../logger.dart';
import '../../parking_spaces_data.dart' as parkingSpacesData;
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
  late ParkingLot parkingLot;

  @override
  initState() {
    super.initState();
    parkingLot = widget.parkingLot;
    Log.infoWithTag(ParkingLotScreen.TAG, "ParkingLotScreen initState");
  }

  onSpaceTapped(ParkingSpaceModel parkingSpace) {
    Log.infoWithTag("ParkingLotScreen", "Space ${parkingSpace.spaceId} tapped");
    if (selectedSpace != null && selectedSpace!.spaceId == parkingSpace.spaceId) {
      Log.infoWithTag("ParkingLotScreen", "Space ${parkingSpace.spaceId} unselected");
      setState(() {
        selectedSpace = null;
      });
      return;
    }
    // widget.parkingLot.occupy(parkingSpace.spaceId, currentUser.id);
    setState(() {
      selectedSpace = parkingSpace;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ParkingLot>(
        create: (context) => widget.parkingLot,
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TopParkingRow(pillar2: "Pillar 2", pillar1: "Pillar 1", onSpaceTapped: onSpaceTapped),
            const PedestrianWalkway(),
            TopCenterParkingRow(pillar3: "Pillar 3", onSpaceTapped: onSpaceTapped),
            BottomCenterParkingRow(onSpaceTapped: onSpaceTapped),
            BottomParkingRow(onSpaceTapped: onSpaceTapped),
          ]),
          SelectedParkingSpaceInfo(selectedSpace),
        ]));
  }
}
