import 'package:flutter/foundation.dart';

class BottomNavbarProvider extends ChangeNotifier {
  int _selectedIndex=0;

  void toggleIndex(ind)
  {
    _selectedIndex = ind;
    notifyListeners();
  }
}