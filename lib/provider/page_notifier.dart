import 'package:cuteshrew/pages/home_page.dart';
import 'package:flutter/widgets.dart';

class PageNotifier extends ChangeNotifier {
  String _currentPage = HomePage.pageName;

  String get currentPage => _currentPage;

  void goToMain() {
    _currentPage = HomePage.pageName;
    notifyListeners();
  }

  void goToPage(String name) {
    _currentPage = name;
    notifyListeners();
  }
}
