import 'package:flutter/foundation.dart';

class LoginProvider extends ChangeNotifier {
  bool _isLoginView = true;  // Initial state: Login view
  bool isTherapist = false;
  var user=0;
  var uid;
  var loginLoader= false;
  void toggleIsTherapist() {
    isTherapist = !isTherapist; 
    notifyListeners();        // Notify widgets to rebuild
  }
  void toggleLoginLoader()
  {
    loginLoader = !loginLoader;
    notifyListeners();
  }
  void toggleUser(user1)
  {
    user = user1;
    notifyListeners();
  }
  void toggleUid(num)
  {
    uid = num;

    notifyListeners();
  }

  bool get isLoginView => _isLoginView;

  void toggleView() {
    _isLoginView = !_isLoginView; 
    notifyListeners();        // Notify widgets to rebuild
  }
}
