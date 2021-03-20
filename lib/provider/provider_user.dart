import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  String _name;
  String _pass;
  bool _visibility = true;

  String get Name => _name;
  String get Pass => _pass;
  bool get Visibility => _visibility;

  setName(String name) {
    _name = name;
    notifyListeners();
  }

  setPass(String pass) {
    _pass = pass;
    notifyListeners();
  }

  setVisibility(bool visible) {
    _visibility = visible;
    notifyListeners();
  }
}
