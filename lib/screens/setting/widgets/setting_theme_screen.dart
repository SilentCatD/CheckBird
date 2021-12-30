import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class SettingTheme extends StatelessWidget {
  static const keyLanguage = 'key-language';
  static const keyDarkMode = 'key-darkmode';

  @override
  Widget build(BuildContext context) => SimpleSettingsTile(
    title: "Visual settings",
    subtitle:  "Theme, Language",
    leading: Container(
      padding: const EdgeInsets.all(6),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.green,
      ),
      child: const Icon(Icons.settings,color: Colors.white,) ,
    ),
    child: SettingsScreen(
      children: [
        buildLanguages(),
      ],

    ),
  );

  Widget buildLanguages() =>DropDownSettingsTile(
    settingKey: keyLanguage,
    title: "Languages",
    selected: 1,
    values: const <int, String> {
      1: "English",
      2: "Vietnamese",
    },
    onChange: (language) {/* */},
  );

  Widget buildDarkMode() => SwitchSettingsTile(
    title: "Dark mode",
    settingKey: keyDarkMode,
    onChange: (_) {} ,
    leading: Container(
      padding: const EdgeInsets.all(6),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.deepPurpleAccent,
      ),
      child: const Icon(Icons.dark_mode,color: Colors.white,) ,
    ),
  );

}