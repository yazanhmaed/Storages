import 'package:flutter/material.dart';

class StorageScreen extends StatelessWidget {
  const StorageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: 2,
       itemBuilder: (context, index) => Container(
       
        color: Colors.amber,
        child: const Text('data'),
       ) ,),
    );
  }
}