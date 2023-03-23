import 'dart:async';
import 'dart:developer';

import 'package:avatars/avatars.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_contact/models/contect.dart';
import 'package:home_contact/providers/contect_provider.dart';
import 'package:home_contact/screens/add_user_screen.dart';
import 'package:home_contact/screens/single_user_screen.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactList extends StatefulWidget {
  const ContactList({super.key});

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );

  @override
  void initState() {
    getConnectivity();
    ContectProvider contectProvider = Provider.of(context, listen: false);
    contectProvider.fetchContectData();
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          "Houzeo ContBook",
        ),
        elevation: 0,
      ),
      body: Consumer<ContectProvider>(
        builder: (context, value, child) => RefreshIndicator(
          onRefresh: () async {
            ContectProvider contectProvider =
                Provider.of(context, listen: false);
            contectProvider.fetchContectData();
          },
          child: ListView.builder(
              itemCount: value.contectList.length,
              itemBuilder: (context, index) => ListTile(
                    onTap: () {
                      //go to details screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SingleContactPage(
                            contact: value.contectList[index],
                          ),
                        ),
                      );
                    },
                    leading: Avatar(
                        name:
                            '${value.contectList[index].firstName} ${value.contectList[index].lastName}',
                        placeholderColors: const [
                          Colors.blue,
                          Colors.lightBlue
                        ],
                        loader: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: Colors.blue,
                                )),
                            child: const Icon(
                              Icons.person,
                              color: Colors.blue,
                            )),
                        shape: AvatarShape.circle(20)),
                    title: Text(
                      '${value.contectList[index].firstName} ${value.contectList[index].lastName}',
                      style: const TextStyle(color: Colors.black),
                    ),
                    subtitle: Text(
                      value.contectList[index].mobile != ""
                          ? '+91-${value.contectList[index].mobile}'
                          : "",
                      style: const TextStyle(color: Colors.blueGrey),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            editWidgets(value.contectList[index]);
                          },
                          icon: const Icon(Icons.more_vert),
                        ),
                        IconButton(
                          onPressed: () async {
                            final Uri url = Uri(
                              scheme: 'tel',
                              path: value.contectList[index].mobile,
                            );
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            } else {
                              log("cant launch the uri");
                            }
                          },
                          icon: const Icon(
                            Icons.call,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewContect(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  showDialogBox() => showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: const Text('No Connection'),
            content: const Text('Please check your internet connectivity'),
            actions: [
              TextButton(
                onPressed: () async {
                  Navigator.pop(context, 'Cancel');
                  setState(() => isAlertSet = false);
                  isDeviceConnected =
                      await InternetConnectionChecker().hasConnection;
                  if (!isDeviceConnected && isAlertSet == false) {
                    showDialogBox();
                    setState(() => isAlertSet = true);
                  }
                },
                child: const Text('OK'),
              ),
            ],
          ));

  editWidgets(ContactModel contectList) async {
    TextEditingController firstController =
        TextEditingController(text: contectList.firstName);
    TextEditingController lastController =
        TextEditingController(text: contectList.lastName);
    TextEditingController mobileController =
        TextEditingController(text: contectList.mobile);
    TextEditingController mailController =
        TextEditingController(text: contectList.email);
    TextEditingController locationController =
        TextEditingController(text: contectList.location);
    return await showModalBottomSheet(
        enableDrag: true,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30.0),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          return DraggableScrollableSheet(
            snap: true,
            expand: false,
            initialChildSize: 0.8,
            maxChildSize: 0.8,
            builder: (BuildContext context, ScrollController scrollController) {
              return SafeArea(
                  child: Stack(
                children: [
                  Positioned.fill(
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      controller: scrollController,
                      child: Column(
                        children: [
                          Center(
                            child: Container(
                              margin: const EdgeInsets.only(top: 20),
                              width: 100,
                              height: 4,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          Row(
                            children: [
                              Avatar(
                                  margin: const EdgeInsets.only(
                                      top: 10,
                                      left: 30.0,
                                      right: 30.0,
                                      bottom: 20),
                                  loader: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                            color: Colors.blue,
                                          )),
                                      child: const Icon(
                                        Icons.person,
                                        size: 100,
                                        color: Colors.blue,
                                      )),
                                  name:
                                      '${contectList.firstName} ${contectList.lastName}'),
                              Flex(
                                direction: Axis.vertical,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: TextField(
                                      style: const TextStyle(fontSize: 14),
                                      keyboardType: TextInputType.name,
                                      textInputAction: TextInputAction.next,
                                      controller: firstController,
                                      decoration: InputDecoration(
                                        labelText: "First Name",
                                        counterText: '',
                                        contentPadding:
                                            const EdgeInsets.symmetric(
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
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    margin: const EdgeInsets.only(top: 15),
                                    child: TextField(
                                      style: const TextStyle(fontSize: 14),
                                      keyboardType: TextInputType.name,
                                      textInputAction: TextInputAction.next,
                                      controller: lastController,
                                      decoration: InputDecoration(
                                        labelText: "Last Name",
                                        counterText: '',
                                        contentPadding:
                                            const EdgeInsets.symmetric(
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
                                ],
                              )
                            ],
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
                                var tempContect = ContactModel(
                                    firstName: firstController.text,
                                    lastName: lastController.text,
                                    mobile: mobileController.text,
                                    email: mailController.text,
                                    location: locationController.text);
                                //update id
                                tempContect.id = contectList.id;
                                context
                                    .read<ContectProvider>()
                                    .updateContect(tempContect);
                                Navigator.pop(context);
                              },
                              child: const Text("Update Contact"),
                            ),
                          ),
                          const SizedBox(
                            height: 300,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ));
            },
          );
        });
  }
}
