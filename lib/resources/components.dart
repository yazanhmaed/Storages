// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(
  context,
  widget,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) {
        return false;
      },
    );

double calculateOptimalTextSize(BoxConstraints constraints) {
  double maxWidth = constraints.maxWidth;
  double maxHeight = constraints.maxHeight;
  double optimalSize = 25.0; // Default font size

  if (maxWidth < 200.0 || maxHeight < 100.0) {
    optimalSize = 16.0;
  }

  return optimalSize;
}


