// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:storage/resources/styles.dart';

Future<bool> onWillPop(BuildContext context) async {
  return (await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'هل تريد العودة للقائمه الرئيسيه؟',
            style: Styles.textStyle18,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                'لا',
                style: Styles.textStyle14,
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(
                'نعم',
                style: Styles.textStyle14,
              ),
            ),
          ],
        ),
      )) ??
      false;
}
