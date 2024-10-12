import 'package:flutter/foundation.dart';

class LoginProvider extends ChangeNotifier {
  bool _isLoginView = true;  // Initial state: Login view
  bool isTherapist = false;
  var uid;
  void toggleIsTherapist() {
    isTherapist = !isTherapist; 
    notifyListeners();        // Notify widgets to rebuild
  }

  void toggleUid(num)
  {
    uid = num;
    print('uid');
    print(uid);
    notifyListeners();
  }

  bool get isLoginView => _isLoginView;

  void toggleView() {
    _isLoginView = !_isLoginView; 
    notifyListeners();        // Notify widgets to rebuild
  }
}
