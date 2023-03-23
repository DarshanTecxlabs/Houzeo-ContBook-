import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:home_contact/screens/contact_List_screen.dart';

import 'package:provider/provider.dart';

import 'providers/contect_provider.dart';

Future<void> main() async {
  //our flutter releted configation must initialized 1st before firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // adding contect services at root of application
    return ChangeNotifierProvider<ContectProvider>(
      create: (context) => ContectProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Houzeo ContBook',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ContactList(),
      ),
    );
  }
}
