import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:storage/resources/components.dart';
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
          appBar: AppBar(),
          body: ListView.builder(
            itemCount: cubit.c.length,
            itemBuilder: (context, index) => ListTile(
              onTap: () => navigateTo(
                  context,
                  InvocieIdScreen(
                    clientsId: cubit.c[index].clientId!,
                  )),
              shape: Border.all(),
              title: Text(
                '${cubit.c[index].clientName}',
              ),
            ),
          ),
        );
      },
    );
  }
}
