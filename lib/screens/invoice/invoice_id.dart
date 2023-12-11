// ignore_for_file: prefer_const_constructors

import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:storage/resources/components.dart';
import 'package:storage/resources/styles.dart';
import 'package:storage/screens/home_screen/cubit/cubit.dart';
import 'package:storage/screens/home_screen/cubit/states.dart';
import 'package:storage/screens/invoice/invocie_screen.dart';

class InvocieIdScreen extends StatefulWidget {
  const InvocieIdScreen(
      {Key? key, required this.clientsId, required this.clientName})
      : super(key: key);

  final int clientsId;
  final String clientName;

  @override
  State<InvocieIdScreen> createState() => _InvocieIdScreenState();
}

class _InvocieIdScreenState extends State<InvocieIdScreen> {
  @override
  void initState() {
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
          appBar: AppBar(
            title: RichText(
              text: TextSpan(
                text: 'الفواتير باسم العميل: ',
                style: Styles.textStyle20,
                children: [
                  TextSpan(
                    text: widget.clientName,
                    style: Styles.textStyle20,
                  ),
                ],
              ),
            ),
          ),
          body: cubit.invoiceClientList.isEmpty
              ? Center(
                  child: Text('لا توجد فواتير حاليًا'),
                )
              : ListView.builder(
                  itemCount: cubit.invoiceClientList.length,
                  itemBuilder: (context, index) => Card(
                    elevation: 2, // تعديل الارتفاع حسب الحاجة
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: ListTile(
                      onTap: () {
                        print(cubit.invoiceClientList[index].id!);
                        navigateTo(
                          context,
                          InvocieScreen(
                            clientsId: widget.clientsId,
                            id: cubit.invoiceClientList[index].id!,
                          ),
                        );
                      },
                      title: Text(
                        'رقم الفاتورة: ${cubit.invoiceClientList[index].id}',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'تاريخ الفاتورة: 11/12/2023',
                        style: TextStyle(fontSize: 14),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
