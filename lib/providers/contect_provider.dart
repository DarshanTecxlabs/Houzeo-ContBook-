import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:home_contact/models/contect.dart';

class ContectProvider with ChangeNotifier {
//creating list of contect model
  List<ContactModel> contectList = [];
  ContactModel? contactModel;
  //firebase instance
  var firestore = FirebaseFirestore.instance;

  addContect(ContactModel newContect) async {
    await firestore.collection('users').add({
      "firstName": newContect.firstName ?? "",
      "lastName": newContect.lastName ?? "",
      "mobile": newContect.mobile ?? "",
      "email": newContect.email ?? "",
      "location": newContect.location ?? ""
    }).then((value) {
      //set the document id
      newContect.id = value.id;
      //adding contect into contectlist
      contectList.add(newContect);
    });
    notifyListeners(); // for ui updating
  }

  removeContect(id) async {
    //remove contect where id match
    var index = contectList.indexWhere((element) => element.id == id);
    if (index != -1) {
      //removing contect from firebase
      await firestore.collection('users').doc(id).delete();
      contectList.removeAt(index);
    }
    notifyListeners(); // for ui updating
  }

  updateContect(ContactModel thisContect) async {
    var index =
        contectList.indexWhere((element) => element.id == thisContect.id);
    //update contect and check contect is in the list or not
    if (index != -1) {
      //update contect from firebase
      await firestore.collection('users').doc(thisContect.id).update({
        "firstName": thisContect.firstName,
        "lastName": thisContect.lastName,
        "mobile": thisContect.mobile,
        "email": thisContect.email,
        "location": thisContect.location
      });
      contectList[index] = thisContect;
    }
    notifyListeners();
  }

  fetchContectData() async {
    try {
      List<ContactModel> conList = [];

      QuerySnapshot snapshorts =
          await firestore.collection('users').orderBy("firstName").get();

      for (var element in snapshorts.docs) {
        contactModel = ContactModel(
            id: element.id,
            firstName: element.get("firstName"),
            lastName: element.get("lastName"),
            mobile: element.get("mobile"),
            email: element.get("email"),
            location: element.get("location"));
        conList.add(contactModel!);
        // var documentID = element.id;
      }
      contectList = conList;
      notifyListeners();
    } catch (ex) {
      log(ex.toString());
    }
  }

  get getcontectList {
    return contectList;
  }
}

//   var fbi = FirebaseFirestore.instance;
// //fetch documents inside collection
//   QuerySnapshot ss = await FirebaseFirestore.instance.collection('users').get();
//   log(ss.docs.toString());
//   for (var doc in ss.docs) {
//     log(doc.data().toString());
//   }
//   //target to specific documents
//   DocumentSnapshot ss1 =
//       await FirebaseFirestore.instance.collection('users').doc('Avnish').get();
//   log(ss1.data().toString());

// //ADD operation
//   Map<String, dynamic> newUserData = {
//     "name": "rahul",
//     "surname": "davi",
//     "email": "rahul@fst.com",
//     "number": 1425783691,
//     "location": "nagpur"
//   };
//   await fbi.collection("users").add(newUserData);
//   log("New user Saved");
//   await fbi.collection("users").doc("new id").set(newUserData);
//   log("new set");

//   //Update operation
//   await fbi
//       .collection("users")
//       .doc("new id")
//       .update({"email": "sspp@gmial.com"});
//   log("user upadted");

//   //Delete operation
//   await fbi.collection('users').doc("c6HsSxhQXcBLR7m4BSse").delete();
//   log("deleted sucessfully");

