import 'package:flutter/material.dart';
import 'package:kucharka/Misc/PrefService.dart';
import 'package:kucharka/app.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

main() async {
  await PrefService.init(prefix: 'pref_');
  runApp(Kucharka());
}

class Kucharka extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) =>
         ThemeData(
            brightness: brightness,
            primarySwatch: Colors.red,
            primaryColor: Colors.red,
            accentColor: Colors.redAccent,
            textTheme: TextTheme(
              title: TextStyle(fontSize: 18.0),
            ),
         ),
        themedWidgetBuilder: (context, theme) {
          return MaterialApp(
            title: App.title,
            theme: theme,
            home: App(),
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('cs', 'CZ'),
            ],
          );
        });
  }
}