// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class SearchUsers extends StatefulWidget {
//   const SearchUsers({super.key});

//   @override
//   State<SearchUsers> createState() => _SearchUsersState();
// }

// class _SearchUsersState extends State<SearchUsers> {
//   TextEditingController search = TextEditingController();
//   var searchname;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: TextField(
//           onChanged: (value) {
//             searchname = value;
//             setState(() {});
//           },
//           controller: search,
//           decoration: InputDecoration(hintText: "Search"),
//         ),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               StreamBuilder<QuerySnapshot>(
//                 stream: FirebaseFirestore.instance
//                     .collection("users")
//                     .where("name", isEqualTo: searchname)
//                     // .orderBy("age", descending: true)
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.active) {
//                     if (snapshot.hasData && snapshot.data != null) {
//                       return Expanded(
//                         child: ListView.builder(
//                           itemCount: snapshot.data!.docs.length,
//                           itemBuilder: (context, index) {
//                             Map<String, dynamic> userMap =
//                                 snapshot.data!.docs[index].data()
//                                     as Map<String, dynamic>;
//                             return ListTile(
//                               // leading: CircleAvatar(
//                               //   backgroundImage: NetworkImage(userMap["profilepic"]),
//                               // ),
//                               title: Text(userMap["name"]),
//                               subtitle: Text(userMap["number"].toString()),
//                               trailing: IconButton(
//                                 onPressed: () {
//                                   // Delete
//                                 },
//                                 icon: Icon(Icons.delete),
//                               ),
//                             );
//                           },
//                         ),
//                       );
//                     } else {
//                       return Text("No data!");
//                     }
//                   } else {
//                     return Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
