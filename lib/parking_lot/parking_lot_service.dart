import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parking_coordinator/parking_lot/parking_lot.dart';
import 'package:parking_coordinator/parking_lot/parking_space_model.dart';

import '../logger.dart';

class ParkingLotService {
  static const parkingLotCollectionName = "parkingLot";
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<ParkingLot> getParkingLot() async {
    final collection = await _db.collection(parkingLotCollectionName).get();
    final spaces = <int, ParkingSpaceModel>{};
    for (var doc in collection.docs) {
      Log.debug(doc.data().toString());
      final space = ParkingSpaceModel.fromFirestore(doc.id, doc.data());
      spaces[space.spaceId] = space;
    }
    return ParkingLot(spaces);
  }

  Future<void> occupySpace(ParkingSpaceModel spaceModel, String userId) async {
    await _db.collection(parkingLotCollectionName).doc(spaceModel.spaceId.toString()).update({
      'isOccupied': spaceModel.isOccupied,
      'occupiedByUserId': userId,
      'lastStatusChange': DateTime.now(),
    });
  }

  Future<void> vacateSpace(ParkingSpaceModel spaceModel, String userId) async {
    await _db.collection(parkingLotCollectionName).doc(spaceModel.spaceId.toString()).update({
      'isOccupied': spaceModel.isOccupied,
      'occupiedByUserId': spaceModel.occupiedByUserId,
      'lastStatusChange': DateTime.now(),
    });
  }

  Future<ParkingSpaceModel> getSpaceInfo(String spaceId) {
    return _db
        .collection(parkingLotCollectionName)
        .doc(spaceId)
        .get()
        .then((value) => ParkingSpaceModel.fromFirestore(value.id, value.data()!));
  }
}
