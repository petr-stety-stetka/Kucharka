import 'package:flutter/material.dart';
import 'package:kucharka/Components/loginAnimation.dart';
import 'package:flutter/animation.dart';
import 'dart:async';
import 'package:kucharka/Components/SignUpLink.dart';
import 'package:kucharka/Components/LoginForm.dart';
import 'package:kucharka/Components/SignButton.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:kucharka/app.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({Key key}) : super(key: key);

  @override
  AddRecipScreenState createState() => AddRecipScreenState();
}

class AddRecipScreenState extends State<AddRecipeScreen> {

  Future<bool> onWillPop() {
    return showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: Text('Opravdu se nechcete přihlásit?'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text('Ne'),
                    ),
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text('Ano'),
                    ),
                  ],
                )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 0.4;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    var backgroundImage = DecorationImage(
      image: ExactAssetImage('assets/images/background_login.jpg'),
      fit: BoxFit.cover,
    );

    final loginForm = LoginForm();

    return (WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          body: Text('d')
        )));
  }
}
