import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AppThemeKeys { light, dark }

class AppTheme extends ChangeNotifier {
  static AppTheme of(BuildContext context, {bool listen = false}) =>
      Provider.of<AppTheme>(context, listen: listen);

  AppTheme() {
    _init();
  }

  _init() async {
    prefs = await SharedPreferences.getInstance();
    bool? boolValue = prefs?.getBool('isDarkMode');
    if (boolValue == null) {
      _themeKeys = AppThemeKeys.light;
    } else if (boolValue) {
      _themeKeys = AppThemeKeys.dark;
    } else {
      _themeKeys = AppThemeKeys.light;
    }
    notifyListeners();
  }

  AppThemeKeys? _themeKeys;
  SharedPreferences? prefs;

  ThemeData? getCurrentTheme() => _themes[_themeKeys];

  AppThemeKeys? getCurrentThemeKey() => _themeKeys;

  void setTheme(AppThemeKeys themeKey) {
    _themeKeys = themeKey;
    prefs?.setBool('isDarkMode', _themeKeys == AppThemeKeys.dark);
    notifyListeners();
  }

  final Map<AppThemeKeys, ThemeData> _themes = {
    AppThemeKeys.light: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        primary: Colors.blue,
        secondary: Colors.lightBlue,
        brightness: Brightness.light,
        primaryContainer: Colors.blue,
      ),
    ),
    AppThemeKeys.dark: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        primary: Colors.blue,
        secondary: Colors.lightBlue,
        brightness: Brightness.dark,
        primaryContainer: Colors.blue,
      ),
    ),
  };
}
