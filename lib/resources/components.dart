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

int currentIndex = 0;

int? pageIndex = 0;
double? latitude = 24.467200;
double? longitude = 39.609792;
int? fajr = 0;
int? dhuhr = 0;
int? asr = 0;
int? maghrib = 0;
int? isha = 0;
String? country = 'SaudiArabia';
String? city = 'Makkah';
String? cityAr = 'مكة';
String? day='';
List<String> timeSalat = [];
int? methodIndex = 4;
bool? timeDialog = false;
List settingTime = [
  fajr,
  dhuhr,
  asr,
  maghrib,
  isha,
];
