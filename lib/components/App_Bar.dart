import 'package:flutter/material.dart';
import 'package:menuwale/models/App_Colors.dart';

AppBar buildAppBar({String text, List<Widget> actions}) {
  return AppBar(
    iconTheme: IconThemeData(
      color: Colors.black, //change your color here
    ),
    brightness: Brightness.light,
    centerTitle: true,
    actions: actions,
    title: Text(
      text,
      style: TextStyle(
          color: AppColors.black, fontWeight: FontWeight.bold, fontSize: 22.0),
    ),
  );
}
