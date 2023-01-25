import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mr_gharbeti/src/models/user_model.dart';

import '../models/all_listings_model.dart';

class AddListingsController extends GetxController {
  static AddListingsController get instance => Get.find();
  final title = TextEditingController();
  final heading = TextEditingController();
  final subheading = TextEditingController();
  final description = TextEditingController();

  void addListings(
    TextEditingController title,
    TextEditingController heading,
    TextEditingController subheading,
    TextEditingController description,
  ) {
    AllListingsModel.list.add(
      AllListingsModel(
        title.text.trim(),
        heading.text.trim(),
        description.text.trim(),
        subheading.text.trim(),
        'assets/images/house2.jpg',
        null,
        false,
      ),
    );
    title.clear();
    heading.clear();
    subheading.clear();
    description.clear();
    Get.snackbar('Added', 'Listings added sucessfully');
  }
}
