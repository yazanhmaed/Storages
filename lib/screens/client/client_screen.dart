// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:storage/resources/app_images.dart';
import 'package:storage/resources/widgets/appbar.dart';
import 'package:storage/resources/widgets/my_cared.dart';
import 'package:storage/screens/client/add_client_screen.dart';
import 'package:storage/screens/client/balance.dart';
import 'package:storage/screens/client/client_show.dart';
import 'package:storage/screens/home_screen/cubit/cubit.dart';
import 'package:storage/screens/home_screen/cubit/states.dart';

class ClientScreen extends StatelessWidget {
  const ClientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MicroCubit, MicroStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MicroCubit.get(context);

        return Scaffold(
          appBar: buildAppBar(title: "العملاء", image: AppImages.client),
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
                              builder: (context) => AddClientScreen(),
                            ));
                      },
                      icon: Icons.add,
                      text: 'اضافة عميل جديد',
                    ),
                    MyCared(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ClientShowScreen(
                                  currentPerPage: cubit.c.length),
                            ));
                      },
                      icon: Icons.search,
                      text: "عرض العملاء",
                    ),
                    MyCared(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BalanceScreen(currentPerPage: cubit.c.length),
                            ));
                      },
                      icon: Icons.add,
                      text: "الارصدة الافتتاحيه للعملاء",
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
