import 'package:flutter/foundation.dart';

class EnlargerProvider extends ChangeNotifier {
  int ind = -1;  // Initial state: Login view
  var closest;
  var allDoctors=[];
  var search_list=[];

  void setSearchList(list)
  {
    search_list = list;
    print('Searchahhh');
    print(search_list);
    notifyListeners();
  }


  int get indval => ind;
  void toggleAllDoctors(data)
  {
    allDoctors = data.map((doc) => doc.data() as Map<String, dynamic>).toList();
    notifyListeners();
  }
  void toggleBanAllDoctors(ind,val)
  {
    allDoctors[ind]['Ban'] = val;
    notifyListeners();
  }

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
