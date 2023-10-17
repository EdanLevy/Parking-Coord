


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parking_coordinator/user/user.dart';

class UserService {
  static const userCollectionName = 'users';
  final FirebaseFirestore _db = FirebaseFirestore.instance;


  bool userExists(String userId) {
    return false;
  }

  createUser(String id, String displayName, String email) async {
    await _db.collection(userCollectionName).doc(id).set({
      'displayName': displayName,
      'email': email,
      'carNumber': "",
      'apartmentNumber': 0,
      'isVerified': false,
      'phoneNumber': "",
    });
  }

  updateUser(User user) async {
    await _db.collection(userCollectionName).doc(user.id).update({
      'displayName': user.displayName,
      'email': user.email,
      'carNumber': user.carNumber,
      'apartmentNumber': user.apartmentNumber,
      'isVerified': user.isVerified,
      'phoneNumber': user.phoneNumber,
    });
  }

  Future<User> getUser(String userId) async {
    var userDoc = await _db.collection(userCollectionName).doc(userId).get();
    if ( userDoc.data() == null) {
      return User(
        id: userId,
        displayName: "",
        email: "",
        carNumber: "",
        apartmentNumber: 0,
        isVerified: false,
        phoneNumber: "",
      );
    }

    Map<String, dynamic> map = userDoc.data()!;
    return User(
      id: userId,
      displayName: map['displayName'],
      email: userDoc.get('email'),
      carNumber: userDoc.get('carNumber'),
      apartmentNumber: int.parse(map['apartmentNumber'].toString()),
      isVerified: bool.parse(map['isVerified'].toString()),
      phoneNumber: userDoc.get('phoneNumber'),
    );
  }
}