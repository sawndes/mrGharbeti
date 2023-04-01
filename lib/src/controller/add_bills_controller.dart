import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import '../widgets/authentication/database_methods.dart';
import '../widgets/authentication/fire_auth.dart';

class AddBillsController extends GetxController {
  static AddBillsController get instance => Get.find();
  final title = TextEditingController();
  final price = TextEditingController();
  final address = TextEditingController();
  final description = TextEditingController();
  String thisUser = FireAuth.instance.user.uid;
  Future<Map<String, bool>> getUserMap() async {
    final Map<String, bool> userMap = {};

    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((document) {
        userMap[document.id] = false;
      });
    });

    return userMap;
  }

  Future<String> _uploadImage(File imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageReference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = storageReference.putFile(imageFile);
    // await uploadTask.then(()=>);
    String imageURL = await storageReference.getDownloadURL();

    _getImageURL(imageURL);
    return imageURL;
    // ...
  }

  Future<String> _getImageURL(String imageURL) async {
    // Reference storageReference = FirebaseStorage.instance.ref().child(fileName);
    // String imageURL = await storageReference.getDownloadURL();
    // return imageURL;
    return imageURL;
  }

  addBills(
    TextEditingController title,
    TextEditingController price,
    TextEditingController description,
    List<String> img,
  ) async {
    String listingId = '${thisUser}_${randomAlphaNumeric(12)}';
    final Map<String, bool> userMap = await getUserMap();
    // final imgUrl = _uploadImage(img);

    Map<String, dynamic> listingsData = {
      "bill_name": title.text.trim(),
      "bill_price": price.text.trim(),
      "description": description.text.trim(),
      "bill_photo": img,
      "listings_user": thisUser,
    };
    DatabaseMethods().addBills(thisUser, listingsData);

    title.clear();
    price.clear();
    address.clear();
    description.clear();
    Get.snackbar('Added', 'Bills added sucessfully');
  }

  addfavoritesListings() {}

  // void addListings(
  //   TextEditingController title,
  //   TextEditingController heading,
  //   TextEditingController subheading,
  //   TextEditingController description,
  // ) {
  //   AllListingsModel.list.add(
  //     AllListingsModel(
  //       title.text.trim(),
  //       heading.text.trim(),
  //       description.text.trim(),
  //       subheading.text.trim(),
  //       'assets/images/house2.jpg',
  //       null,
  //       false,
  //     ),
  //   );
  //   title.clear();
  //   heading.clear();
  //   subheading.clear();
  //   description.clear();
  //   Get.snackbar('Added', 'Listings added sucessfully');
  // }
}
