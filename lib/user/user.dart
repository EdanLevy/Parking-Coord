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
}

final User edan = User(
    id: "42",
    displayName: "Edan",
    email: "",
    carNumber: "63-861-84",
    apartmentNumber: 6,
    isVerified: true,
    phoneNumber: "0545512061");
