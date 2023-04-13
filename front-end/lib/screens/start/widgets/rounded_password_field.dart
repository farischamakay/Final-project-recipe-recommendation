import 'package:flutter/material.dart';
import 'widgets.dart';

class RoundedPasswordField extends StatelessWidget {
  const RoundedPasswordField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        obscureText: true,
        cursorColor: Color(0xfff1bb274),
        decoration: const InputDecoration(
            icon: Icon(
              Icons.lock,
              color: Color(0xfff1bb274),
            ),
            hintText: "Password",
            hintStyle: TextStyle(fontFamily: 'OpenSans'),
            suffixIcon: Icon(
              Icons.visibility,
              color: Color(0xfff1bb274),
            ),
            border: InputBorder.none),
      ),
    );
  }
}
