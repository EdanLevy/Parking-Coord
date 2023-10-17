import 'package:flutter/widgets.dart';

class ParkingSpaceModel extends ChangeNotifier {
  int spaceId;
  bool isOccupied;
  String occupiedByUserId;
  DateTime lastStatusChange;

  ParkingSpaceModel(this.spaceId, this.isOccupied, this.occupiedByUserId, this.lastStatusChange);

  ParkingSpaceModel.create(spaceId) : this(spaceId, false, "", DateTime.now());

  ParkingSpaceModel.fromFirestore(String id, Map<String, dynamic> data)
      : this(int.parse(id), data['isOccupied'] ?? false, data['occupiedByUserId'] ?? "",
            (data['lastStatusChange']).toDate() ?? DateTime.now());

  void occupy(String userId) {
    isOccupied = true;
    occupiedByUserId = userId;
    lastStatusChange = DateTime.now();
    notifyListeners();
  }

  void vacate() {
    // todo: check if the user is admin or the user who occupied the space
    isOccupied = false;
    occupiedByUserId = "";
    lastStatusChange = DateTime.now();
    notifyListeners();
  }

  @override
  String toString() {
    return "ParkingSpace(\n"
        "spaceId: $spaceId,\n"
        "isOccupied: $isOccupied,\n"
        "occupiedByUserId: $occupiedByUserId,\n"
        "occupiedSince: $lastStatusChange)";
  }
}
