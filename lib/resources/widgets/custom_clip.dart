// import 'package:flutter/material.dart';

// class CustomClipPath extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     double width = size.width;
//     double height = size.height;

//     final path = Path();
//     path.lineTo(0, height);
//     path.quadraticBezierTo(width * 0.5, height - 100, width, height - 100);
//     path.lineTo(width, height);
//     path.lineTo(width, 0);
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return true;
//   }
// }
