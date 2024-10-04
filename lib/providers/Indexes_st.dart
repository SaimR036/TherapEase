import 'package:flutter/foundation.dart';

class Indexes extends ChangeNotifier {
  var indexes=[-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1];

  void setIndexes(index,val)
  {
    indexes[index] =val;
    notifyListeners();
  }


 
}
