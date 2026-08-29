import 'package:event_app_c17_mon_7pm/model/event_category_data.dart';
import 'package:event_app_c17_mon_7pm/modules/layout/favorite/favorite_view.dart';
import 'package:event_app_c17_mon_7pm/modules/layout/home/home_view.dart';
import 'package:event_app_c17_mon_7pm/modules/layout/profile/profile_view.dart';
import 'package:flutter/material.dart';

class AppSettingsProvider extends ChangeNotifier {
  int _currentIndex = 0;
  int _currentCategoryIndex = 0;
  String currentLanguage = "en";
  ThemeMode currentTheme = ThemeMode.light;

  int get currentCategoryIndex => _currentCategoryIndex;

  int get currentIndex => _currentIndex;

  List<Widget> get pages => [HomeView(), FavoriteView(), ProfileView()];

  String get currentTextLanguage => currentLanguage == "en" ? "En" : "Ar";

  void changeCurrentCategoryIndex(int index) {
    _currentCategoryIndex = index;
    notifyListeners();
  }

  void changeCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void changeLanguage(String newLanguage) {
    currentLanguage = newLanguage;
    notifyListeners();
  }

  void changeTheme(ThemeMode newTheme) {
    currentTheme = newTheme;
    notifyListeners();
  }

  bool isDark() => currentTheme == ThemeMode.dark;
}
