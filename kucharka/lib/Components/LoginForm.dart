import 'package:flutter/material.dart';
import 'package:kucharka/Components/ForgotPasswordLink.dart';
import 'package:kucharka/Misc/auth.dart';
import './InputFields.dart';

class LoginForm extends StatefulWidget {
  //const LoginForm({Key key}) : super(key: key);
  final FormState state = FormState();

  bool login() {
    return state.login();
  }

  @override
  FormState createState() => FormState();
}

class FormState extends State<LoginForm> {
  bool autoValidate = false; //TODO autovalidation
  String email = '';
  String password = '';
  static final formKey = new GlobalKey<FormState>();


  bool _validate() {
    final form = formKey.currentState;
    if (/*form.validate()*/true) {
      //TODO form.save();
      return true;
    }
  }

  bool login() {
     if (_validate()) { //auth.signIn(emailController.text, passwordController.text);
       print('logiN!!!');
       print("Email: " + email + " passwword: " + password);
       return true;
     }
  }

  Widget buildForm() {
    return Form(
        //autovalidate: autoValidate,
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        InputFieldArea(
          hint: "E-mail",
          obscure: false,
          onTextChanged: (text) {
            email = text;
          },
          icon: Icons.person_outline,
          inputType: TextInputType.emailAddress,
        ),
        InputFieldArea(
          hint: "Heslo",
          obscure: true,
          onTextChanged: (text) {
            password = text;
          },
          icon: Icons.lock_outline,
        ),
        ForgotPasswordLink(),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Form(
              key: formKey,
              autovalidate: autoValidate,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  InputFieldArea(
                    hint: "E-mail",
                    obscure: false,
                    onTextChanged: (text) {
                      email = text;
                    },
                    icon: Icons.person_outline,
                    inputType: TextInputType.emailAddress,
                  ),
                  InputFieldArea(
                    hint: "Heslo",
                    obscure: true,
                    onTextChanged: (text) {
                      password = text;
                    },
                    icon: Icons.lock_outline,
                  ),
                  ForgotPasswordLink(),
                ],
              )),
        ],
      ),
    );
  }
}
