import 'package:flutter/widgets.dart';

class ParkingSpaceModel extends ChangeNotifier {
  int spaceId;
  bool isOccupied;
  String occupiedByUserId;
  DateTime occupiedSince;

  ParkingSpaceModel(
      this.spaceId, this.isOccupied, this.occupiedByUserId, this.occupiedSince);

  ParkingSpaceModel.create(spaceId) : this(spaceId, false, "", DateTime.now());

  void occupy(String userId) {
    isOccupied = true;
    occupiedByUserId = userId;
    occupiedSince = DateTime.now();
    notifyListeners();
  }

  void vacate() {
    // todo: check if the user is admin or the user who occupied the space
    isOccupied = false;
    occupiedByUserId = "";
    occupiedSince = DateTime.now();
    notifyListeners();
  }

  @override
  String toString() {
    return "ParkingSpace(\n"
        "spaceId: $spaceId,\n"
        "isOccupied: $isOccupied,\n"
        "occupiedByUserId: $occupiedByUserId,\n"
        "occupiedSince: $occupiedSince)";
  }

}
