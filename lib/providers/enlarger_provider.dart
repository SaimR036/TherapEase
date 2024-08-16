import 'package:flutter/foundation.dart';

class EnlargerProvider extends ChangeNotifier {
  int ind = -1;  // Initial state: Login view
  var closest;
  int get indval => ind;

  void toggleClosest(close)
  {
    closest  = close;
    notifyListeners();
  }

  void toggleInd(val) {
    ind = val; 
    notifyListeners();        // Notify widgets to rebuild
  }
}
