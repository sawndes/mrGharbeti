import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../models/all_listings_model.dart';

class AllListingsBookmarkController extends GetxController {
  var selectedIndex = 0.obs;
  var icon = (Icons.bookmark_border_outlined).obs;
  var favList = <AllListingsModel>[].obs;
  var listFavBool = false.obs;

  void updateAll() {
    listFavBool.obs;
    // print('object');
    print(listFavBool);
    update();
  }

  void addBookmark(AllListingsModel list) {
    list.favorite = true;
    listFavBool.value = true;
    update();

    if (!favList.contains(list)) {
      favList.add(list);
      // print(listFavBool.value);
      // icon = Icons.bookmark;
      // Icons.abc = icon;
    } else {
      // print(listFavBool.value);
      // favList.remove(list);
      // icon.value = Icons.bookmark_border_outlined;
      listFavBool.value = false;
      list.favorite = false;
      favList.remove(list);
      update();

      // Get.snackbar(
      //     snackPosition: SnackPosition.BOTTOM,
      //     duration: Duration(milliseconds: 1000),
      //     'Already Bookmarked',
      //     'You\'ve added this listings to your bookmark');
    }
  }

  void removeBookmark(AllListingsModel list) {
    listFavBool.value = false;
    list.favorite = false;
    favList.remove(list);
    update();
  }
}
