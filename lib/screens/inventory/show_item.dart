// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:storage/model/search_model.dart';
import 'package:storage/resources/styles.dart';

class ShowItem extends StatefulWidget {
  const ShowItem({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ShowItemState createState() => _ShowItemState();
}

class _ShowItemState extends State<ShowItem> {
  List listToSearch = [
    {'name': 'Amir', 'class': 12, 'price': 30, 'quantity': 3},
    {'name': 'Raza', 'class': 11, 'price': 40, 'quantity': 5},
    {'name': 'A', 'class': 12, 'price': 30, 'quantity': 3},
    {'name': 'b', 'class': 11, 'price': 40, 'quantity': 5},
    {'name': 'c', 'class': 12, 'price': 30, 'quantity': 3},
    {'name': 'd', 'class': 11, 'price': 40, 'quantity': 5},
  ];

  List filteredList = [];

  var selected;
  late List selectedList;
  static List<SearchModel> item = [
    SearchModel(11, 'f', 22),
    SearchModel(11, 'bb', 22),
    SearchModel(11, 'aa', 22),
    SearchModel(11, 'cc', 22),
    SearchModel(11, 'dd', 22),
  ];
  List<SearchModel> displayList = List.from(item);
  void updateList(String value) {
    setState(() {
      displayList = item
          .where((element) =>
              element.displayList.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'المنتجات المتوفرة في المحزن',
          style: Styles.textStyle18,
        ),
      ),
      body: Container(),
      // Padding(
      //   padding: const EdgeInsets.all(16),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       const Text(
      //         'البحث',
      //         style: Styles.textStyle14,
      //       ),
      //       const SizedBox(height: 20.0),
      //       TextField(
      //         onChanged: (value) => updateList(value),
      //         decoration: InputDecoration(
      //           filled: true,
      //           border: OutlineInputBorder(
      //             borderSide: BorderSide.none,
      //             borderRadius: BorderRadius.circular(8),
      //           ),
      //           hintText: 'بحث',
      //           prefixIcon: const Icon(Icons.search),
      //         ),
      //       ),
      //       const SizedBox(
      //         height: 20.0,
      //       ),
      //       Expanded(
      //         child: ListView.builder(
      //           itemBuilder: (context, index) => Row(
      //             children: [
      //               Text(
      //                 '${displayList[index].name}',
      //                 style: Styles.textStyle14,
      //               ),
      //               const Spacer(),
      //               Expanded(
      //                 flex: 2,
      //                 child: Row(
      //                   children: [
      //                     Container(
      //                       padding: const EdgeInsets.all(10),
      //                       decoration: BoxDecoration(
      //                         borderRadius: BorderRadius.circular(10),
      //                         color:
      //                             Theme.of(context).colorScheme.inversePrimary,
      //                       ),
      //                       child: Text(
      //                         '${displayList[index].sale}',
      //                         style: Styles.textStyle14,
      //                       ),
      //                     ),
      //                     const Spacer(),
      //                     Container(
      //                       padding: const EdgeInsets.all(10),
      //                       decoration: BoxDecoration(
      //                         borderRadius: BorderRadius.circular(10),
      //                         color:
      //                             Theme.of(context).colorScheme.inversePrimary,
      //                       ),
      //                       child: Text(
      //                         '${displayList[index].buying}',
      //                         style: Styles.textStyle14,
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ],
      //           ),
      //           itemCount: displayList.length,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      //     Center(
      //   child: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: ListView(
      //       children: <Widget>[
      //         Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: CustomSearchableDropDown(
      //             dropdownHintText: 'البحث عن اسم المنتج هنا...',
      //             showLabelInMenu: true,
      //             dropdownItemStyle: const TextStyle(color: Colors.red),
      //             primaryColor: Colors.red,
      //             menuMode: true,
      //             labelStyle: const TextStyle(
      //                 color: Colors.red, fontWeight: FontWeight.bold),
      //             items: listToSearch,
      //             label: 'Select Name',
      //             prefixIcon: const Icon(Icons.search),
      //             dropDownMenuItems: listToSearch.map((item) {
      //               return item['name'];
      //             }).toList(),
      //             onChanged: (value) {
      //               setState(() {
      //                 filteredList = value != null
      //                     ? listToSearch
      //                         .where((item) =>
      //                             item['name'].toString() == value['name'])
      //                         .toList()
      //                     : filteredList = List.from(listToSearch);
      //               });
      //             },
      //           ),
      //         ),
      //         const SizedBox(
      //           height: 20,
      //         ),
      //         const Row(
      //           children: [
      //             Text(
      //               "المنتج",
      //               style: Styles.textStyle14,
      //             ),
      //             Spacer(),
      //             Expanded(
      //               flex: 2,
      //               child: Row(
      //                 children: [
      //                   Text(
      //                     'السعر',
      //                     style: Styles.textStyle14,
      //                   ),
      //                   Spacer(),
      //                   Text(
      //                     'الكمية',
      //                     style: Styles.textStyle14,
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ],
      //         ),
      //         for (var item in filteredList)
      //           Row(
      //             children: [
      //               Text(
      //                 item['name'].toString(),
      //                 style: Styles.textStyle14,
      //               ),
      //               const Spacer(),
      //               Expanded(
      //                 flex: 2,
      //                 child: Row(
      //                   children: [
      //                     Container(
      //                       padding: const EdgeInsets.all(10),
      //                       decoration: BoxDecoration(
      //                         borderRadius: BorderRadius.circular(10),
      //                         color:
      //                             Theme.of(context).colorScheme.inversePrimary,
      //                       ),
      //                       child: Text(
      //                         item['price'].toString(),
      //                         style: Styles.textStyle14,
      //                       ),
      //                     ),
      //                     const Spacer(),
      //                     Container(
      //                       padding: const EdgeInsets.all(10),
      //                       decoration: BoxDecoration(
      //                         borderRadius: BorderRadius.circular(10),
      //                         color:
      //                             Theme.of(context).colorScheme.inversePrimary,
      //                       ),
      //                       child: Text(
      //                         item['quantity'].toString(),
      //                         style: Styles.textStyle14,
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ],
      //           ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
