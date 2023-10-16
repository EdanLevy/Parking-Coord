import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:parking_coordinator/logger.dart';
import 'package:parking_coordinator/parking_lot/parking_lot.dart';
import 'package:parking_coordinator/user/auth_service.dart';
import 'package:parking_coordinator/user/user_service.dart';
import 'package:provider/provider.dart';

import '../user/user.dart';
import 'parking_space_model.dart';

class SelectedParkingSpaceInfo extends StatelessWidget {
  ParkingSpaceModel? selectedParkingSpace;

  SelectedParkingSpaceInfo(this.selectedParkingSpace,
      {super.key});

  void setSelectedParkingSpace(ParkingSpaceModel parkingSpace) {
    selectedParkingSpace = parkingSpace;
  }

  @override
  Widget build(BuildContext context) {
    if (selectedParkingSpace == null) {
      return Container(
        alignment: Alignment.center,
        child: const Text(
          "No space selected",
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      );
    } else {
      var userId = AuthService().currentUser!.uid;
      ParkingLot parkingLot = Provider.of<ParkingLot>(context);
      if (!selectedParkingSpace!.isOccupied) {
        return Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(
                "Space ${selectedParkingSpace!.spaceId} is available",
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                onPressed: () {
                  Log.infoWithTag("ParkingLotScreen", "Occupy button pressed");
                  parkingLot.occupy(selectedParkingSpace!.spaceId, userId);
                },
                child: const Text("Occupy!", style: TextStyle(fontSize: 24)),
              ),
            ],
          ),
        );
      } else if (selectedParkingSpace!.occupiedByUserId == userId) {
        return Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(
                "Space ${selectedParkingSpace!.spaceId} is occupied by you",
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                onPressed: () {
                  Log.infoWithTag("ParkingLotScreen", "Vacate button pressed");
                  parkingLot.vacate(selectedParkingSpace!.spaceId, userId);
                },
                child: const Text("Vacate!", style: TextStyle(fontSize: 24)),
              ),
            ],
          ),
        );
      } else {
        return FutureBuilder(
          future: UserService().getUser(selectedParkingSpace!.occupiedByUserId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
              return Container(
                alignment: Alignment.center,
                child: Text(
                  "Space ${selectedParkingSpace!.spaceId} is occupied by ${snapshot.data!.displayName}",
                  style: const TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              );
            }
            else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData) {
              return Container(
                alignment: Alignment.center,
                child: Text(
                  "Space ${selectedParkingSpace!.spaceId} is occupied by ${selectedParkingSpace!.occupiedByUserId}",
                  style: const TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              );
            }
            else {
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
    }
  }
}
