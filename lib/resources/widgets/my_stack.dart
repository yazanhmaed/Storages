// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

import 'package:storage/resources/styles.dart';

class MyStack extends StatelessWidget {
  const MyStack({
    super.key,
    required this.text,
    this.onTap,
    required this.image,
  });
  final String image;

  final String text;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(
              10,
            )),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Image.asset(
                image,
                height: 100,
                fit: BoxFit.cover,
              ),
              const Spacer(),
              Container(
                child: Text(
                  text,
                  style: Styles.textStyle25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
