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

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  AnimationController loginButtonController;
  var animationStatus = 0;

  @override
  void initState() {
    super.initState();
    loginButtonController = AnimationController(duration: Duration(milliseconds: 3000), vsync: this);
  }

  @override
  void dispose() {
    loginButtonController.dispose();
    super.dispose();
  }

  Future<Null> playAnimation() async {
    try {
      await loginButtonController.forward();
      await loginButtonController.reverse();
    } on TickerCanceled {}
  }

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
          body: Container(
              decoration: BoxDecoration(
                image: backgroundImage,
              ),
              child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: <Color>[
                      const Color.fromRGBO(162, 146, 199, 0.8),
                      const Color.fromRGBO(51, 51, 63, 0.9),
                    ],
                    stops: [0.2, 1.0],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(0.0, 1.0),
                  )),
                  child: ListView(
                    padding: const EdgeInsets.all(0.0),
                    children: <Widget>[
                      Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                  width: 250.0,
                                  height: 250.0,
                                  alignment: Alignment.center,
                                  child: Icon(Icons.check, color: Colors.white, size: 200.0)),
                              loginForm,
                              SignUpLink()
                            ],
                          ),
                          animationStatus == 0
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 50.0),
                                  child: Material(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.all(const Radius.circular(30.0)),
                                    child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            animationStatus = 1;
                                          });
                                          playAnimation();
                                        },
                                        borderRadius: BorderRadius.all(const Radius.circular(30.0)),
                                        child: SignButton('Přihlásit se')),
                                  ))
                              : StaggerAnimation(
                                  buttonController: loginButtonController.view,
                                  text: 'Přihlásit se',
                                  bottom: 50.0,
                                  onCompleted: () {
                                    loginForm.login();
                                    /*Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) => App()));*/
                                  }),
                        ],
                      ),
                    ],
                  ))),
        )));
  }
}
