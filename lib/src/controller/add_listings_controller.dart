import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mr_gharbeti/src/models/user_model.dart';

import '../models/all_listings_model.dart';
import '../widgets/authentication/database_methods.dart';
import '../widgets/authentication/fire_auth.dart';
import 'package:random_string/random_string.dart';

class AddListingsController extends GetxController {
  static AddListingsController get instance => Get.find();
  final title = TextEditingController();
  final heading = TextEditingController();
  final subheading = TextEditingController();
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

  addListings(
    TextEditingController title,
    TextEditingController heading,
    TextEditingController subheading,
    TextEditingController description,
    String img,
  ) async {
    String listingId = '${thisUser}_${randomAlphaNumeric(12)}';
    final Map<String, bool> userMap = await getUserMap();
    // final imgUrl = _uploadImage(img);

    Map<String, dynamic> listingsData = {
      "listing_name": title.text.trim(),
      "listing_address": heading.text.trim(),
      "description": description.text.trim(),
      "sub_heading": subheading.text.trim(),
      "listing_photo": img,
      "listings_user": thisUser,
      "favorites": userMap
      // {
      //   '6sXzuLh673UHiZOEpNXfUUgawV92': false,
      //   'hahaha': false,
      // }
      ,
      // "listing_id": thisUser + '_' + randomAlphaNumeric(12)
      "listing_id": listingId
    };
    DatabaseMethods().addListings(thisUser, listingsData);

    title.clear();
    heading.clear();
    subheading.clear();
    description.clear();
    Get.snackbar('Added', 'Listings added sucessfully');
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
