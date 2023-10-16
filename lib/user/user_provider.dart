

import 'package:flutter/foundation.dart';
import 'package:parking_coordinator/user/user.dart';
import 'package:parking_coordinator/user/user_service.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final UserService _userService = UserService();

  User? get user => _user;

  Future<UserProvider> setUser(String userId) async {
    _user = await _userService.getUser(userId);
    notifyListeners();
    return this;
  }
}
