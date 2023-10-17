import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/logger.dart';
import '../parking_lot/parking_lot.dart';
import '../parking_lot/parking_lot_service.dart';
import '../user/auth_service.dart';
import '../user/user_service.dart';
import './parking_space_model.dart';

class SelectedParkingSpaceInfo extends StatelessWidget {
  const SelectedParkingSpaceInfo({super.key});

  @override
  Widget build(BuildContext context) {
    // ParkingSpaceModel? selectedParkingSpace = Provider.of<ParkingSpaceModel?>(context);
    ParkingLot parkingLot = Provider.of<ParkingLot>(context);
    return Consumer<ParkingSpaceModel?>(
        builder: (_, selectedParkingSpace, __) {
          if (selectedParkingSpace == null) {
            return Container(
                alignment: Alignment.center,
                child: const Text(
                  "No space selected",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ));
          } else {
            return FutureBuilder(
                future: ParkingLotService().getSpaceInfo(selectedParkingSpace.spaceId.toString()),
                builder: (context, snapshot) {
                  var userId = AuthService().currentUser!.uid;
                  if (!selectedParkingSpace.isOccupied) {
                    return Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Text(
                            "Space ${selectedParkingSpace.spaceId} is available",
                            style: const TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Log.infoWithTag("ParkingLotScreen", "Occupy button pressed");
                              parkingLot.occupy(selectedParkingSpace.spaceId, userId);
                            },
                            child: const Text("Occupy!", style: TextStyle(fontSize: 24)),
                          ),
                        ],
                      ),
                    );
                  } else if (selectedParkingSpace.occupiedByUserId == userId) {
                    return Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Text(
                            "Space ${selectedParkingSpace.spaceId} is occupied by you",
                            style: const TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Log.infoWithTag("ParkingLotScreen", "Vacate button pressed");
                              parkingLot.vacate(selectedParkingSpace.spaceId, userId);
                            },
                            child: const Text("Vacate!", style: TextStyle(fontSize: 24)),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return FutureBuilder(
                      future: UserService().getUser(selectedParkingSpace.occupiedByUserId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                          return Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Space ${selectedParkingSpace.spaceId} is occupied by ${snapshot.data!.displayName}",
                              style: const TextStyle(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          );
                        } else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData) {
                          return Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Space ${selectedParkingSpace.spaceId} is occupied by ${selectedParkingSpace
                                  .occupiedByUserId}",
                              style: const TextStyle(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          );
                        } else {
                          return Container(
                            alignment: Alignment.center,
                            child: const Text(
                              "Loading...",
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          );
                        }
                      },
                    );
                  }
                });
          }
        });
  }
}
