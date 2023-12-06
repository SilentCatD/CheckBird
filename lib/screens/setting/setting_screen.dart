import 'package:check_bird/services/authentication.dart';
import 'package:check_bird/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  static const keyLanguage = 'key-language';
  static const keyDarkMode = 'key-darkmode';
  static const routeName = '/setting-screen';
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            title: const Text("Settings"), automaticallyImplyLeading: true),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 24),
            children: [
              SettingsGroup(
                title: 'GENERAL',
                children: <Widget>[
                  buildDarkMode(),
                ],
              ),
              const SizedBox(height: 16),
              SettingsGroup(
                title: "FEEDBACK",
                children: <Widget>[
                  buildFeedBack(),
                  buildReportBug(),
                ],
              ),
              const SizedBox(height: 16),
              SettingsGroup(
                title: "ACCOUNT",
                children: <Widget>[
                  buildDeleteAccount(),
                ],
              ),
            ],
          ),
        ),
      );

  Widget buildFeedBack() => SimpleSettingsTile(
        title: "Send Feedback",
        subtitle: '',
        leading: Container(
          padding: const EdgeInsets.all(6),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.deepPurple,
          ),
          child: const Icon(
            Icons.thumb_up_rounded,
            color: Colors.white,
          ),
        ),
      );

  Widget buildReportBug() => SimpleSettingsTile(
        title: "Report bug",
        subtitle: '',
        leading: Container(
          padding: const EdgeInsets.all(6),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.teal,
          ),
          child: const Icon(
            Icons.error_outline_rounded,
            color: Colors.white,
          ),
        ),
      );

  Widget buildDeleteAccount() => SimpleSettingsTile(
        title: "Delete Account",
        leading: Container(
          padding: const EdgeInsets.all(6),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red,
          ),
          child: const Icon(
            Icons.error_outline_rounded,
            color: Colors.white,
          ),
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (contextDialog) {
              return AlertDialog(
                title: const Text('Delete your Account?'),
                content: const Text(
                    '''If you select Delete we will delete your account on our server.\nYour app data will also be deleted and you won't be able to retrieve it.'''),
                actions: [
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(contextDialog).pop();
                    },
                  ),
                  TextButton(
                    child: const Text(
                      'Delete',
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () async {
                      Navigator.of(contextDialog).pop();
                      await Authentication.deleteUserAccount();
                      if (!context.mounted) return;
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
      );

  Widget buildLanguages() => DropDownSettingsTile(
        settingKey: SettingScreen.keyLanguage,
        title: "Languages",
        selected: 1,
        values: const <int, String>{
          1: "English",
          2: "Vietnamese",
        },
        onChange: (language) {/* */},
      );

  Widget buildDarkMode() => SwitchSettingsTile(
        title: "Dark mode",
        settingKey: SettingScreen.keyDarkMode,
        onChange: (value) async {
          debugPrint('key-check-box-dev-mode: $value');
          if (value) {
            AppTheme.of(context).setTheme(AppThemeKeys.dark);
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setBool('isDarkMode', true);
          } else {
            AppTheme.of(context).setTheme(AppThemeKeys.light);
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setBool('isDarkMode', false);
          }
        },
        leading: Container(
          padding: const EdgeInsets.all(6),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.deepPurpleAccent,
          ),
          child: const Icon(
            Icons.dark_mode,
            color: Colors.white,
          ),
        ),
      );

  AppTheme? _theme;
  @override
  void didChangeDependencies() {
    _theme ??= AppTheme.of(context);
    super.didChangeDependencies();
  }
}
