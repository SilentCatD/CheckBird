import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppTheme extends ChangeNotifier {
  static AppTheme of(BuildContext context, {bool listen = false}) =>
      Provider.of<AppTheme>(context, listen: listen);

  AppTheme(){
    _AppTheme();
  }

  _AppTheme() async {
    prefs = await  SharedPreferences.getInstance();
    bool? boolValue = prefs?.getBool('isDarkMode');
    if(boolValue==null) {
      _themeKeys = AppThemeKeys.light;
    }
    else if(boolValue) {
      _themeKeys = AppThemeKeys.dark;
    }
    else {
      _themeKeys = AppThemeKeys.light;
    }
    notifyListeners();
  }

  AppThemeKeys? _themeKeys;
  SharedPreferences? prefs;



  ThemeData? getCurrentTheme() => _themes[_themeKeys];

  void setTheme(AppThemeKeys themeKey) {
    _themeKeys = themeKey;
    notifyListeners();
  }
}

enum AppThemeKeys { light, dark}
Map<AppThemeKeys, ThemeData> _themes = {
  AppThemeKeys.light: ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.blue,
      fontFamily: 'OpenSans',
      colorScheme: const ColorScheme.light().copyWith(
        secondary: Colors.lightBlue,
        primary: Colors.blue,
      )
  ),
  AppThemeKeys.dark: ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.purple,
      fontFamily: 'OpenSans',
      colorScheme: const ColorScheme.dark().copyWith(
        secondary: Colors.deepPurple,
        primary: Colors.white,
      )
  ),

};