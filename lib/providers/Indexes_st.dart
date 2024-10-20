import 'package:flutter/foundation.dart';

class Indexes extends ChangeNotifier {
  var indexes=[-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1];
  var slot;
  void setIndexes(index,val)
  {
    indexes[index] =val;
    notifyListeners();
  }
  void slot_Index(slt)
  {
    slot = slt;
    notifyListeners();
  }

 
}
