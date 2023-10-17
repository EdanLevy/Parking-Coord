import 'package:flutter/widgets.dart';

import 'parking_lot_service.dart';
import 'parking_space_model.dart';


class ParkingLot extends ChangeNotifier {
  Map<int, ParkingSpaceModel> spaces;
  final ParkingLotService _lotService = ParkingLotService();

  ParkingLot(this.spaces);

  void occupy(int spaceId, String userId) {
    var space = spaces[spaceId];
    if (space == null) {
      throw Exception("Space $spaceId does not exist");
    }
    if (_isUserTakingAnyOtherSpace(userId)) {
      throw Exception("User $userId is already taking another space");
    }
    space.occupy(userId);
    _lotService.occupySpace(space, userId);
    notifyListeners();
  }

  bool _isUserTakingAnyOtherSpace(String userId) {
    return spaces.values
        .map((space) => space.occupiedByUserId == userId ? true : false)
        .any((element) => element == true);
  }

  void vacate(int spaceId, String userId) {
    var space = spaces[spaceId];
    if (space == null) {
      throw Exception("Space $spaceId does not exist");
    }
    if (space.occupiedByUserId != userId) {
      throw Exception("Space $spaceId is not occupied by user $userId."
          "only ${space.occupiedByUserId} or admin can vacate it");
    }
    space.vacate();
    _lotService.vacateSpace(space, userId);
    notifyListeners();
  }

  @override
  String toString() {
    return "ParkingLot(\n"
        "spaces: ${spaces.entries.map((entry) => entry.value.toString()).join("\n")}"
        ")";
  }
}
