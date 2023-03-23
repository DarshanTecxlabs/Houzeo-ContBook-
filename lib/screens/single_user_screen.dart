import 'dart:developer';

import 'package:avatars/avatars.dart';

import 'package:flutter/material.dart';
import 'package:home_contact/models/contect.dart';
import 'package:home_contact/providers/contect_provider.dart';
import 'package:home_contact/screens/contact_singleinfo_row.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SingleContactPage extends StatefulWidget {
  final ContactModel contact;
  const SingleContactPage({super.key, required this.contact});

  @override
  State<SingleContactPage> createState() => _SingleContactPageState();
}

class _SingleContactPageState extends State<SingleContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Contact Details",
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.phone),
            color: Colors.white,
            onPressed: () async {
              final Uri url = Uri(
                scheme: 'tel',
                path: widget.contact.mobile,
              );
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              } else {
                log("cant launch the uri");
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 16,
          ),
          Center(
            child: Avatar(
              name: '${widget.contact.firstName} ${widget.contact.lastName}',
              placeholderColors: const [Colors.blue, Colors.lightBlue],
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
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            '${widget.contact.firstName} ${widget.contact.lastName}',
            style: GoogleFonts.openSans(
              textStyle: const TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.grey, width: 1),
              boxShadow: [
                BoxShadow(
                    blurRadius: 4,
                    spreadRadius: 2.9,
                    color: Colors.grey.withOpacity(0.05)),
                BoxShadow(
                    blurRadius: 8,
                    spreadRadius: 2.9,
                    color: Colors.grey.withOpacity(0.05))
              ],
            ),
            child: Column(
              children: [
                ContactSingleInfoRow(
                  singleInfo: widget.contact.mobile!,
                  singleIcon: Icons.phone_outlined,
                ),
                ContactSingleInfoRow(
                  singleInfo: widget.contact.email!,
                  singleIcon: Icons.email_outlined,
                ),
                ContactSingleInfoRow(
                  singleInfo: widget.contact.location!,
                  singleIcon: Icons.location_on_outlined,
                ),
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<ContectProvider>()
                        .removeContect(widget.contact.id);
                    Navigator.pop(context);
                  },
                  child: const Text("Delete Contect"),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
