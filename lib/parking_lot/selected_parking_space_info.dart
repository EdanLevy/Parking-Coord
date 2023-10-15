import 'package:flutter/widgets.dart';

import 'parking_space_model.dart';

class SelectedParkingSpaceInfo extends StatelessWidget {
  ParkingSpaceModel? selectedParkingSpace;

  SelectedParkingSpaceInfo(this.selectedParkingSpace, {super.key});

  void setSelectedParkingSpace(ParkingSpaceModel parkingSpace) {
    selectedParkingSpace = parkingSpace;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            selectedParkingSpace == null
                ? "No space selected"
                : "Selected space: ${selectedParkingSpace!.spaceId}",
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          Text(
            selectedParkingSpace == null
                ? ""
                : selectedParkingSpace!.isOccupied
                    ? "Occupied by ${selectedParkingSpace!.occupiedByUserId}"
                    : "Not occupied",
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
