
import 'package:flutter/material.dart';
import 'package:storage/resources/styles.dart';

class HedarCard extends StatelessWidget {
  const HedarCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[500],
      child: ListTile(
        leading: SizedBox(
          width: MediaQuery.of(context).size.width * 0.2,
          child: Text(
            'المنتج',
            style: Styles.textStyle14.copyWith(color: Colors.white),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 2,
              child: Center(
                child: Text('السعر',
                    style: Styles.textStyle14.copyWith(color: Colors.white)),
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Text('الكمية',
                    style: Styles.textStyle14.copyWith(color: Colors.white)),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text("الاجمالي",
                    style: Styles.textStyle14.copyWith(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
