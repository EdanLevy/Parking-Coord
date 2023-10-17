
import 'package:flutter/material.dart';
import 'package:parking_coordinator/parking_lot/parking_lot_service.dart';
import 'package:provider/provider.dart';

import '../../logger.dart';
import '../parking_lot.dart';
import '../parking_space_model.dart';
import '../selected_parking_space_info.dart';
import 'parking_row_widgets.dart';

class ParkingLotScreen extends StatefulWidget {
  static const TAG = "ParkingLotScreen";

  const ParkingLotScreen({Key? key}) : super(key: key);

  @override
  State<ParkingLotScreen> createState() => _ParkingLotScreenState();
}

class _ParkingLotScreenState extends State<ParkingLotScreen> {
  ParkingSpaceModel? selectedSpace;
  late ParkingLot parkingLot;

  @override
  initState() {
    super.initState();
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
    return StreamBuilder(
        stream: Stream.fromFuture(ParkingLotService().getParkingLot()),
        builder: (BuildContext context, AsyncSnapshot<ParkingLot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          } else if ((snapshot.connectionState == ConnectionState.active ||
                  snapshot.connectionState == ConnectionState.done) &&
              snapshot.data != null) {
            parkingLot = snapshot.data as ParkingLot;
            return ChangeNotifierProvider<ParkingLot>(
              create: (context) => parkingLot,
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  TopParkingRow(pillar2: "Pillar 2", pillar1: "Pillar 1", onSpaceTapped: onSpaceTapped),
                  const PedestrianWalkway(),
                  TopCenterParkingRow(pillar3: "Pillar 3", onSpaceTapped: onSpaceTapped),
                  BottomCenterParkingRow(onSpaceTapped: onSpaceTapped),
                  BottomParkingRow(onSpaceTapped: onSpaceTapped),
                ]),
                if (snapshot.connectionState == ConnectionState.waiting)
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                else
                  ChangeNotifierProvider<ParkingSpaceModel?>(
                      create: (context) => selectedSpace, child: SelectedParkingSpaceInfo()),
              ]),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
