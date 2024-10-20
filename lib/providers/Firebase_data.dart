import 'package:flutter/foundation.dart';

class CloudData extends ChangeNotifier {
  List<Map<String, dynamic>> applications=[];
  void store_applications(apps)
  {
    applications = apps;
    notifyListeners();
  }
  void setStatus(var index, var status)
{
applications[index]['Status'] = status;
notifyListeners();
}
}
