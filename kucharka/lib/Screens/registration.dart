import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:kucharka/Components/RegistrationForm.dart';
import 'package:kucharka/Components/SignButton.dart';
import 'package:kucharka/Components/loginAnimation.dart';
import 'package:kucharka/app.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key key}) : super(key: key);

  @override
  RegistrationScreenState createState() =>  RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen>
    with TickerProviderStateMixin {
  AnimationController registerButtonController;
  var animationStatus = 0;

  @override
  void initState() {
    super.initState();
    registerButtonController =  AnimationController(
        duration:  Duration(milliseconds: 3000), vsync: this);
  }

  @override
  void dispose() {
    registerButtonController.dispose();
    super.dispose();
  }

  Future<Null> playAnimation() async {
    try {
      await registerButtonController.forward();
      await registerButtonController.reverse();
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 0.4;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    var backgroundImage =  DecorationImage(
      image:  ExactAssetImage('assets/images/background_registration.jpg'),
      fit: BoxFit.cover,
    );

    return ( Scaffold(
      body:  Container(
          decoration:  BoxDecoration(
            image: backgroundImage,
          ),
          child:  Container(
              decoration:  BoxDecoration(
                  gradient:  LinearGradient(
                colors: <Color>[
                  const Color.fromRGBO(162, 146, 199, 0.8),
                  const Color.fromRGBO(51, 51, 63, 0.9),
                ],
                stops: [0.2, 1.0],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.0, 1.0),
              )),
              child:  ListView(
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
                              child: Icon(Icons.people,
                                  color: Colors.white, size: 160.0)),
                           RegistrationForm(),
                           Padding(padding: EdgeInsets.only(top: 115.0))
                        ],
                      ),
                      animationStatus == 0
                          ?  Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child:  Material(
                                color: Theme.of(context).primaryColor,
                                borderRadius:  BorderRadius.all(
                                    const Radius.circular(30.0)),
                                child:  InkWell(
                                    onTap: () {
                                      setState(() {
                                        animationStatus = 1;
                                      });
                                      playAnimation();
                                    },
                                    borderRadius:  BorderRadius.all(
                                        const Radius.circular(30.0)),
                                    child:  SignButton('Registrovat se')),
                              ))
                          :  StaggerAnimation(
                              buttonController: registerButtonController.view,
                              text: 'Registrovat se',
                              bottom: 20.0,
                              onCompleted: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pushReplacement(
                                    context,
                                     MaterialPageRoute(
                                        builder: (context) => App()));
                              }),
                    ],
                  ),
                ],
              ))),
    ));
  }
}
