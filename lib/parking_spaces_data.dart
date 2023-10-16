
import 'parking_lot/parking_lot.dart';
import 'parking_lot/parking_space_model.dart';


ParkingSpaceModel createParkingSpace(int spaceId) {
  final space = ParkingSpaceModel.create(spaceId);
  return space;
}

