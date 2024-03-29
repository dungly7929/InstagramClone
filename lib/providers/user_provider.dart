import 'package:flutter/cupertino.dart';
import 'package:learningdart/models/user.dart';
import 'package:learningdart/resources/auth_method.dart';
import 'package:matcher/matcher.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;

    notifyListeners();
  }
}
