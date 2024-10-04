import 'package:flutter/foundation.dart';

class ParentInfoContainer extends ChangeNotifier {
  
  var isUser = false;
  var isLoading = false;
  var isSelected = false;
  var search_one = false;
  var show= false;
  var ind = false;
  var calendar_show = -1;
  var calendar_ind =-1;
  var slotsIndex = -1;
  var show_adder = false;
  var enlarged_adder = false;
  var alotDate = "";
  void toggleAlotDate(val)
  {
    alotDate = val;
    notifyListeners();
  }
  void toggleCalendarInd(val)
  {
    calendar_ind = val;
    notifyListeners();
  }
  void toggeCalendarShow(val)
  {
    calendar_show = val;
    notifyListeners();
  }
  void toggeSlots(val)
  {
    slotsIndex = val;
    notifyListeners();
  }
  void toggeIsSelected()
  {
    isSelected = !isSelected;
    notifyListeners();
  }
  void toggeIsUser(val)
  {
    isUser = val;
    notifyListeners();
  }
  void toggleInd(val)
  {
    ind = val;
    notifyListeners();
  }
  void toggleShow(val)
  {
    show = val;
    notifyListeners();
  }
  void toggleisLoading(val)
  {
    isLoading = val;
    notifyListeners();
  }
  void toggleSearchOne(val)
  {
    search_one = val;
    notifyListeners();
  }
}
