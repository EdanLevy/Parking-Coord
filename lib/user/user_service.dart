

import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  FirebaseFirestore db = FirebaseFirestore.instance;


  bool userExists(String userId) {
    return false;
  }

  void createUser(String id, String displayName, String email) {}
}