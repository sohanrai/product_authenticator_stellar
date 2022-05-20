import 'package:flutter/material.dart';
import 'package:menuwale/models/App_Colors.dart';

class AppAlert extends StatelessWidget {
  AppAlert({this.titleText, this.contentText, this.actionText, this.onPressed});
  final String titleText;
  final String contentText;
  final String actionText;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        titleText,
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            contentText,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20.0,
          ),
          FlatButton(
              color: AppColors.yellow,
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                actionText,
                style: TextStyle(color: AppColors.black),
              ),
              onPressed: onPressed)
        ],
      ),
    );
  }
}
