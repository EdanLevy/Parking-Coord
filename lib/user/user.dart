import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuth;
import 'package:flutter/widgets.dart';

class User extends ChangeNotifier {
  final String id;
  final String displayName;
  final String email;
  final String carNumber;
  final int apartmentNumber;
  final String phoneNumber;
  final bool isVerified;

  User(
      {required this.id,
      required this.displayName,
      required this.email,
      required this.carNumber,
      required this.apartmentNumber,
      required this.isVerified,
      required this.phoneNumber});

  static User fromFirebaseAuthUser(FirebaseAuth.User user) {
    return User(
        id: user.uid,
        displayName: user.displayName ?? "",
        email: user.email ?? "",
        carNumber: "",
        apartmentNumber: 0,
        isVerified: false,
        phoneNumber: "");
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
        id: map['id'],
        displayName: map['displayName'],
        email: map['email'],
        carNumber: map['carNumber'],
        apartmentNumber: map['apartmentNumber'],
        isVerified: map['isVerified'],
        phoneNumber: map['phoneNumber']);
  }
}

final User edan = User(
    id: "42",
    displayName: "Edan",
    email: "",
    carNumber: "63-861-84",
    apartmentNumber: 6,
    isVerified: true,
    phoneNumber: "0545512061");
