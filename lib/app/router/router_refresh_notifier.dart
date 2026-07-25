import 'package:flutter/foundation.dart';

class RouterRefreshNotifier extends ChangeNotifier {
  RouterRefreshNotifier();

  void refresh() {
    notifyListeners();
  }
}
