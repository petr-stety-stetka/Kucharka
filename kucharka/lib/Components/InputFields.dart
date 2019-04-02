import 'package:flutter/material.dart';
import 'package:kucharka/Model/StringData.dart';

typedef TextChangedCallback = void Function(String text);

class InputFieldArea extends StatelessWidget {
  final String hint;

  //final String validationText;
  final bool obscure;
  final IconData icon;
  final TextInputType inputType;
  TextChangedCallback onTextChanged;

  InputFieldArea({this.hint, this.obscure, this.icon, this.onTextChanged, this.inputType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return (Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: Colors.white24,
          ),
        ),
      ),
      child: TextFormField(
        obscureText: obscure,
        keyboardType: inputType,
        style: const TextStyle(
          color: Colors.white,
        ),
        autocorrect: false,
        //validator: (val) => val.isEmpty ? 'Email can\'t be empty.' : null,
        onSaved: (val) => print('new::::' + val),
       // onSaved: (val) => value = val,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Colors.white,
          ),
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white, fontSize: 15.0),
          contentPadding: const EdgeInsets.only(top: 25.0, right: 30.0, bottom: 25.0, left: 5.0),
        ),
      ),
    ));
  }
}

//class FormState extends State<InputFieldArea> {}
