import 'package:flutter/material.dart';
import 'package:menuwale/models/App_Colors.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  AppButton({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: AppColors.yellow,
      padding: EdgeInsets.symmetric(vertical: 20.0),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 28.0,
        ),
      ),
    );
  }
}

class AppSmallButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  AppSmallButton({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: FlatButton(
        color: AppColors.yellow,
        padding: EdgeInsets.symmetric(vertical: 18.0),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}
