import 'package:flutter/material.dart';
import 'package:storage/resources/styles.dart';

AppBar buildAppBar({
  required String title,
  required String image,
}) {
  return AppBar(
    title: Text(
      title,
      style: Styles.textStyle25,
    ),
    actions: [
      Image.asset(
        image,
        fit: BoxFit.scaleDown,
      )
    ],
  );
}
