import 'package:check_bird/screens/setting/widgets/setting_theme_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class SettingScreen extends StatefulWidget {
  static const routeName = '/setting-screen';

  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();

}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(24),
          children: [
            SettingsGroup(
              title: 'GENERAL',
              children: <Widget>[
                SettingTheme(),
                buildLogout(),
              ],
            ),
            const SizedBox(height:32),
            SettingsGroup(
              title: "FEEDBACK",
              children: <Widget>[
                buildFeedBack(),
                buildReportBug(),
              ],
            )
          ],
        ),
      ),
    );
    throw UnimplementedError();
  }

  Widget buildLogout() =>SimpleSettingsTile(
    title: "Logout",
    subtitle: '',
    leading:  Container(
       padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.cyan,
      ),
      child: Icon(Icons.logout,color: Colors.white,),
    ),
    onTap: ()=>null,
  );

  Widget buildFeedBack() =>SimpleSettingsTile(
    title: "Send Feedback",
    subtitle: '',
    leading:  Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.deepPurple,
      ),
      child: Icon(Icons.thumb_up_rounded,color: Colors.white,),
    ),
    onTap: ()=>null,
  );


  Widget buildReportBug() =>SimpleSettingsTile(
    title: "Report bug",
    subtitle: '',
    leading:  Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.teal,
      ),
      child: Icon(Icons.error_outline_rounded,color: Colors.white,),
    ),
    onTap: ()=>null,
  );

}