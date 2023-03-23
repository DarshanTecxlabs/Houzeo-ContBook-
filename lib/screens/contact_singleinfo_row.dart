import 'package:flutter/material.dart';

class ContactSingleInfoRow extends StatelessWidget {
  const ContactSingleInfoRow(
      {super.key, required this.singleInfo, required this.singleIcon});

  final String singleInfo;
  final IconData singleIcon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(top: 6, left: 20, bottom: 6),
      leading: Icon(
        singleIcon,
        size: 28,
        color: Colors.blue,
      ),
      title: Container(
        margin: const EdgeInsets.all(3),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.black12,
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
        child: Text(
          singleInfo,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
