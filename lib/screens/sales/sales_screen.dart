// // ignore_for_file: library_private_types_in_public_api, unused_element, avoid_print, avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

// import 'dart:math';

// import 'package:cubit_form/cubit_form.dart';
// import 'package:flutter/material.dart';
// import 'package:responsive_table/responsive_table.dart';
// import 'package:storage/resources/components.dart';
// import 'package:storage/resources/styles.dart';

// import 'package:storage/screens/home_screen/cubit/cubit.dart';
// import 'package:storage/screens/home_screen/cubit/states.dart';
// import 'package:storage/screens/home_screen/layout_screen.dart';

// import 'package:storage/screens/pdf/availble_products.dart';
// import 'package:storage/screens/pdf/barcode.dart';
// import 'package:storage/screens/pdf/file_handle_api.dart';

// // ignore: must_be_immutable
// class SalesScreen extends StatefulWidget {
//   SalesScreen({Key? key, required this.currentPerPage}) : super(key: key);
//   int currentPerPage;
//   @override
//   _SalesScreenState createState() => _SalesScreenState();
// }

// class _SalesScreenState extends State<SalesScreen> {
//   late List<DatatableHeader> _headers;
// // MicroCubit cubit;
//   int _total = 100;
//   List<bool>? _expanded;
//   String? _searchKey = "itemName";
//   bool _isSearch = false;
//   final List<Map<String, dynamic>> sourceOriginal = [];
//   List<Map<String, dynamic>> _sourceFiltered = [];
//   List<Map<String, dynamic>> _source = [];
//   List<Map<String, dynamic>> _selecteds = [];
//   // List<Map<String, dynamic>> salesItems1 = [];
//   // ignore: unused_field
//   final String _selectableKey = "itemNumber";
//   bool b = false;
//   String? _sortColumn;
//   bool _sortAscending = true;
//   bool _isLoading = true;
//   final bool _showSelect = true;
//   var random = Random();

//   List<Map<String, dynamic>> _generateData() {
//     for (var data in MicroCubit.get(context).i) {
//       MicroCubit.get(context).temps.add({
//         'itemNumber': data.itemNumber,
//         'itemName': data.itemName,
//         'itemPrice': data.itemPrice,
//         'itemCost': data.itemCost,
//         'itemFill': data.itemFill,
//         'itemCount': data.itemCount,
//       });
//     }

//     return MicroCubit.get(context).temps;
//   }

//   _initializeData() async {
//     _mockPullData();
//   }

//   _mockPullData() async {
//     _expanded =
//         List.generate(MicroCubit.get(context).i.length, (index) => false);

//     setState(() => _isLoading = true);
//     Future.delayed(const Duration(seconds: 1)).then((value) {
//       sourceOriginal.clear();
//       sourceOriginal.addAll(_generateData());
//       _sourceFiltered = sourceOriginal;
//       _total = _sourceFiltered.length;
//       _source = _sourceFiltered
//           .getRange(0, MicroCubit.get(context).i.length)
//           .toList();
//       // _source = _sourceFiltered.getRange(0, MicroCubit.get(context).items.length).toList();

//       setState(() => _isLoading = false);
//     });
//   }

//   _resetData({start = 0}) async {
//     setState(() => _isLoading = true);
//     var expandedLen = _total - start < MicroCubit.get(context).items.length
//         ? _total - start
//         : MicroCubit.get(context).items.length;
//     Future.delayed(const Duration(seconds: 0)).then((value) {
//       _expanded = List.generate(expandedLen as int, (index) => false);
//       _source.clear();
//       _source = _sourceFiltered.getRange(start, start + expandedLen).toList();
//       setState(() => _isLoading = false);
//     });
//   }

//   _filterData(value) {
//     setState(() => _isLoading = true);

//     try {
//       if (value == "" || value == null) {
//         _sourceFiltered = sourceOriginal;
//       } else {
//         _sourceFiltered = sourceOriginal
//             .where((data) => data[_searchKey!]
//                 .toString()
//                 .toLowerCase()
//                 .contains(value.toString().toLowerCase()))
//             .toList();
//       }

//       _total = _sourceFiltered.length;
//       var rangeTop = _total < MicroCubit.get(context).i.length
//           ? _total
//           : MicroCubit.get(context).i.length;
//       _expanded = List.generate(rangeTop, (index) => false);
//       _source = _sourceFiltered.getRange(0, rangeTop).toList();
//     } catch (e) {
//       print(e);
//     }
//     setState(() => _isLoading = false);
//   }

//   @override
//   void initState() {
//     super.initState();

//     /// set headers
//     _headers = [
//       DatatableHeader(
//           text: "رقم المنتج",
//           value: "itemNumber",
//           show: true,
//           sortable: true,
//           textAlign: TextAlign.center),
//       DatatableHeader(
//           text: "أسم المنتج",
//           value: "itemName",
//           show: true,
//           flex: 2,
//           sortable: true,
//           textAlign: TextAlign.center),
//       DatatableHeader(
//           text: "الكمية",
//           value: "itemCount",
//           show: true,
//           flex: 1,
//           sortable: true,
//           textAlign: TextAlign.center),
//       if (b == true)
//         DatatableHeader(
//             text: "السعر",
//             value: "itemPrice",
//             show: true,
//             flex: 1,
//             sortable: true,
//             textAlign: TextAlign.center),
//     ];
//     MicroCubit.get(context).createDatabase();
//     MicroCubit.get(context).salesItems1 = [];
//     _initializeData();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<MicroCubit, MicroStates>(
//       listener: (context, state) {
//         if (state is GetDatabaseState) {
//           // print(MicroCubit.get(context).i.length);
//           // widget.currentPerPage = MicroCubit.get(context).i.length;
//           _initializeData();
//         }
//         if (state is DeleteDatabaseState) {
//           Navigator.of(context, rootNavigator: true).push(
//             MaterialPageRoute(
//               builder: (BuildContext context) {
//                 return SalesScreen(currentPerPage: widget.currentPerPage);
//               },
//             ),
//           );
//         }
//       },
//       builder: (context, state) {
//         var cubit = MicroCubit.get(context);
//         print(cubit.items.length);
//         return Scaffold(
//           appBar: AppBar(
//             title: Text(
//               " المخزون",
//             ),
//             actions: [
//               IconButton(
//                 onPressed: _initializeData,
//                 icon: const Icon(Icons.refresh_sharp),
//               ),
//             ],
//             leading: IconButton(
//                 onPressed: () {
//                   navigateAndFinish(context, LayoutScreen());
//                 },
//                 icon: Icon(Icons.arrow_back_ios)),
//           ),
//           // drawer: Drawer(
//           //   child: ListView(
//           //     children: [
//           //       ListTile(
//           //         leading: const Icon(Icons.home),
//           //         title: const Text("home"),
//           //         onTap: () {},
//           //       ),
//           //       ListTile(
//           //         leading: const Icon(Icons.storage),
//           //         title: const Text("data"),
//           //         onTap: () {},
//           //       )
//           //     ],
//           //   ),
//           // ),

//           body: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: CustomScrollView(
//               slivers: [
//                 SliverToBoxAdapter(
//                   child: Container(
//                     height: 300,
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: Colors.black,
//                         width: 2.0,
//                       ),
//                     ),
//                     constraints: const BoxConstraints(
//                       maxHeight: 700,
//                     ),
//                     child: Card(
//                       elevation: 1,
//                       shadowColor: Colors.black,
//                       clipBehavior: Clip.none,
//                       child: ResponsiveDatatable(
//                         hideUnderline: false,
//                         title: Row(
//                           children: [
//                             TextButton.icon(
//                               onPressed: () async {
//                                 // generate pdf file
//                                 if (_selecteds.isEmpty) {
//                                   final pdfFile =
//                                       await PdfAvailableProducts.generate(
//                                           sourceOriginal
//                                               .map((map) => map.values.toList())
//                                               .toList());
//                                   FileHandleApi.openFile(pdfFile);
//                                 } else {
//                                   final pdfFile =
//                                       await PdfAvailableProducts.generate(
//                                           _selecteds
//                                               .map((map) => map.values.toList())
//                                               .toList());
//                                   FileHandleApi.openFile(pdfFile);
//                                 }

//                                 // opening the pdf file
//                               },
//                               icon: const Icon(Icons.receipt_long_rounded),
//                               label: const Text("تقرير"),
//                             ),
//                             TextButton.icon(
//                               onPressed: () async {
//                                 // generate pdf file
//                                 if (_selecteds.isEmpty) {
//                                   final pdfFile = await PdfBarcode.generate(
//                                       sourceOriginal
//                                           .map((map) => map.values.toList())
//                                           .toList());
//                                   FileHandleApi.openFile(pdfFile);
//                                 } else {
//                                   final pdfFile = await PdfBarcode.generate(
//                                       _selecteds
//                                           .map((map) => map.values.toList())
//                                           .toList());
//                                   FileHandleApi.openFile(pdfFile);
//                                 }

//                                 // opening the pdf file
//                               },
//                               icon: const Icon(Icons.qr_code_2_outlined),
//                               label: const Text("باركود"),
//                             ),
//                           ],
//                         ),
//                         reponseScreenSizes: const [ScreenSize.sm],
//                         actions: [
//                           if (_isSearch)
//                             Expanded(
//                                 child: TextField(
//                               decoration: InputDecoration(
//                                   hintText: 'ادخل اسم المنتج',
//                                   hintStyle: Styles.textStyle14,
//                                   prefixIcon: IconButton(
//                                       icon: const Icon(Icons.cancel),
//                                       onPressed: () {
//                                         setState(() {
//                                           _isSearch = false;
//                                         });
//                                         _initializeData();
//                                       }),
//                                   suffixIcon: IconButton(
//                                       icon: const Icon(Icons.search),
//                                       onPressed: () {})),
//                               onChanged: (value) {
//                                 _filterData(value);
//                               },
//                               onSubmitted: (value) {
//                                 _filterData(value);
//                               },
//                             )),
//                           if (!_isSearch)
//                             IconButton(
//                                 icon: const Icon(Icons.search),
//                                 onPressed: () {
//                                   setState(() {
//                                     _isSearch = true;
//                                   });
//                                 })
//                         ],
//                         headers: _headers,
//                         source: _source,
//                         selecteds: _selecteds,
//                         showSelect: _showSelect,
//                         autoHeight: false,
//                         // dropContainer: (data) {
//                         //   if (int.tryParse(data['itemNumber'].toString())!
//                         //       .isEven) {
//                         //     return const Text("is Even");
//                         //   }
//                         //   return _DropDownContainer(data: data);
//                         // },
//                         onChangedRow: (value, header) {},
//                         onSubmittedRow: (value, header) {
//                           /// print(value);
//                           /// print(header);
//                         },
//                         onTabRow: (data) {
//                           print('====================================');
//                           cubit.salesItems1.add(data);
//                           print(cubit.salesItems1);
//                           print(cubit.salesItems1.length);
//                           setState(() {});
//                           print('====================================');
//                         },
//                         onSort: (value) {
//                           setState(() => _isLoading = true);

//                           setState(() {
//                             _sortColumn = value;
//                             _sortAscending = !_sortAscending;
//                             if (_sortAscending) {
//                               _sourceFiltered.sort((a, b) => b["$_sortColumn"]
//                                   .compareTo(a["$_sortColumn"]));
//                             } else {
//                               _sourceFiltered.sort((a, b) => a["$_sortColumn"]
//                                   .compareTo(b["$_sortColumn"]));
//                             }
//                             var rangeTop =
//                                 widget.currentPerPage < _sourceFiltered.length
//                                     ? widget.currentPerPage
//                                     : _sourceFiltered.length;
//                             _source =
//                                 _sourceFiltered.getRange(0, rangeTop).toList();
//                             _searchKey = value;

//                             _isLoading = false;
//                           });
//                         },
//                         expanded: _expanded,
//                         sortAscending: _sortAscending,
//                         sortColumn: _sortColumn,
//                         isLoading: _isLoading,

//                         onSelect: (value, item) {
//                           print("$value  $item ");
//                           if (value!) {
//                             setState(() => _selecteds.add(item));
//                           } else {
//                             setState(() =>
//                                 _selecteds.removeAt(_selecteds.indexOf(item)));
//                           }
//                         },
//                         onSelectAll: (value) {
//                           if (value!) {
//                             setState(() => _selecteds =
//                                 _source.map((entry) => entry).toList().cast());
//                           } else {
//                             setState(() => _selecteds.clear());
//                           }
//                         },
//                         headerDecoration: BoxDecoration(
//                             color: Colors.grey.shade600,
//                             border: Border(
//                                 bottom:
//                                     BorderSide(color: Colors.red, width: 1))),
//                         selectedDecoration: BoxDecoration(
//                           border: Border(
//                               bottom: BorderSide(
//                                   color: Colors.teal.shade800, width: 1)),
//                           color: Colors.teal.shade500,
//                         ),
//                         headerTextStyle:
//                             Styles.textStyle14.copyWith(color: Colors.white),
//                         rowTextStyle: Styles.textStyle14.copyWith(
//                             color: Theme.of(context).colorScheme.secondary),
//                         selectedTextStyle:
//                             Styles.textStyle14.copyWith(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SliverToBoxAdapter(
//                   child: ListTile(
//                     leading: Text('النتج'),
//                     title: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Text('السعر'),
//                         Text('الكميه'),
//                         Text("الاجمالي"),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SliverList.separated(
//                   itemBuilder: (context, index) => ListTile(
//                     leading: Text(cubit.salesItems1[index]['itemName']),
//                     title: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Text(cubit.salesItems1[index]['itemPrice'].toString()),
//                         Container(
//                           width: 30,
//                           child: TextFormField(
//                             initialValue: cubit.salesItems1[index]
//                                 ['itemCountb'] = 1.toString(),
//                             keyboardType: TextInputType.number,
//                             onChanged: (value) {
//                               setState(() {
//                                 cubit.salesItems1[index]['itemCountb'] =
//                                     int.parse(value);
//                               });
//                             },
//                           ),
//                         ),
//                         Text((cubit.salesItems1[index]['itemPrice'] *
//                                 cubit.salesItems1[index]['itemPrice'])
//                             .toString()),
//                       ],
//                     ),
//                   ),
//                   itemCount: cubit.salesItems1.length,
//                   separatorBuilder: (context, index) => SizedBox(
//                     height: 10,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class _DropDownContainer extends StatelessWidget {
//   final Map<String, dynamic> data;
//   const _DropDownContainer({Key? key, required this.data}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     List<Widget> children = data.entries.map<Widget>((entry) {
//       Widget w = Row(
//         children: [
//           Text(entry.key.toString()),
//           const Spacer(),
//           Text(entry.value.toString()),
//         ],
//       );
//       return w;
//     }).toList();

//     return Container(
//       /// height: 100,
//       child: Column(
//         /// children: [
//         ///   Expanded(
//         ///       child: Container(
//         ///     color: Colors.red,
//         ///     height: 50,
//         ///   )),
//         /// ],
//         children: children,
//       ),
//     );
//   }
// }
