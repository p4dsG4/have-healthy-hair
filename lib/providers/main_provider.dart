import 'package:flutter/material.dart';
import 'package:p4ds/routes/index.dart';

class MainProvider with ChangeNotifier {
  int pageIndex = 0;
  PageController mainPageController = PageController(initialPage: 0);

  onTapItem(index) {
    mainPageController.jumpToPage(index);
    notifyListeners();
  }

  onChangeMainScreenIndex(index) {
    pageIndex = index;
    notifyListeners();
  }

  onPressEditProfileButton(BuildContext context) {
    Navigator.of(context).pushNamed(Routes.editProfileScreen);
    notifyListeners();
  }
}
