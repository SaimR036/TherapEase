import 'package:flutter/foundation.dart';

class BottomNavbarProvider extends ChangeNotifier {
  var _selectedIndex=2;

  void toggleIndex(ind)
  {
    _selectedIndex = ind;
    notifyListeners();
  }
  int getIndex()
  {
    return _selectedIndex;
  }
}