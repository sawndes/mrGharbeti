import 'package:flutter/material.dart';

class AllListingsModel {
  final String title;
  final String heading;
  final String subheading;
  final String description;
  final VoidCallback? onPress;
  final String image;
  bool favorite = false;

  AllListingsModel(this.title, this.heading, this.description, this.subheading,
      this.image, this.onPress, this.favorite);
  static List<AllListingsModel> list = [
    AllListingsModel(
      'House1',
      'See Houses',
      'ss',
      'sads',
      'assets/images/house2.jpg',
      null,
      false,
    ),
    AllListingsModel(
      'House2',
      'See Houses',
      'ss',
      'sads',
      'assets/images/house1.jpg',
      null,
      false,
    ),
    AllListingsModel(
      'House3',
      'See Houses',
      'ss',
      'sads',
      'assets/images/house2.jpg',
      null,
      false,
    ),
  ];
}
