import 'package:flutter/material.dart';

class PageIndexController with ChangeNotifier {
  int _pageIndex = 0;

  int get newIndex => _pageIndex;

  void changeTo(int newIndex){
    _pageIndex = newIndex;
    notifyListeners();
  }
}