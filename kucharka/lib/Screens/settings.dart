import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

class SettingsScreen extends StatefulWidget {
  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nastavení'),
      ),
      body: PreferencePage([
        PreferenceTitle('Přizpůsobení'),
        SwitchPreference(
          'Tmavý vzhled',
          'dark_theme',
          onEnable: () async => DynamicTheme.of(context).setBrightness(Brightness.dark),
          onDisable: () async => DynamicTheme.of(context).setBrightness(Brightness.light),
        ),
    ])
    );
  }
}
