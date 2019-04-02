import 'package:flutter/material.dart';
import './InputFields.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key key}) : super(key: key);

  @override
  FormState createState() =>  FormState();
}

class FormState extends State<RegistrationForm> {
  bool autoValidate = false; //TODO autovalidation

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
           Form(
              autovalidate: autoValidate,
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                   InputFieldArea(
                    hint: "Jméno a příjmení",
                    obscure: false,
                    icon: Icons.person_outline,
                    inputType: TextInputType.emailAddress,
                  ),
                   InputFieldArea(
                    hint: "E-mail",
                    obscure: false,
                    icon: Icons.alternate_email,
                    inputType: TextInputType.emailAddress,
                  ),
                   InputFieldArea(
                    hint: "Heslo s alespoň 8 znaky",
                    obscure: true,
                    icon: Icons.lock_outline,
                  ),
                   InputFieldArea(
                    hint: "Heslo ještě jednou",
                    obscure: true,
                    icon: Icons.replay,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
