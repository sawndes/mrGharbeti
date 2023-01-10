import 'package:flutter/material.dart';

class DashboardTopListingsModel {
  final String title;
  final String heading;
  final String subheading;
  final VoidCallback? onPress;
  final String image;

  DashboardTopListingsModel(
      this.title, this.heading, this.subheading, this.image, this.onPress);
  static List<DashboardTopListingsModel> list = [
    DashboardTopListingsModel(
        'House1', 'See Houses', 'ss', 'assets/images/house2.jpg', null),
    DashboardTopListingsModel(
        'House2', 'See Houses', 'ss', 'assets/images/house1.jpg', null),
    DashboardTopListingsModel(
        'House3', 'See Houses', 'ss', 'assets/images/house2.jpg', null),
  ];
}
