import 'package:flutter/foundation.dart';

class LoginProvider extends ChangeNotifier {
  bool _isLoginView = true;  // Initial state: Login view

  bool get isLoginView => _isLoginView;

  void toggleView() {
    _isLoginView = !_isLoginView; 
    notifyListeners();        // Notify widgets to rebuild
  }
}
