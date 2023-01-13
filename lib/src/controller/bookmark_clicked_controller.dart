import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/top_listings_model.dart';

class BookmarkClickedController extends GetxController {
  var selectedIndex = 0.obs;
  var icon = (Icons.bookmark_border_outlined).obs;
  var favList = <DashboardTopListingsModel>[].obs;

  // void masterCaller(DashboardTopListingsModel)

  void addBookmark(DashboardTopListingsModel list) {
    list.favorite = true;

    if (!favList.contains(list)) {
      favList.add(list);
      // icon.value = (Icons.bookmark);
      // icon = Icons.bookmark;
      // Icons.abc = icon;
    } else {
      // favList.remove(list);
      // list.favorite = false;
      // icon.value = Icons.bookmark_border_outlined;
      Get.snackbar(
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(milliseconds: 1000),
          'Already Bookmarked',
          'You\'ve added this listings to your bookmark');
    }
  }

  // void checker(Das)

  void removeBookmark(DashboardTopListingsModel list) {
    list.favorite = false;
    icon.value = Icons.bookmark_border_outlined;
    favList.remove(list);
  }
}
