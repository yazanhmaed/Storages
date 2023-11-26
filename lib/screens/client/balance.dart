// ignore_for_file: library_private_types_in_public_api, unused_element, avoid_print, avoid_unnecessary_containers, prefer_const_constructors

import 'dart:math';
import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:responsive_table/responsive_table.dart';
import 'package:storage/model/client_model.dart';
import 'package:storage/resources/components.dart';
import 'package:storage/resources/styles.dart';
import 'package:storage/resources/widgets/custom_text_field.dart';
import 'package:storage/screens/client/client_screen.dart';
import 'package:storage/screens/home_screen/cubit/cubit.dart';
import 'package:storage/screens/home_screen/cubit/states.dart';
import 'package:storage/screens/pdf/availble_products.dart';
import 'package:storage/screens/pdf/barcode.dart';
import 'package:storage/screens/pdf/file_handle_api.dart';

// ignore: must_be_immutable
class BalanceScreen extends StatefulWidget {
  BalanceScreen({Key? key, required this.currentPerPage}) : super(key: key);
  int currentPerPage;
  @override
  _BalanceScreenState createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  late List<DatatableHeader> _headers;
  final TextEditingController forHim = TextEditingController();
  final TextEditingController onHim = TextEditingController();
  int _total = 100;
  List<bool>? _expanded;
  String? _searchKey = "clientName";
  bool _isSearch = false;
  final List<Map<String, dynamic>> sourceOriginal = [];
  List<Map<String, dynamic>> _sourceFiltered = [];
  List<Map<String, dynamic>> _source = [];
  List<Map<String, dynamic>> _selecteds = [];
  // ignore: unused_field
  final String _selectableKey = "clienNumber";
  bool b = false;

  String? _sortColumn;
  bool _sortAscending = true;
  bool _isLoading = true;
  final bool _showSelect = true;
  var random = Random();

  List<Map<String, dynamic>> _generateData() {
    for (var data in MicroCubit.get(context).c) {
      MicroCubit.get(context).cleints.add({
        'clientName': data.clientName,
        'clientNote': data.clientNote,
        'clientPhone': data.clientPhone,
        'clientId': data.clientId,
        'onHim': data.onHim,
        'forHim': data.forHim,
      });
    }

    return MicroCubit.get(context).cleints;
  }

  _initializeData() async {
    _mockPullData();
  }

  _mockPullData() async {
    _expanded =
        List.generate(MicroCubit.get(context).c.length, (index) => false);

    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 1)).then((value) {
      sourceOriginal.clear();
      sourceOriginal.addAll(_generateData());
      _sourceFiltered = sourceOriginal;
      _total = _sourceFiltered.length;
      _source = _sourceFiltered
          .getRange(0, MicroCubit.get(context).c.length)
          .toList();
      // _source = _sourceFiltered.getRange(0, MicroCubit.get(context).cl.length).toList();

      setState(() => _isLoading = false);
    });
  }

  _resetData({start = 0}) async {
    setState(() => _isLoading = true);
    var expandedLen = _total - start < MicroCubit.get(context).cl.length
        ? _total - start
        : MicroCubit.get(context).cl.length;
    Future.delayed(const Duration(seconds: 0)).then((value) {
      _expanded = List.generate(expandedLen as int, (index) => false);
      _source.clear();
      _source = _sourceFiltered.getRange(start, start + expandedLen).toList();
      setState(() => _isLoading = false);
    });
  }

  _filterData(value) {
    setState(() => _isLoading = true);

    try {
      if (value == "" || value == null) {
        _sourceFiltered = sourceOriginal;
      } else {
        _sourceFiltered = sourceOriginal
            .where((data) => data[_searchKey!]
                .toString()
                .toLowerCase()
                .contains(value.toString().toLowerCase()))
            .toList();
      }

      _total = _sourceFiltered.length;
      var rangeTop = _total < MicroCubit.get(context).c.length
          ? _total
          : MicroCubit.get(context).c.length;
      _expanded = List.generate(rangeTop, (index) => false);
      _source = _sourceFiltered.getRange(0, rangeTop).toList();
    } catch (e) {
      print(e);
    }
    setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();

    /// set headers
    _headers = [
      DatatableHeader(
          text: "أسم العميل",
          value: "clientName",
          show: true,
          flex: 2,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "له",
          value: "forHim",
          show: true,
          flex: 1,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "عليه",
          value: "onHim",
          show: true,
          flex: 1,
          sortable: true,
          textAlign: TextAlign.center),
      if (b == true)
        DatatableHeader(
            text: "السعر",
            value: "cliantName",
            show: true,
            flex: 1,
            sortable: true,
            textAlign: TextAlign.center),
    ];
    MicroCubit.get(context).createDatabase();

    _initializeData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MicroCubit, MicroStates>(
      listener: (context, state) {
        if (state is GetDatabaseState) {
          // print(MicroCubit.get(context).i.length);
          // widget.currentPerPage = MicroCubit.get(context).i.length;
          _initializeData();
        }
        if (state is DeleteDatabaseState) {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return BalanceScreen(currentPerPage: widget.currentPerPage);
              },
            ),
          );
        }
      },
      builder: (context, state) {
        var cubit = MicroCubit.get(context);
        print(cubit.items.length);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "الارصدة الافتتاحيه للعملاء",
              style: Styles.textStyle25.copyWith(color: Colors.white),
            ),
            actions: [
              IconButton(
                onPressed: _initializeData,
                icon: const Icon(Icons.refresh_sharp),
              ),
            ],
            leading: IconButton(
                onPressed: () {
                  navigateAndFinish(context, ClientScreen());
                },
                icon: Icon(Icons.arrow_back_ios)),
          ),
          // drawer: Drawer(
          //   child: ListView(
          //     children: [
          //       ListTile(
          //         leading: const Icon(Icons.home),
          //         title: const Text("home"),
          //         onTap: () {},
          //       ),
          //       ListTile(
          //         leading: const Icon(Icons.storage),
          //         title: const Text("data"),
          //         onTap: () {},
          //       )
          //     ],
          //   ),
          // ),

          body: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    constraints: const BoxConstraints(
                      maxHeight: 700,
                    ),
                    child: Card(
                      elevation: 1,
                      shadowColor: Colors.black,
                      clipBehavior: Clip.none,
                      child: ResponsiveDatatable(
                        hideUnderline: false,
                        title: Row(
                          children: [
                            TextButton.icon(
                              onPressed: () async {
                                // generate pdf file
                                if (_selecteds.isEmpty) {
                                  final pdfFile =
                                      await PdfAvailableProducts.generate(
                                          sourceOriginal
                                              .map((map) => map.values.toList())
                                              .toList());
                                  FileHandleApi.openFile(pdfFile);
                                } else {
                                  final pdfFile =
                                      await PdfAvailableProducts.generate(
                                          _selecteds
                                              .map((map) => map.values.toList())
                                              .toList());
                                  FileHandleApi.openFile(pdfFile);
                                }

                                // opening the pdf file
                              },
                              icon: const Icon(Icons.receipt_long_rounded),
                              label: const Text("تقرير"),
                            ),
                            TextButton.icon(
                              onPressed: () async {
                                // generate pdf file
                                if (_selecteds.isEmpty) {
                                  final pdfFile = await PdfBarcode.generate(
                                      sourceOriginal
                                          .map((map) => map.values.toList())
                                          .toList());
                                  FileHandleApi.openFile(pdfFile);
                                } else {
                                  final pdfFile = await PdfBarcode.generate(
                                      _selecteds
                                          .map((map) => map.values.toList())
                                          .toList());
                                  FileHandleApi.openFile(pdfFile);
                                }

                                // opening the pdf file
                              },
                              icon: const Icon(Icons.qr_code_2_outlined),
                              label: const Text("باركود"),
                            ),
                          ],
                        ),
                        reponseScreenSizes: const [ScreenSize.sm],
                        actions: [
                          if (_isSearch)
                            Expanded(
                                child: TextField(
                              decoration: InputDecoration(
                                  hintText: 'ادخل اسم المنتج',
                                  hintStyle: Styles.textStyle14,
                                  prefixIcon: IconButton(
                                      icon: const Icon(Icons.cancel),
                                      onPressed: () {
                                        setState(() {
                                          _isSearch = false;
                                        });
                                        _initializeData();
                                      }),
                                  suffixIcon: IconButton(
                                      icon: const Icon(Icons.search),
                                      onPressed: () {})),
                              onChanged: (value) {
                                _filterData(value);
                              },
                              onSubmitted: (value) {
                                _filterData(value);
                              },
                            )),
                          if (!_isSearch)
                            IconButton(
                                icon: const Icon(Icons.search),
                                onPressed: () {
                                  setState(() {
                                    _isSearch = true;
                                  });
                                })
                        ],
                        headers: _headers,
                        source: _source,
                        selecteds: _selecteds,
                        showSelect: _showSelect,
                        autoHeight: false,
                        // dropContainer: (data) {
                        //   if (int.tryParse(data['itemNumber'].toString())!
                        //       .isEven) {
                        //     return const Text("is Even");
                        //   }
                        //   return _DropDownContainer(data: data);
                        // },
                        onChangedRow: (value, header) {},
                        onSubmittedRow: (value, header) {
                          /// print(value);
                          /// print(header);
                        },
                        onTabRow: (data) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('الرصيد الافتتاحي للعميل'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      BlocBuilder<MicroCubit, MicroStates>(
                                        builder: (context, state) {
                                          return Card(
                                            child: Column(
                                              children: [
                                                Text(
                                                    'اسم العميل: ${data["clientName"]}'),
                                                Row(
                                                  children: [
                                                    Text('له'),
                                                    Radio(
                                                      value: true,
                                                      groupValue:
                                                          cubit.isForHim,
                                                      onChanged: (value) {
                                                        cubit.getHim(
                                                            isFor: true);
                                                      },
                                                    ),
                                                    Text('عليه'),
                                                    Radio(
                                                      value: false,
                                                      groupValue:
                                                          cubit.isForHim,
                                                      onChanged: (value) {
                                                        cubit.getHim(
                                                            isFor: false);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                CustomTextField(
                                                  label: cubit.isForHim
                                                      ? 'له'
                                                      : 'عليه',
                                                  controller: cubit.isForHim
                                                      ? forHim
                                                      : onHim,
                                                  // controller:
                                                  //     TextEditingController(
                                                  //   text: cubit.isForHim
                                                  //       ? data['clientForHim']
                                                  //           .toString()
                                                  //       : data['clientOnHim']
                                                  //           .toString(),
                                                  // ),
                                                  keyboardType:
                                                      TextInputType.text,
                                                  validate: (value) {
                                                    if (cubit.isForHim) {
                                                      data['forHim'] = value;
                                                    } else {
                                                      data['onHim'] = value;
                                                    }
                                                    return null;
                                                  },
                                                ),
                                                TextField(),
                                              ],
                                            ),
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        cubit.updateClient(
                                          clients: ClientModel(
                                            clientId: data['clientId'],
                                            forHim: cubit.isForHim
                                                ? double.tryParse(forHim.text)
                                                : double.tryParse(
                                                    data['forHim'].toString()),
                                            onHim: cubit.isForHim
                                                ? double.tryParse(
                                                    data['onHim'].toString())
                                                :  double.tryParse(onHim.text),
                                            clientName: data['clientName'],
                                            clientNote: data['clientNote'],
                                            clientPhone: data['clientPhone'],
                                          ),
                                        );
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('حفظ'),
                                    ),
                                  ],
                                );
                              });
                        },
                        onSort: (value) {
                          setState(() => _isLoading = true);

                          setState(() {
                            _sortColumn = value;
                            _sortAscending = !_sortAscending;
                            if (_sortAscending) {
                              _sourceFiltered.sort((a, b) => b["$_sortColumn"]
                                  .compareTo(a["$_sortColumn"]));
                            } else {
                              _sourceFiltered.sort((a, b) => a["$_sortColumn"]
                                  .compareTo(b["$_sortColumn"]));
                            }
                            var rangeTop =
                                widget.currentPerPage < _sourceFiltered.length
                                    ? widget.currentPerPage
                                    : _sourceFiltered.length;
                            _source =
                                _sourceFiltered.getRange(0, rangeTop).toList();
                            _searchKey = value;

                            _isLoading = false;
                          });
                        },
                        expanded: _expanded,
                        sortAscending: _sortAscending,
                        sortColumn: _sortColumn,
                        isLoading: _isLoading,

                        onSelect: (value, item) {
                          print("$value  $item ");
                          if (value!) {
                            setState(() => _selecteds.add(item));
                          } else {
                            setState(() =>
                                _selecteds.removeAt(_selecteds.indexOf(item)));
                          }
                        },
                        onSelectAll: (value) {
                          if (value!) {
                            setState(() => _selecteds =
                                _source.map((entry) => entry).toList().cast());
                          } else {
                            setState(() => _selecteds.clear());
                          }
                        },
                        headerDecoration: BoxDecoration(
                            color: Colors.grey.shade600,
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.red, width: 1))),
                        selectedDecoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.teal.shade800, width: 1)),
                          color: Colors.teal.shade500,
                        ),
                        headerTextStyle:
                            Styles.textStyle14.copyWith(color: Colors.white),
                        rowTextStyle: Styles.textStyle14.copyWith(
                            color: Theme.of(context).colorScheme.secondary),
                        selectedTextStyle:
                            Styles.textStyle14.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ]),
          )),
        );
      },
    );
  }
}

class _DropDownContainer extends StatelessWidget {
  final Map<String, dynamic> data;
  const _DropDownContainer({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = data.entries.map<Widget>((entry) {
      Widget w = Row(
        children: [
          Text(entry.key.toString()),
          const Spacer(),
          Text(entry.value.toString()),
        ],
      );
      return w;
    }).toList();

    return Container(
      /// height: 100,
      child: Column(
        /// children: [
        ///   Expanded(
        ///       child: Container(
        ///     color: Colors.red,
        ///     height: 50,
        ///   )),
        /// ],
        children: children,
      ),
    );
  }
}
