// ignore_for_file: prefer_const_constructors

import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:storage/resources/styles.dart';

import 'package:storage/resources/widgets/my_stack.dart';
import 'package:storage/screens/client/client_screen.dart';
import 'package:storage/screens/home_screen/cubit/cubit.dart';
import 'package:storage/screens/home_screen/cubit/states.dart';
import 'package:storage/screens/inventory/inventory_screen.dart';
import 'package:storage/screens/sales/sales.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MicroCubit(),
      child: BlocConsumer<MicroCubit, MicroStates>(
        listener: (BuildContext context, MicroStates state) {},
        builder: (BuildContext context, MicroStates state) {
          return SafeArea(
            child: Scaffold(
                body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 5.0,
                ),
                children: [
                  MyStack(
                    text: 'المخزون',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InventoryScreen(),
                          ));
                    },
                    image: 'assets/images/items.png',
                  ),
                  MyStack(
                    text: 'المبيعات',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SalesScreen(),
                          ));
                    },
                    image: 'assets/images/sales.png',
                  ),
                  MyStack(
                    text: 'العملاء',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClientScreen(),
                          ));
                    },
                    image: 'assets/images/client.png',
                  ),
                ],
              ),
            )),
          );
        },
      ),
    );
  }
}
