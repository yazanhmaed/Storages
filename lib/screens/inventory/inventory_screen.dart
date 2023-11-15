// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:storage/resources/widgets/my_cared.dart';
import 'package:storage/screens/home_screen/cubit/cubit.dart';
import 'package:storage/screens/home_screen/cubit/states.dart';
import 'package:storage/screens/inventory/add_item_screen.dart';
import 'package:storage/screens/storage_screen/data_page.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MicroCubit, MicroStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MicroCubit.get(context);
      
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(children: [
                    MyCared(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddProductScreen(),
                            ));
                      },
                      icon: Icons.add,
                      text: 'اضافة منتج جديد',
                    ),
                    MyCared(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DataPage(currentPerPage: cubit.i.length),
                            ));
                      },
                      icon: Icons.search,
                      text: "عرض المنتجات",
                    ),
                  ]),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
