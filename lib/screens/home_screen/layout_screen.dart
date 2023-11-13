// ignore_for_file: prefer_const_constructors

import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:storage/screens/home_screen/cubit/cubit.dart';
import 'package:storage/screens/home_screen/cubit/states.dart';
import 'package:storage/screens/inventory/inventory_screen.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MicroCubit(),
      child: BlocConsumer<MicroCubit, MicroStates>(
        listener: (BuildContext context, MicroStates state) {},
        builder: (BuildContext context, MicroStates state) {
          return Scaffold(
              appBar: AppBar(),
              body: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) => Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InventoryScreen(),
                          ));
                    },
                    child: Container(
                      height: 200,
                      color: Colors.amber,
                      child: Text('المخزون'),
                    ),
                  ),
                ),
                itemCount: 1,
              ));
        },
      ),
    );
  }
}
