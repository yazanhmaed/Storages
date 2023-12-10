import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:storage/resources/components.dart';
import 'package:storage/screens/home_screen/cubit/cubit.dart';
import 'package:storage/screens/home_screen/cubit/states.dart';
import 'package:storage/screens/invoice/invocie_screen.dart';

class InvocieIdScreen extends StatefulWidget {
  const InvocieIdScreen({super.key, required this.clientsId});
  final int clientsId;

  @override
  State<InvocieIdScreen> createState() => _InvocieIdScreenState();
}

class _InvocieIdScreenState extends State<InvocieIdScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MicroCubit.get(context).invoiceClient(clientsId: widget.clientsId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MicroCubit, MicroStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MicroCubit.get(context);

        return Scaffold(
          appBar: AppBar(),
          body: ListView.builder(
            itemCount: cubit.invoiceClientList.length,
            itemBuilder: (context, index) => ListTile(
              onTap: () {
                print(cubit.invoiceClientList[index].id!);
                navigateTo(
                    context,
                    InvocieScreen(
                      clientsId: widget.clientsId,
                      id: cubit.invoiceClientList[index].id!,
                    ));
              },
              shape: Border.all(),
              title: Text('${cubit.invoiceClientList[index].id}'),
            ),
          ),
        );
      },
    );
  }
}
