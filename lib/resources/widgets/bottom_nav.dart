// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:storage/model/sale_model.dart';
import 'package:storage/resources/styles.dart';
import 'package:storage/screens/home_screen/cubit/cubit.dart';

class BuildBottomNav extends StatelessWidget {
  const BuildBottomNav({
    super.key,
    required this.salesItems1,
    required this.cubit,
  });

  final List<SaleModel> salesItems1;
  final MicroCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Text('الاجمالي', style: Styles.textStyle18),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: salesItems1.isEmpty
                  ? Text('0.0')
                  : Text('${cubit.totalCost}'),
            ),
            Text('الكمية', style: Styles.textStyle18),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child:
                  salesItems1.isEmpty ? Text('0') : Text('${cubit.totalCount}'),
            ),
          ],
        ),
      ),
    );
  }
}
