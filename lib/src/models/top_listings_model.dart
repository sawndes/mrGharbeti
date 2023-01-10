import 'package:flutter/material.dart';

class DashboardTopListingsModel {
  String title = '';
  String heading = '';
  String subheading = '';
  VoidCallback? onPress;
  String image = '';
  bool favorite = false;

  DashboardTopListingsModel(this.title, this.heading, this.subheading,
      this.image, this.onPress, this.favorite);
  static List<DashboardTopListingsModel> list = [
    // DashboardTopListingsModel(
    //     'House1', 'See Houses', 'ss', 'assets/images/house2.jpg', null),
    DashboardTopListingsModel(
        'House2', 'See Houses', 'ss', 'assets/images/house1.jpg', null, false),
    DashboardTopListingsModel(
        'House3', 'See Houses', 'ss', 'assets/images/house2.jpg', null, false),
  ];
}
