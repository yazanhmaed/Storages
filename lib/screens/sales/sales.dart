import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:storage/resources/styles.dart';
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

  _filterData(value) {
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
          appBar: AppBar(),
          body: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.qr_code_scanner_outlined)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.contact_emergency_rounded)),
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
                            icon: const Icon(Icons.search), onPressed: () {})),
                    onChanged: (value) {
                      _filterData(value);
                    },
                    onSubmitted: (value) {
                      _filterData(value);
                    },
                  )),
                  IconButton(
                      onPressed: () {
                        cubit.salesItems1 = [];
                        setState(() {});
                      },
                      icon: const Icon(Icons.monetization_on_rounded)),
                ],
              ),
              const ListTile(
                leading: Text('النتج'),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('السعر'),
                    Text('التعبئة'),
                    Text('الكميه'),
                    Text("الاجمالي"),
                  ],
                ),
              ),
              Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height - 200,
                    child: ListView.separated(
                      itemBuilder: (context, index) => ListTile(
                        leading: Text(cubit.salesItems1[index]['itemName']),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(cubit.salesItems1[index]['itemPrice']
                                .toString()),
                            Text(cubit.salesItems1[index]['itemFill']
                                .toString()),
                            GestureDetector(
                              onTap: () {
                                // هون بنخليه يزود الكمية بس يضغط
                              },
                              onLongPress: () {
                                //بس يضغط كبسة طويلة برجع القيمة واحد
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(border: Border.all()),
                                child: Text(cubit.salesItems1[index]
                                        ['itemCountb']
                                    .toString()),
                              ),
                            ),
                            Text((cubit.salesItems1[index]['itemPrice'] *
                                    cubit.salesItems1[index]['itemFill'])
                                .toString()),
                          ],
                        ),
                      ),
                      itemCount: cubit.salesItems1.length,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                    ),
                  ),
                  if (controller.text.isNotEmpty)
                    SizedBox(
                        height: MediaQuery.sizeOf(context).height - 200,
                        child: ListView.builder(
                          itemCount: source.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                cubit.salesItems1.add(source[index]);
                                setState(() {
                                  controller.clear();
                                });
                              },
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text('${_sourceFiltered[index]['itemName']}'),
                                  Text(
                                      '(${_sourceFiltered[index]['itemCount']})'),
                                ],
                              ),
                            );
                          },
                        )),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
