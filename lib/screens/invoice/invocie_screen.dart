import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:storage/resources/styles.dart';
import 'package:storage/screens/home_screen/cubit/cubit.dart';
import 'package:storage/screens/home_screen/cubit/states.dart';

class InvocieScreen extends StatefulWidget {
  const InvocieScreen({super.key, required this.id, required this.clientsId});
  final int id;
  final int clientsId;

  @override
  State<InvocieScreen> createState() => _InvocieScreenState();
}

class _InvocieScreenState extends State<InvocieScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MicroCubit.get(context)
        .invoiceItem(clientsId: widget.clientsId, id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MicroCubit, MicroStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = MicroCubit.get(context);

        return Scaffold(
          appBar: AppBar(),
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
                        // Text('التعبئة',
                        //     style: Styles.textStyle14
                        //         .copyWith(color: Colors.white)),
                        Expanded(
                          flex: 2,
                          child: Center(
                            child: Text('الكميه',
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
                                child: ListTile(
                                  onTap: () {
                                    // showFlexibleBottomSheet(
                                    //   minHeight: 0,
                                    //   initHeight: 0.9,
                                    //   maxHeight: 0.9,
                                    //   context: context,
                                    //   builder: (context, scrollController,
                                    //           bottomSheetOffset) =>
                                    //       InfoSaleScreen(
                                    //     list: salesItems1,
                                    //     scrollController: scrollController,
                                    //     cubit: cubit,
                                    //     data: salesItems1[index],
                                    //     delete: () {},
                                    //   ),
                                    //   isExpand: false,
                                    // );
                                  },
                                  leading: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    child: Text(
                                        cubit.invocieItemList[index].itemName!,
                                        style: Styles.textStyle14),
                                  ),
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Center(
                                          child: Text(cubit
                                              .invocieItemList[index].itemPrice
                                              .toString()),
                                        ),
                                      ),
                                      // Text(salesItems1[index]
                                      //     .itemFill
                                      //     .toString()),
                                      Expanded(
                                        flex: 2,
                                        child: Center(
                                          child: InkWell(
                                            onTap: () {
                                              // cubit.changeCount(
                                              //     index: index,
                                              //     list: salesItems1);

                                              // cubit.calculateTotalCount(
                                              //     list: salesItems1);

                                              // print(
                                              //     salesItems1[index].itemCount);

                                              // cubit.calculateTotalCost(
                                              //     salesItems1: salesItems1);
                                            },
                                            onLongPress: () {
                                              // cubit.calculateTotalCount(
                                              //     list: salesItems1);
                                              // cubit.calculateTotalCost(
                                              //     salesItems1: salesItems1);
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                border: Border.all(),
                                              ),
                                              child: Text(cubit
                                                  .invocieItemList[index]
                                                  .itemCount
                                                  .toString()),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Center(
                                          child: Text(
                                              '${cubit.invocieItemList[index].itemFill! * cubit.invocieItemList[index].itemPrice! * cubit.invocieItemList[index].itemCount!}'),
                                         
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
                        // if (clientList.isNotEmpty)
                        //   SizedBox(
                        //       height: MediaQuery.sizeOf(context).height - 240,
                        //       child: Card(
                        //         child: ListView.builder(
                        //           itemCount: clientList.length,
                        //           itemBuilder: (context, index) {
                        //             return ListTile(
                        //               onTap: () {
                        //                 setState(() {
                        //                   nameClient.text =
                        //                       clientList[index].clientName!;
                        //                   clientList = [];
                        //                 });
                        //                 print(nameClient.text);
                        //               },
                        //               title: Text(
                        //                   '${clientList[index].clientName}'),
                        //             );
                        //           },
                        //         ),
                        //       )),
                        // if (controller.text.isNotEmpty)
                        //   Card(
                        //     child: SizedBox(
                        //         height: MediaQuery.sizeOf(context).height - 240,
                        //         child: ListView.builder(
                        //           itemCount: source.length,
                        //           itemBuilder: (context, index) {
                        //             return ListTile(
                        //               onTap: () {
                        //                 if (salesItems1.any((element) =>
                        //                     element.itemNumber ==
                        //                     source[index]['itemNumber'])) {
                        //                   cubit.changeCount(
                        //                       index: salesItems1.indexWhere(
                        //                         (element) =>
                        //                             element.itemNumber ==
                        //                             source[index]['itemNumber'],
                        //                       ),
                        //                       list: salesItems1);
                        //                 } else {
                        //                   salesItems1.add(SaleModel.fromJson(
                        //                       source[index]));
                        //                 }

                        //                 setState(() {
                        //                   controller.clear();
                        //                 });
                        //                 cubit.calculateTotalCount(
                        //                     list: salesItems1);
                        //                 print(salesItems1[index].itemCostb);
                        //                 cubit.calculateTotalCost(
                        //                     salesItems1: salesItems1);
                        //               },
                        //               title: Row(
                        //                 mainAxisAlignment:
                        //                     MainAxisAlignment.spaceAround,
                        //                 children: [
                        //                   Text(
                        //                     '${_sourceFiltered[index]['itemName']}',
                        //                   ),
                        //                   Text(
                        //                       '(${_sourceFiltered[index]['itemCount']})'),
                        //                 ],
                        //               ),
                        //             );
                        //           },
                        //         )),
                        //   ),
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
