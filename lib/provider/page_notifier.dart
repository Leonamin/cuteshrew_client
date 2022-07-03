import 'package:cuteshrew/pages/home_page.dart';
import 'package:flutter/widgets.dart';

class PageNotifier extends ChangeNotifier {
  String _currentPage = HomePage.pageName;
  dynamic _args;
  String _previousPage = HomePage.pageName;
  dynamic _previousArgs;

  String get currentPage => _currentPage;
  dynamic get args => _args;

  void goToMain() {
    _currentPage = HomePage.pageName;
    notifyListeners();
  }

  void goToPage(String name, [dynamic args]) {
    _previousPage = _currentPage;
    _previousArgs = _args;
    _currentPage = name;
    _args = args;
    notifyListeners();
  }

  void goToPreviousPage() {
    String previousPage = _currentPage;
    dynamic previousArgs = _args;
    _currentPage = _previousPage;
    _args = _previousArgs;
    _previousPage = previousPage;
    _previousArgs = previousArgs;
    notifyListeners();
  }
}
