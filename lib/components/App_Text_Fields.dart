import 'package:flutter/material.dart';

class AppTextFields extends StatelessWidget {
  AppTextFields({
    this.text,
    this.icon,
    this.hintText,
    this.validator,
    this.onChanged,
    this.keyboardType,
    this.obscureText = false,
    this.controller,
    this.textCapitalization = TextCapitalization.none,
  });
  final String text;
  final Icon icon;
  final hintText;
  final validator;
  final keyboardType;
  final Function onChanged;
  final bool obscureText;
  final TextEditingController controller;
  final textCapitalization;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
        ),
        TextFormField(
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xffDDDDDC)),
              //  when the TextFormField in unfocused
            ),
            hintText: hintText,
            prefixIcon: icon,
            contentPadding: EdgeInsets.only(top: 15.0),
          ),
          validator: validator,
          textCapitalization: textCapitalization,
          onChanged: onChanged,
          obscureText: obscureText,
          keyboardType: keyboardType,
          controller: controller,
        ),
        SizedBox(
          height: 15.0,
        )
      ],
    );
  }
}
