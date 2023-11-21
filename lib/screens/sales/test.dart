// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// class Test extends StatefulWidget {
//   const Test({super.key});

//   @override
//   State<Test> createState() => _TestState();
// }

// class _TestState extends State<Test> {
//   TextEditingController controller = TextEditingController();

// // Future<Null> getUserDetails() async {
// //     final response = await http.get(url);
// //     final responseJson = json.decode(response.body);

// //     setState(() {
// //       for (Map user in responseJson) {
// //         _userDetails.add(UserDetails.fromJson(user));
// //       }
// //     });
// //   }

//   @override
//   void initState() {
//     super.initState();

//     // getUserDetails();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home'),
//         elevation: 0.0,
//       ),
//       body: Column(
//         children: <Widget>[
//           Container(
//             color: Theme.of(context).primaryColor,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Card(
//                 child: ListTile(
//                   leading: const Icon(Icons.search),
//                   title: TextField(
//                     controller: controller,
//                     decoration: const InputDecoration(
//                         hintText: 'Search', border: InputBorder.none),
//                     onChanged: onSearchTextChanged,
//                   ),
//                   trailing: IconButton(
//                     icon: const Icon(Icons.cancel),
//                     onPressed: () {
//                       controller.clear();
//                       onSearchTextChanged('');
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: _searchResult.isNotEmpty || controller.text.isNotEmpty
//                 ? ListView.builder(
//                     itemCount: _searchResult.length,
//                     itemBuilder: (context, i) {
//                       return Card(
//                         margin: const EdgeInsets.all(0.0),
//                         child: ListTile(
//                           leading: CircleAvatar(
//                             backgroundImage: NetworkImage(
//                               _searchResult[i].profileUrl,
//                             ),
//                           ),
//                           title: Text(
//                               '${_searchResult[i].firstName} ${_searchResult[i].lastName}'),
//                         ),
//                       );
//                     },
//                   )
//                 : ListView.builder(
//                     itemCount: _userDetails.length,
//                     itemBuilder: (context, index) {
//                       return Card(
//                         margin: const EdgeInsets.all(0.0),
//                         child: ListTile(
//                           leading: CircleAvatar(
//                             backgroundImage: NetworkImage(
//                               _userDetails[index].profileUrl,
//                             ),
//                           ),
//                           title: Text(
//                               '${_userDetails[index].firstName} ${_userDetails[index].lastName}'),
//                         ),
//                       );
//                     },
//                   ),
//           ),
//         ],
//       ),
//     );
//   }

//   onSearchTextChanged(String text) async {
//     _searchResult.clear();
//     if (text.isEmpty) {
//       setState(() {});
//       return;
//     }

//     for (var userDetail in _userDetails) {
//       if (userDetail.firstName.contains(text) ||
//           userDetail.lastName.contains(text)) {
//         _searchResult.add(userDetail);
//       }
//     }

//     setState(() {});
//   }
// }

// List<UserDetails> _searchResult = [];

// List<UserDetails> _userDetails = [];

// const String url = 'https://jsonplaceholder.typicode.com/users';

// class UserDetails {
//   final int id;
//   final String firstName, lastName, profileUrl;

//   UserDetails(
//       {required this.id,
//       required this.firstName,
//       required this.lastName,
//       this.profileUrl =
//           'https://i.amz.mshcdn.com/3NbrfEiECotKyhcUhgPJHbrL7zM=/950x534/filters:quality(90)/2014%2F06%2F02%2Fc0%2Fzuckheadsho.a33d0.jpg'});

//   factory UserDetails.fromJson(Map<String, dynamic> json) {
//     return UserDetails(
//       id: json['id'],
//       firstName: json['name'],
//       lastName: json['username'],
//     );
//   }
// }
