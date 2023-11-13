import 'package:flutter/material.dart';

import 'package:storage/resources/styles.dart';


class MyCared extends StatelessWidget {
  const MyCared({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });
  final IconData icon;
  final String text;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon),
              Container(
                child: Text(
                  text,
                  style: Styles.textStyle18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
