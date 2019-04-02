import 'package:flutter/material.dart';
import 'package:kucharka/Screens/registration.dart';

class SignUpLink extends StatelessWidget {
  SignUpLink();

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: EdgeInsets.only(top: 160.0),
        child:  FlatButton(
          onPressed: () {
            Navigator.of(context).push( MaterialPageRoute(
                builder: (context) => RegistrationScreen()));
          },
          child:  Text(
            "Ještě nemáte účet? Zaregistrujte se",
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            style:  TextStyle(
                fontWeight: FontWeight.w300,
                letterSpacing: 0.5,
                color: Colors.white,
                fontSize: 12.0),
          ),
        ));
  }
}
