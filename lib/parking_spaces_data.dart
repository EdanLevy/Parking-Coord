
import 'parking_lot/parking_lot.dart';
import 'parking_lot/parking_space_model.dart';


ParkingSpaceModel createParkingSpace(int spaceId) {
  final space = ParkingSpaceModel.create(spaceId);
  return space;
}

final slots = <int,ParkingSpaceModel>{
  1: createParkingSpace(1),
  2: createParkingSpace(2),
  3: createParkingSpace(3),
  4: createParkingSpace(4),
  5: createParkingSpace(5),
  6: createParkingSpace(6),
};

final parkingLot = ParkingLot(slots);
