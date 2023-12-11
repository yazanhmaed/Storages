// ignore_for_file: prefer_const_constructors

import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:storage/resources/styles.dart';
import 'package:storage/screens/home_screen/cubit/cubit.dart';
import 'package:storage/screens/home_screen/cubit/states.dart';

class InvocieScreen extends StatefulWidget {
  const InvocieScreen({Key? key, required this.id, required this.clientsId})
      : super(key: key);

  final int id;
  final int clientsId;

  @override
  State<InvocieScreen> createState() => _InvocieScreenState();
}

class _InvocieScreenState extends State<InvocieScreen> {
  @override
  void initState() {
    super.initState();
    MicroCubit.get(context)
        .invoiceItem(clientsId: widget.clientsId, invoiceId: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MicroCubit, MicroStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MicroCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'تفاصيل الفاتورة',
              style: Styles.textStyle25,
            ),
          ),
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Card(
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
                                style: Styles.textStyle14
                                    .copyWith(color: Colors.white)),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Center(
                            child: Text('الكمية',
                                style: Styles.textStyle14
                                    .copyWith(color: Colors.white)),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Text("الاجمالي",
                                style: Styles.textStyle14
                                    .copyWith(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height - 240,
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 2,
                                margin: EdgeInsets.all(8),
                                child: ListTile(
                                  onTap: () {},
                                  leading: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    child: Text(
                                      cubit.invocieItemList[index].itemName!,
                                      style: Styles.textStyle14,
                                    ),
                                  ),
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Center(
                                          child: Text(
                                            cubit.invocieItemList[index]
                                                .itemPrice
                                                .toString(),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Center(
                                          child: Text(
                                            cubit.invocieItemList[index]
                                                .itemCount
                                                .toString(),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Center(
                                          child: Text(
                                            '${cubit.invocieItemList[index].itemFill! * cubit.invocieItemList[index].itemPrice! * cubit.invocieItemList[index].itemCount!}',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: cubit.invocieItemList.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
