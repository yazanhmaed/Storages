// ignore_for_file: prefer_const_constructors

import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:storage/model/client_model.dart';
import 'package:storage/model/sale_model.dart';
import 'package:storage/resources/styles.dart';
import 'package:storage/resources/widgets/bottom_sheet.dart';
import 'package:storage/resources/widgets/bottom_sheet_sale.dart';
import 'package:storage/screens/home_screen/cubit/cubit.dart';
import 'package:storage/screens/home_screen/cubit/states.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesState();
}

class _SalesState extends State<SalesScreen> {
  int _total = 100;
  List<bool>? expanded;
  final String _searchKey = "itemName";

  final List<Map<String, dynamic>> sourceOriginal = [];
  List<Map<String, dynamic>> _sourceFiltered = [];
  List<Map<String, dynamic>> source = [];
  // ignore: unused_field
  final String _selectableKey = "itemNumber";

  bool isLoading = true;
  List<ClientModel> clientList = [];
  TextEditingController controller = TextEditingController();
  TextEditingController nameClient = TextEditingController();
  bool clientSearch = false;
  List<SaleModel> salesItems1 = [];

  _filterSearch(value) {
    setState(() => isLoading = true);

    try {
      if (value == "" || value == null) {
        _sourceFiltered = sourceOriginal;
      } else {
        _sourceFiltered = sourceOriginal
            .where((data) => data[_searchKey]
                .toString()
                .toLowerCase()
                .contains(value.toString().toLowerCase()))
            .toList();
      }

      _total = _sourceFiltered.length;
      var rangeTop = _total < MicroCubit.get(context).i.length
          ? _total
          : MicroCubit.get(context).i.length;
      expanded = List.generate(rangeTop, (index) => false);
      source = _sourceFiltered.getRange(0, rangeTop).toList();
    } catch (e) {
      print(e);
    }
    setState(() => isLoading = false);
  }

  List<Map<String, dynamic>> _generateData() {
    MicroCubit.get(context).temps = [];
    for (var data in MicroCubit.get(context).i) {
      MicroCubit.get(context).temps.add({
        'itemNumber': data.itemNumber,
        'itemName': data.itemName,
        'itemPrice': data.itemPrice,
        'itemCost': data.itemCost,
        'itemFill': data.itemFill,
        'itemCount': data.itemCount,
      });
    }

    return MicroCubit.get(context).temps;
  }

  _initializeData() async {
    expanded =
        List.generate(MicroCubit.get(context).i.length, (index) => false);

    setState(() => isLoading = true);
    Future.delayed(const Duration(seconds: 1)).then((value) {
      sourceOriginal.clear();
      sourceOriginal.addAll(_generateData());
      _sourceFiltered = sourceOriginal;
      _total = _sourceFiltered.length;
      source = _sourceFiltered
          .getRange(0, MicroCubit.get(context).i.length)
          .toList();

      setState(() => isLoading = false);
    });
  }

  @override
  void initState() {
    _initializeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MicroCubit, MicroStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MicroCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text('المبيعات', style: Styles.textStyle25),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.qr_code_scanner_outlined)),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  clientSearch = !clientSearch;
                                });
                              },
                              icon:
                                  const Icon(Icons.contact_emergency_rounded)),
                          Expanded(
                              child: TextField(
                            controller: controller,
                            decoration: InputDecoration(
                              hintText: 'ادخل اسم المنتج',
                              hintStyle: Styles.textStyle14,
                              prefixIcon: IconButton(
                                  icon: const Icon(Icons.cancel),
                                  onPressed: () {
                                    _initializeData();
                                  }),
                              suffixIcon: IconButton(
                                  icon: const Icon(Icons.search),
                                  onPressed: () {}),
                            ),
                            onChanged: (value) {
                              _filterSearch(value);
                            },
                            onSubmitted: (value) {
                              _filterSearch(value);
                            },
                          )),
                          IconButton(
                              onPressed: () {
                                salesItems1 = [];
                                setState(() {});
                              },
                              icon: const Icon(Icons.monetization_on_rounded)),
                        ],
                      ),
                      if (clientSearch == true)
                        TextField(
                          controller: nameClient,
                          decoration: InputDecoration(
                              hintText: 'ادخل اسم العميل',
                              hintStyle: Styles.textStyle14,
                              prefixIcon: IconButton(
                                  icon: const Icon(Icons.cancel),
                                  onPressed: () {}),
                              suffixIcon: IconButton(
                                  icon: const Icon(Icons.search),
                                  onPressed: () {})),
                          onChanged: (value) {
                            final suggestions = cubit.c.where((e) {
                              final clientTitle = e.clientName!.toLowerCase();
                              final input = value.toLowerCase();
                              return clientTitle.contains(input);
                            }).toList();
                            setState(() {
                              clientList = suggestions;
                            });
                          },
                          onSubmitted: (value) {
                            print(clientList);
                          },
                        ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Card(
                    color: Colors.grey[500],
                    child: ListTile(
                      leading: Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: Text(
                          'المنتج',
                          style:
                              Styles.textStyle14.copyWith(color: Colors.white),
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
                                      showFlexibleBottomSheet(
                                        minHeight: 0,
                                        initHeight: 0.9,
                                        maxHeight: 0.9,
                                        context: context,
                                        builder: (context, scrollController,
                                                bottomSheetOffset) =>
                                            InfoSaleScreen(
                                          list: salesItems1,
                                          scrollController: scrollController,
                                          cubit: cubit,
                                          data: salesItems1[index],
                                          delete: () {},
                                        ),
                                        isExpand: false,
                                      );
                                    },
                                    leading: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: Text(salesItems1[index].itemName!,
                                          style: Styles.textStyle14),
                                    ),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Center(
                                            child: Text(salesItems1[index]
                                                .itemPrice
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
                                                cubit.changeCount(
                                                    index: index,
                                                    list: salesItems1);

                                                cubit.calculateTotalCount(
                                                    list: salesItems1);
                                                print(salesItems1[index]
                                                    .itemCostb);
                                                cubit.calculateTotalCost(
                                                    salesItems1: salesItems1);
                                              },
                                              onLongPress: () {
                                                setState(() {
                                                  salesItems1[index]
                                                      .itemCountb = 1;
                                                });

                                                cubit.calculateTotalCount(
                                                    list: salesItems1);
                                                cubit.calculateTotalCost(
                                                    salesItems1: salesItems1);
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    border: Border.all(),
                                                    color: salesItems1[index]
                                                                .itemCount! ==
                                                            salesItems1[index]
                                                                .itemCountb!
                                                        ? Colors.red
                                                        : null),
                                                child: Text(salesItems1[index]
                                                    .itemCountb
                                                    .toString()),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Center(
                                            child: Text(
                                                (salesItems1[index].itemFill! *
                                                        salesItems1[index]
                                                            .itemPrice! *
                                                        salesItems1[index]
                                                            .itemCountb!)
                                                    .toString()),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              itemCount: salesItems1.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 10,
                              ),
                            ),
                          ),
                          if (clientList.isNotEmpty)
                            SizedBox(
                                height: MediaQuery.sizeOf(context).height - 240,
                                child: Card(
                                  child: ListView.builder(
                                    itemCount: clientList.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        onTap: () {
                                          setState(() {
                                            nameClient.text =
                                                clientList[index].clientName!;
                                            clientList = [];
                                          });
                                          print(nameClient.text);
                                        },
                                        title: Text(
                                            '${clientList[index].clientName}'),
                                      );
                                    },
                                  ),
                                )),
                          if (controller.text.isNotEmpty)
                            Card(
                              child: SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height - 240,
                                  child: ListView.builder(
                                    itemCount: source.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        onTap: () {
                                          if (salesItems1.any((element) =>
                                              element.itemNumber ==
                                              source[index]['itemNumber'])) {
                                            cubit.changeCount(
                                                index: salesItems1.indexWhere(
                                                  (element) =>
                                                      element.itemNumber ==
                                                      source[index]
                                                          ['itemNumber'],
                                                ),
                                                list: salesItems1);
                                          } else {
                                            salesItems1.add(SaleModel.fromJson(
                                                source[index]));
                                          }

                                          setState(() {
                                            controller.clear();
                                          });
                                          cubit.calculateTotalCount(
                                              list: salesItems1);
                                          print(salesItems1[index].itemCostb);
                                          cubit.calculateTotalCost(
                                              salesItems1: salesItems1);
                                        },
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              '${_sourceFiltered[index]['itemName']}',
                                            ),
                                            Text(
                                                '(${_sourceFiltered[index]['itemCount']})'),
                                          ],
                                        ),
                                      );
                                    },
                                  )),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text('الاجمالي', style: Styles.textStyle18),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: salesItems1.isEmpty
                        ? Text('0.0')
                        : Text('${cubit.totalCost}'),
                  ),
                  Text('الكمية', style: Styles.textStyle18),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: salesItems1.isEmpty
                        ? Text('0')
                        : Text('${cubit.totalCount}'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
 Widget buildInfoColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
