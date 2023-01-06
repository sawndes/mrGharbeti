import 'package:flutter/material.dart';

class DashboardCategoriesModel {
  final String title;
  final String heading;
  // final String subheading;
  final VoidCallback? onPress;

  DashboardCategoriesModel(this.title, this.heading, this.onPress);
  static List<DashboardCategoriesModel> list = [
    DashboardCategoriesModel('House', 'See Houses', null),
    DashboardCategoriesModel('Flat', 'See Flats', null),
    DashboardCategoriesModel('Room', 'See Rooms', null),
  ];
}
