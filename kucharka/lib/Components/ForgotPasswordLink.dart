import 'package:flutter/material.dart';

class ForgotPasswordLink extends StatelessWidget {
  ForgotPasswordLink();

  @override
  Widget build(BuildContext context) {
    return  FlatButton(
      onPressed: () {
        //TODO forgot password reset
      },
      child:  Text(
        "Nedaří se vám přihlásit?",
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        softWrap: true,
        style:  TextStyle(
            fontWeight: FontWeight.w300,
            letterSpacing: 0.5,
            color: Colors.white,
            fontSize: 12.0),
      ),
    );
  }
}
