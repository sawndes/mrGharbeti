import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../models/all_listings_model.dart';
import '../widgets/authentication/database_methods.dart';
import '../widgets/authentication/fire_auth.dart';

class AllListingsBookmarkController extends GetxController {
  var selectedIndex = 0.obs;
  var icon = (Icons.bookmark_border_outlined).obs;
  var favList = [].obs;
  // String thisUser = FireAuth.instance.user.uid;
  // @override
  // void onInit() async {
  //   var fav = await DatabaseMethods().getFavListings(thisUser);
  //   // favList.add(4);
  //   // favList = [21212, 3, 3] as RxList;
  //   // TODO: implement onInit
  //   super.onInit();
  // }

  // @override
  // void onReady() async {
  //   var fav = await DatabaseMethods().getFavListings(thisUser);
  //   // favList = fav;
  //   favList.add(4);

  //   // favList = [21212, 3, 3] as RxList;
  //   // TODO: implement onInit
  //   super.onInit();
  //   super.onReady();
  // }

  var listFavBool = false.obs;

  bool getFav(AllListingsModel list) {
    print(list.favorite);
    return list.favorite;
  }

  void bookmarkAdd(List list, int index, String thisUser) async {
    var fav = list[index]['favorites'][thisUser];
    // favList = fav;
    print(fav);
    var listingId = list[index]['listing_id'];

    fav ??= false;

    await FirebaseFirestore.instance
        .collection("listings")
        .doc("all_listings")
        .get()
        .then((documentSnapshot) {
      var listings = documentSnapshot.data()!['listings'];
      var index = listings.indexWhere((listing) =>
          // listing["favorites"] == fav &&
          listing["listing_id"] == listingId);

      if (index != -1) {
        listings[index]["favorites"][thisUser] = !fav;
      }
      return FirebaseFirestore.instance
          .collection("listings")
          .doc("all_listings")
          .update({"listings": listings});
    });
  }

  // void addBookmark(AllListingsModel list) {
  //   list.favorite = true;
  //   update();
  //   // listFavBool.value = true;
  //   // update();

  //   if (!favList.contains(list)) {
  //     favList.add(list);
  //     list.favorite = true;
  //     update();
  //     // print(listFavBool.value);
  //     // icon = Icons.bookmark;
  //     // Icons.abc = icon;
  //   } else {
  //     // print(listFavBool.value);
  //     // favList.remove(list);
  //     // icon.value = Icons.bookmark_border_outlined;
  //     listFavBool.value = false;
  //     list.favorite = false;
  //     favList.remove(list);
  //     update();

  //     // Get.snackbar(
  //     //     snackPosition: SnackPosition.BOTTOM,
  //     //     duration: Duration(milliseconds: 1000),
  //     //     'Already Bookmarked',
  //     //     'You\'ve added this listings to your bookmark');
  //   }
  // }

  // void removeBookmark(AllListingsModel list) {
  //   listFavBool.value = false;
  //   list.favorite = false;
  //   favList.remove(list);
  //   update();
  // }
}
