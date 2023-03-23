// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:home_contact/providers/contect_provider.dart';
// import 'package:home_contact/screens/search_screen.dart';
// import 'package:home_contact/screens/single_user_screen.dart';
// import 'package:provider/provider.dart';
// import 'package:avatars/avatars.dart';

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   void initState() {
//     // ContectProvider contectProvider = Provider.of(context, listen: false);
//     // contectProvider.fetchContectData();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => SearchUsers(),
//                 ),
//               );
//             },
//             icon: Icon(Icons.search),
//           ),
//         ],
//       ),
//       body: SafeArea(
//           child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             StreamBuilder<QuerySnapshot>(
//                 stream: FirebaseFirestore.instance
//                     .collection('users')
//                     .orderBy("firstName")
//                     .snapshots(),
//                 builder: ((context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.active) {
//                     if (snapshot.hasData && snapshot.data != null) {
//                       return Expanded(
//                         child: ListView.builder(
//                           itemCount: snapshot.data!.docs.length,
//                           itemBuilder: (context, index) {
//                             //to select 1 doc at specific index
//                             Map<String, dynamic> userMap =
//                                 snapshot.data!.docs[index].data()
//                                     as Map<String, dynamic>;

//                             return ListTile(
//                               onTap: () {
//                                 // Navigator.push(
//                                 //   context,
//                                 //   MaterialPageRoute(
//                                 //     builder: (context) => SingleContactPage(
//                                 //       contact: userMap,
//                                 //     ),
//                                 //   ),
//                                 // );
//                               },
//                               leading: Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 12),
//                                 child: Avatar(
//                                     loader: Text("data"),
//                                     name:
//                                         '${userMap["firstName"]} ${userMap["lastName"]}',
//                                     shape: AvatarShape.circle(20)),
//                               ),
//                               contentPadding:
//                                   EdgeInsets.only(top: 6, left: 16, bottom: 6),
//                               title: Text(
//                                 "${userMap["firstName"]} ${userMap["lastName"]}",
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                               subtitle: Text(
//                                 "${userMap["email"]}",
//                                 style: TextStyle(color: Colors.blueGrey),
//                               ),
//                               trailing: Padding(
//                                 padding: const EdgeInsets.only(right: 24),
//                                 child: Icon(
//                                   Icons.phone_outlined,
//                                   size: 28,
//                                 ),
//                               ),
//                             );

//                             // return ListTile(
//                             //   // leading: CircleAvatar(
//                             //   //   // backgroundImage:
//                             //   //   //     NetworkImage(userMap["profilepic"]),
//                             //   // ),
//                             //   title: Text(userMap["firstName"] +
//                             //       " ${userMap["lastName"]}"),
//                             //   subtitle: Text(userMap["location"].toString()),
//                             //   trailing: IconButton(
//                             //     onPressed: () {
//                             //       Navigator.push(
//                             //         context,
//                             //         MaterialPageRoute(
//                             //           builder: (context) => SingleContactPage(
//                             //             contact: userMap,
//                             //           ),
//                             //         ),
//                             //       );
//                             //     },
//                             //     icon: Icon(Icons.arrow_back),
//                             //   ),
//                             // );
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
//                 }))
//           ],
//         ),
//       )),
//       // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
