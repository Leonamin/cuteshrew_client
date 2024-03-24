import 'package:flutter/material.dart';

abstract class BaseViewModel extends ChangeNotifier {
  bool _isInitCompleted = false;
  bool get isInitCompleted => _isInitCompleted;

  BaseViewModel() {
    init();
  }

  void init() {}

  void completeInit() {
    _isInitCompleted = true;
    notifyListeners();
  }
}
