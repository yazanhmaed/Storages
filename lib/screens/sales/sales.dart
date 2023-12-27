// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:storage/model/invocie_model.dart';
import 'package:storage/model/sale_model.dart';
import 'package:storage/resources/app_images.dart';

import 'package:storage/resources/styles.dart';
import 'package:storage/resources/widgets/appbar.dart';
import 'package:storage/resources/widgets/bottom_nav.dart';
import 'package:storage/resources/widgets/bottom_sheet_sale.dart';
import 'package:storage/resources/widgets/hedar_card.dart';
import 'package:storage/resources/widgets/on_will_pop.dart';
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

  TextEditingController controller = TextEditingController();

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
      listener: (context, state) {
        if (state is InsertDatabaseState) {
          for (var i = 0; i < salesItems1.length; i++) {
            print('');

            MicroCubit.get(context).selesCount(
              count: salesItems1[i].itemCount! - salesItems1[i].itemCountb!,
              number: salesItems1[i].itemNumber!,
            );
            print(
                '000000000${salesItems1[i].itemCount! - salesItems1[i].itemCountb!}');
            print(salesItems1[i].itemCount!);
          }

          salesItems1 = [];
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              dismissDirection: DismissDirection.down,
              content: Icon(Icons.attach_money, color: Colors.white),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
      builder: (context, state) {
        var cubit = MicroCubit.get(context);

        return WillPopScope(
          onWillPop: () => onWillPop(context),
          child: Scaffold(
            appBar: buildAppBar(title: 'المبيعات', image: AppImages.sales),
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
                                icon: const Icon(
                                  Icons.qr_code_scanner_outlined,
                                  color: Colors.black,
                                )),
                            IconButton(
                                onPressed: () {
                                  cubit.changeSearch();
                                },
                                icon: Icon(
                                  Icons.contact_emergency_rounded,
                                  color: Colors.black.withOpacity(0.6),
                                )),
                            Expanded(
                                child: TextField(
                              controller: controller,
                              decoration: InputDecoration(
                                hintText: 'ادخل اسم المنتج',
                                hintStyle: Styles.textStyle14,
                                prefixIcon: IconButton(
                                    icon:
                                        Icon(Icons.cancel, color: Colors.black),
                                    onPressed: () {
                                      _initializeData();
                                    }),
                                suffixIcon: IconButton(
                                    icon: const Icon(Icons.search),
                                    color: Colors.black,
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
                                  for (var i = 0; i < salesItems1.length; i++) {
                                    cubit.insertCustomer(
                                        inVocieModel: InVocieModel(
                                            id: (cubit
                                                    .invoiceClientList.length) +
                                                1,
                                            itemNumber:
                                                salesItems1[i].itemNumber,
                                            itemName: salesItems1[i].itemName,
                                            itemPrice: salesItems1[i].itemPrice,
                                            itemCost: salesItems1[i].itemCost,
                                            itemCount:
                                                salesItems1[i].itemCountb,
                                            itemFill: salesItems1[i].itemFill,
                                            customerId: cubit.cliId));
                                  }
                                  cubit.clientSearch = false;
                                  cubit.nameClientText.clear();
                                },
                                icon: const Icon(
                                  Icons.monetization_on_rounded,
                                  color: Colors.amber,
                                )),
                          ],
                        ),
                        if (cubit.clientSearch == true)
                          TextField(
                            controller: cubit.nameClientText,
                            decoration: InputDecoration(
                              hintText: 'ادخل اسم العميل',
                              hintStyle: Styles.textStyle14,
                              prefixIcon: IconButton(
                                icon: const Icon(
                                  Icons.cancel,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  cubit.nameClientText.clear();
                                  cubit.clientList.clear();
                                },
                              ),
                              suffixIcon: IconButton(
                                icon: const Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),
                                onPressed: () {},
                              ),
                            ),
                            onChanged: (value) {
                              cubit.searchClient(value);
                            },
                          ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(child: HedarCard()),
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
                                      leading: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        child: Text(
                                            salesItems1[index].itemName!,
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

                                                  // print(salesItems1[index]
                                                  //     .itemCount);

                                                  cubit.calculateTotalCost(
                                                      salesItems1: salesItems1);
                                                },
                                                onLongPress: () {
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
                                              child: Text((salesItems1[index]
                                                          .itemFill! *
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
                            if (cubit.clientList.isNotEmpty)
                              SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height - 240,
                                  child: Card(
                                    child: ListView.builder(
                                      itemCount: cubit.clientList.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          onTap: () {
                                            cubit.nameClient(index);
                                          },
                                          title: Text(
                                              '${cubit.clientList[index].clientName}'),
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
                                              salesItems1.add(
                                                  SaleModel.fromJson(
                                                      source[index]));
                                            }

                                            controller.clear();

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
            bottomNavigationBar:
                BuildBottomNav(salesItems1: salesItems1, cubit: cubit),
          ),
        );
      },
    );
  }
}
