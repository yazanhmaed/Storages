import 'dart:math';
import 'package:flutter/material.dart';
import 'package:responsive_table/responsive_table.dart';
import 'package:storage/screens/pdf/availble_products.dart';
import 'package:storage/screens/pdf/barcode.dart';
import 'package:storage/screens/pdf/file_handle_api.dart';
import 'package:storage/screens/storage_screen/test.dart';

class DataPage extends StatefulWidget {
  const DataPage({Key? key}) : super(key: key);
  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  late List<DatatableHeader> _headers;

  int _total = 100;
  final int _currentPerPage = 10;
  List<bool>? _expanded;
  String? _searchKey = "itemName";

  bool _isSearch = false;
  final List<Map<String, dynamic>> sourceOriginal = [];
  List<Map<String, dynamic>> _sourceFiltered = [];
  List<Map<String, dynamic>> _source = [];
  List<Map<String, dynamic>> _selecteds = [];
  // ignore: unused_field
  final String _selectableKey = "itemNumber";

  String? _sortColumn;
  bool _sortAscending = true;
  bool _isLoading = true;
  final bool _showSelect = true;
  var random = Random();

  List<Map<String, dynamic>> _generateData() {
    List<Map<String, dynamic>> temps = [];

    for (var data in item) {
      temps.add({
        'itemNumber': data['itemNumber'],
        'itemName': data['itemName'],
        'itemPrice': data['itemPrice'],
        'itemCost': data['itemCost'],
        'itemFill': data['itemFill'],
        'itemCount': data['itemCount'],
      });
      // i++;
    }
    return temps;
  }

  _initializeData() async {
    _mockPullData();
  }

  _mockPullData() async {
    _expanded = List.generate(item.length, (index) => false);

    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 3)).then((value) {
      sourceOriginal.clear();
      sourceOriginal.addAll(_generateData());
      _sourceFiltered = sourceOriginal;
      _total = _sourceFiltered.length;
      _source = _sourceFiltered.getRange(0, item.length).toList();
      setState(() => _isLoading = false);
    });
  }

  _resetData({start = 0}) async {
    setState(() => _isLoading = true);
    var expandedLen =
        _total - start < item.length ? _total - start : item.length;
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
      var rangeTop = _total < _currentPerPage ? _total : _currentPerPage;
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
          text: "ID",
          value: "itemNumber",
          show: true,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Name",
          value: "itemName",
          show: true,
          flex: 2,
          sortable: true,
          editable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Count",
          value: "itemCount",
          show: true,
          flex: 1,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Price",
          value: "itemPrice",
          show: true,
          flex: 1,
          sortable: true,
          textAlign: TextAlign.center),
    ];

    _initializeData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("RESPONSIVE DATA TABLE"),
        actions: [
          IconButton(
            onPressed: _initializeData,
            icon: const Icon(Icons.refresh_sharp),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("home"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.storage),
              title: const Text("data"),
              onTap: () {},
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(0),
              constraints: const BoxConstraints(
                maxHeight: 700,
              ),
              child: Card(
                elevation: 1,
                shadowColor: Colors.black,
                clipBehavior: Clip.none,
                child: ResponsiveDatatable(
                  title: TextButton.icon(
                    onPressed: () async {
                      // generate pdf file
                      if (_selecteds.isEmpty) {
                        final pdfFile = await PdfAvailableProducts.generate(
                            sourceOriginal
                                .map((map) => map.values.toList())
                                .toList());
                        FileHandleApi.openFile(pdfFile);
                      } else {
                        final pdfFile = await PdfAvailableProducts.generate(
                            _selecteds
                                .map((map) => map.values.toList())
                                .toList());
                        FileHandleApi.openFile(pdfFile);
                      }

                      // opening the pdf file
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("new item"),
                  ),
                  reponseScreenSizes: const [ScreenSize.sm],
                  actions: [
                    if (_isSearch)
                      Expanded(
                          child: TextField(
                        decoration: InputDecoration(
                            hintText:
                                'Enter search term based on ${_searchKey!.replaceAll(RegExp('[\\W_]+'), ' ').toUpperCase()}',
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
                  dropContainer: (data) {
                    if (int.tryParse(data['itemNumber'].toString())!.isEven) {
                      return const Text("is Even");
                    }
                    return _DropDownContainer(data: data);
                  },
                  onChangedRow: (value, header) {
                    /// print(value);
                    /// print(header);
                  },
                  onSubmittedRow: (value, header) {
                    /// print(value);
                    /// print(header);
                  },
                  onTabRow: (data) {
                    print(data);
                  },
                  onSort: (value) {
                    setState(() => _isLoading = true);

                    setState(() {
                      _sortColumn = value;
                      _sortAscending = !_sortAscending;
                      if (_sortAscending) {
                        _sourceFiltered.sort((a, b) =>
                            b["$_sortColumn"].compareTo(a["$_sortColumn"]));
                      } else {
                        _sourceFiltered.sort((a, b) =>
                            a["$_sortColumn"].compareTo(b["$_sortColumn"]));
                      }
                      var rangeTop = _currentPerPage < _sourceFiltered.length
                          ? _currentPerPage
                          : _sourceFiltered.length;
                      _source = _sourceFiltered.getRange(0, rangeTop).toList();
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
                      setState(
                          () => _selecteds.removeAt(_selecteds.indexOf(item)));
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
                  headerDecoration: const BoxDecoration(
                      color: Colors.grey,
                      border: Border(
                          bottom: BorderSide(color: Colors.red, width: 1))),
                  selectedDecoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Colors.green[300]!, width: 1)),
                    color: Colors.green,
                  ),
                  headerTextStyle: const TextStyle(color: Colors.white),
                  rowTextStyle: const TextStyle(color: Colors.green),
                  selectedTextStyle: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ])),
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
