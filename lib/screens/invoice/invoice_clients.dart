// ignore_for_file: prefer_const_constructors

import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:storage/resources/app_images.dart';
import 'package:storage/resources/components.dart';
import 'package:storage/resources/styles.dart';
import 'package:storage/screens/home_screen/cubit/cubit.dart';
import 'package:storage/screens/home_screen/cubit/states.dart';
import 'package:storage/screens/invoice/invoice_id.dart';

class InvocieClientsScreen extends StatelessWidget {
  const InvocieClientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MicroCubit, MicroStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MicroCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'فواتير العملاء',
              style: Styles.textStyle25,
            ),
            actions: [Image.asset(AppImages.invocie)],
          ),
          body: ListView.builder(
            itemCount: cubit.c.length,
            itemBuilder: (context, index) => Card(
              elevation: 2,
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: ListTile(
                onTap: () => navigateTo(
                  context,
                  InvocieIdScreen(
                    clientsId: cubit.c[index].clientId!,
                    clientName: cubit.c[index].clientName.toString(),
                  ),
                ),
                title: Text(
                  '${cubit.c[index].clientName}',
                  style: Styles.textStyle16,
                ),
                subtitle: Text('رقم العميل: ${cubit.c[index].clientPhone}'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
          ),
        );
      },
    );
  }
}
