import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  int count = 0;

  initializeData() {
    count = 0;
  }

  onPressAddButton() {
    count += 1;
    notifyListeners();
  }
}
