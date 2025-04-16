import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String? _uid;

  String? get uid => _uid;

  void setUid(String uid) {
    _uid = uid;
    notifyListeners(); // إشعار المستمعين بتغيير البيانات
  }

  void clearUid() {
    _uid = null;
    notifyListeners();
  }
}
