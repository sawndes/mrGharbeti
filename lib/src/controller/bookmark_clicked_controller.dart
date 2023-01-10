import 'package:get/get.dart';

import '../models/top_listings_model.dart';

class BookmarkClickedController extends GetxController {
  var selectedIndex = 0.obs;
  var favList = <DashboardTopListingsModel>[].obs;

  void addBookmark(DashboardTopListingsModel list) {
    if (!favList.contains(list)) {
      favList.add(list);
    } else {
      Get.snackbar(
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(milliseconds: 1000),
          'Already Bookmarked',
          'You\'ve added this listings to your bookmark');
    }
  }

  void removeBookmark(DashboardTopListingsModel list) {
    favList.remove(list);
  }
}
