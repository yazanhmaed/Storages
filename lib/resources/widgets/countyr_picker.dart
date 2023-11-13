// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:quran/modules/home_screen/controller/cubit.dart';
// import 'package:quran/resources/color_manager.dart';

// class CountryStateCityPicker extends StatefulWidget {
//   final TextEditingController country;
//   final TextEditingController state;

//   final InputDecoration? textFieldDecoration;
//   final Color? dialogColor;
//   final HomeCubit cubit;
//   const CountryStateCityPicker(
//       {super.key,
//       required this.country,
//       required this.state,
//       this.textFieldDecoration,
//       this.dialogColor,
//       required this.cubit});

//   @override
//   State<CountryStateCityPicker> createState() => _CountryStateCityPickerState();
// }

// class _CountryStateCityPickerState extends State<CountryStateCityPicker> {
//   List<CountryModel> _countryListAr = [];
//   List<CountryModel> _countryListEn = [];
//   final List<StateModel> _stateListEn = [];
//   final List<StateModel> _stateListAr = [];

//   List<CountryModel> _countrySubListAr = [];
//   List<CountryModel> _countrySubListEn = [];
//   List<StateModel> _stateSubListEn = [];
//   List<StateModel> _stateSubListAr = [];

//   String _title = '';

//   @override
//   void initState() {
//     _getCountry();
//     super.initState();
//   }

//   Future<void> _getCountry() async {
//     _countryListAr.clear();
//     _countryListEn.clear();
//     var jsonStringEn =
//         await rootBundle.loadString('assets/json/country_en.json');
//     List<dynamic> bodyEn = json.decode(jsonStringEn);
//     setState(() {
//       _countryListEn =
//           bodyEn.map((dynamic item) => CountryModel.fromJson(item)).toList();
//       _countrySubListEn = _countryListEn;
//     });
//     var jsonStringAr =
//         await rootBundle.loadString('assets/json/country_ar.json');
//     List<dynamic> bodyAr = json.decode(jsonStringAr);
//     setState(() {
//       _countryListAr =
//           bodyAr.map((dynamic item) => CountryModel.fromJson(item)).toList();
//       _countrySubListAr = _countryListAr;
//     });
//   }

//   Future<void> _getState(String countryId) async {
//     _stateListEn.clear();
//     _stateListAr.clear();

//     List<StateModel> subStateListEn = [];
//     List<StateModel> subStateListAr = [];
//     var jsonString = await rootBundle.loadString('assets/json/state_ar.json');
//     List<dynamic> body = json.decode(jsonString);

//     subStateListAr =
//         body.map((dynamic item) => StateModel.fromJson(item)).toList();
//     for (var element in subStateListAr) {
//       if (element.countryId == countryId) {
//         setState(() {
//           _stateListAr.add(element);
//         });
//       }
//     }
//     _stateSubListAr = _stateListAr;
//     var jsonStringEn = await rootBundle.loadString('assets/json/state_en.json');
//     List<dynamic> bodyEn = json.decode(jsonStringEn);

//     subStateListEn =
//         bodyEn.map((dynamic item) => StateModel.fromJson(item)).toList();
//     for (var element in subStateListEn) {
//       if (element.countryId == countryId) {
//         setState(() {
//           _stateListEn.add(element);
//         });
//       }
//     }
//     _stateSubListEn = _stateListEn;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           ///Country TextField
//           TextField(
//             controller: widget.country,
//             onTap: () {
//               setState(() => _title = 'Country');
//               _showDialog(context);
//             },
//             decoration: widget.textFieldDecoration == null
//                 ? defaultDecoration.copyWith(hintText: 'اختيار الدولة')
//                 : widget.textFieldDecoration
//                     ?.copyWith(hintText: 'اختيار الدولة'),
//             readOnly: true,
//           ),
//           const SizedBox(height: 8.0),

//           ///State TextField
//           TextField(
//             controller: widget.state,
//             onTap: () {
//               setState(() => _title = 'State');
//               if (widget.country.text.isNotEmpty) {
//                 _showDialog(context);
//               } else {
//                 _showSnackBar('اختيار الدولة');
//               }
//             },
//             decoration: widget.textFieldDecoration == null
//                 ? defaultDecoration.copyWith(hintText: 'اختيار المدينة')
//                 : widget.textFieldDecoration
//                     ?.copyWith(hintText: 'اختيار المدينة'),
//             readOnly: true,
//           ),
//           const SizedBox(height: 8.0),
//         ],
//       ),
//     );
//   }

//   void _showDialog(BuildContext context) {
//     final TextEditingController controller = TextEditingController();
//     final TextEditingController controller2 = TextEditingController();

//     showGeneralDialog(
//       barrierLabel: _title,
//       barrierDismissible: false,
//       barrierColor: Colors.black.withOpacity(0.5),
//       transitionDuration: const Duration(milliseconds: 350),
//       context: context,
//       pageBuilder: (context, __, ___) {
//         return Material(
//           color: Colors.transparent,
//           child: StatefulBuilder(
//             builder: (BuildContext context, StateSetter setState) {
//               return Align(
//                 alignment: Alignment.topCenter,
//                 child: Container(
//                   height: MediaQuery.of(context).size.height * .7,
//                   margin: const EdgeInsets.only(top: 60, left: 12, right: 12),
//                   decoration: BoxDecoration(
//                     color: widget.dialogColor ?? Colors.white,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Column(
//                     children: [
//                       const SizedBox(height: 10),
//                       Text(_title == 'Country' ? 'الدولة' : 'المدينة',
//                           style: TextStyle(
//                               color: ColorManager.primary,
//                               fontSize: 20,
//                               fontWeight: FontWeight.w500)),
//                       const SizedBox(height: 10),

//                       ///Text Field
//                       TextField(
//                         controller:
//                             _title == 'Country' ? controller : controller2,
//                         onChanged: (val) {
//                           setState(() {
//                             if (_title == 'Country') {
//                               _countrySubListAr = _countryListAr
//                                   .where((element) => element.name
//                                       .toLowerCase()
//                                       .contains(controller.text.toLowerCase()))
//                                   .toList();
//                             } else if (_title == 'State') {
//                               _stateSubListAr = _stateListAr
//                                   .where((element) => element.name
//                                       .toLowerCase()
//                                       .contains(controller2.text.toLowerCase()))
//                                   .toList();
//                             }
//                           });
//                         },
//                         style: TextStyle(
//                             color: Colors.grey.shade800, fontSize: 16.0),
//                         decoration: const InputDecoration(
//                             border: UnderlineInputBorder(),
//                             hintText: "أبحث هنا",
//                             contentPadding: EdgeInsets.symmetric(
//                                 vertical: 15, horizontal: 5),
//                             isDense: true,
//                             prefixIcon: Icon(Icons.search)),
//                       ),

//                       ///Dropdown Items
//                       Expanded(
//                         child: ListView.builder(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 8, vertical: 12),
//                           itemCount: _title == 'Country'
//                               ? _countrySubListAr.length
//                               : _stateSubListAr.length,
//                           physics: const ClampingScrollPhysics(),
//                           itemBuilder: (context, index) {
//                             return InkWell(
//                               onTap: () async {
//                                 setState(() {
//                                   if (_title == "Country") {
//                                     widget.country.text =
//                                         _countrySubListAr[index].name;
//                                     var c = _countrySubListEn.indexWhere(
//                                         (element) =>
//                                             element.id ==
//                                             _countrySubListAr[index].id);
//                                     widget.cubit.changeCountry(
//                                         value: _countrySubListEn[c].name,
//                                         sel: 'Country');
//                                     _getState(_countrySubListEn[c].id);
//                                     _countrySubListEn = _countryListEn;
//                                     widget.state.clear();
//                                   } else if (_title == 'State') {
//                                     widget.state.text =
//                                         _stateSubListAr[index].name;
//                                     var s = _stateSubListEn.indexWhere(
//                                         (element) =>
//                                             element.id ==
//                                             _stateSubListAr[index].id);
//                                     _stateSubListAr = _stateListAr;

//                                     widget.cubit.changeCountry(
//                                         value: _stateSubListEn[s].name,
//                                         sel: 'State');
//                                   }
//                                 });
//                                 controller.clear();
//                                 controller2.clear();

//                                 Navigator.pop(context);
//                               },
//                               child: Padding(
//                                 padding: const EdgeInsets.only(
//                                     bottom: 20.0, left: 10.0, right: 10.0),
//                                 child: Text(
//                                     _title == 'Country'
//                                         ? _countrySubListAr[index].name
//                                         : _stateSubListAr[index].name,
//                                     style: const TextStyle(
//                                         color: Colors.black87, fontSize: 18.0)),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           _countrySubListEn = _countryListEn;
//                           _countrySubListAr = _countryListAr;
//                           _stateSubListEn = _stateListEn;
//                           _stateSubListAr = _stateListAr;

//                           controller.clear();
//                           controller2.clear();

//                           Navigator.pop(context);
//                         },
//                         child: Container(
//                             width: 80,
//                             height: 50,
//                             alignment: Alignment.center,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(18),
//                             ),
//                             child: Text(
//                               'اغلاق',
//                               style: TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                   color: ColorManager.primary),
//                             )),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         );
//       },
//       transitionBuilder: (_, anim, __, child) {
//         return SlideTransition(
//           position: Tween(begin: const Offset(0, -1), end: const Offset(0, 0))
//               .animate(anim),
//           child: child,
//         );
//       },
//     );
//   }

//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         backgroundColor: Theme.of(context).primaryColor,
//         content: Text(message,
//             textAlign: TextAlign.center,
//             style: const TextStyle(color: Colors.white, fontSize: 16.0))));
//   }

//   InputDecoration defaultDecoration = const InputDecoration(
//       isDense: true,
//       hintText: 'Select',
//       suffixIcon: Icon(Icons.arrow_drop_down),
//       border: OutlineInputBorder());
// }

// class CountryModel {
//   final String id;
//   final String sortName;
//   final String name;
//   final String phoneCode;

//   CountryModel(
//       {required this.id,
//       required this.sortName,
//       required this.name,
//       required this.phoneCode});

//   factory CountryModel.fromJson(Map<String, dynamic> json) {
//     return CountryModel(
//         id: json['id'] as String,
//         sortName: json['sortname'] as String,
//         name: json['name'] as String,
//         phoneCode: json['phonecode'] as String);
//   }
// }

// class StateModel {
//   final String id;
//   final String name;
//   final String countryId;

//   StateModel({required this.id, required this.name, required this.countryId});

//   factory StateModel.fromJson(Map<String, dynamic> json) {
//     return StateModel(
//         id: json['id'] as String,
//         name: json['name'] as String,
//         countryId: json['country_id'] as String);
//   }
// }
