import 'package:avatars/avatars.dart';

import 'package:flutter/material.dart';
import 'package:home_contact/models/contect.dart';
import 'package:home_contact/providers/contect_provider.dart';

import 'package:provider/provider.dart';

class AddNewContect extends StatefulWidget {
  const AddNewContect({super.key});

  @override
  State<AddNewContect> createState() => _AddNewContectState();
}

class _AddNewContectState extends State<AddNewContect> {
  TextEditingController firstController = TextEditingController();
  TextEditingController lastController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          "Add New Contact",
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 16,
          ),
          Center(
              child: Avatar(
            loader: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.blue,
                    )),
                child: const Icon(
                  Icons.person,
                  size: 100,
                  color: Colors.blue,
                )),
          )),
          const SizedBox(
            height: 16,
          ),
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(10),
                child: TextField(
                  style: const TextStyle(fontSize: 14),
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  controller: firstController,
                  decoration: InputDecoration(
                    labelText: "First Name",
                    counterText: '',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        7,
                      ),
                      borderSide: const BorderSide(),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(10),
                child: TextField(
                  style: const TextStyle(fontSize: 14),
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  controller: lastController,
                  decoration: InputDecoration(
                    labelText: "Last Name",
                    counterText: '',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        7,
                      ),
                      borderSide: const BorderSide(),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(10),
                child: TextField(
                  maxLength: 10,
                  style: const TextStyle(fontSize: 14),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  controller: mobileController,
                  decoration: InputDecoration(
                    labelText: "Mobile Number",
                    counterText: '',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        7,
                      ),
                      borderSide: const BorderSide(),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(10),
                child: TextField(
                  style: const TextStyle(fontSize: 14),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  controller: mailController,
                  decoration: InputDecoration(
                    labelText: "Mail Address",
                    counterText: '',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        7,
                      ),
                      borderSide: const BorderSide(),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(10),
                child: TextField(
                  style: const TextStyle(fontSize: 14),
                  keyboardType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.next,
                  controller: locationController,
                  decoration: InputDecoration(
                    labelText: "City",
                    counterText: '',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        7,
                      ),
                      borderSide: const BorderSide(),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                    top: 5, bottom: 5, left: 10, right: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: ElevatedButton(
                  onPressed: () {
                    context.read<ContectProvider>().addContect(
                          ContactModel(
                              firstName: firstController.text,
                              lastName: lastController.text,
                              mobile: mobileController.text,
                              email: mailController.text,
                              location: locationController.text),
                        );
                    Navigator.pop(context);
                  },
                  child: const Text("Add Contact"),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
