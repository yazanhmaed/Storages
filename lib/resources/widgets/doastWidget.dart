import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast({
  required String text,
  required ToastState state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: choseToasteColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastState { sUCCESS, eRORR, wORNING }

Color choseToasteColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.sUCCESS:
      color = Colors.green;
      break;
    case ToastState.eRORR:
      color = Colors.red;
      break;
    case ToastState.wORNING:
      color = Colors.amber;
      break;
  }
  return color;
}
