import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controller/all_listings_bookmark_controller.dart';
import '../controller/bookmark_clicked_controller.dart';

class BookmarkListings extends StatefulWidget {
  BookmarkListings({super.key});

  @override
  State<BookmarkListings> createState() => _BookmarkListingsState();
}

class _BookmarkListingsState extends State<BookmarkListings> {
  // BookmarkClickedController bookmarkClickedController = Get.find();
  AllListingsBookmarkController allListingsBookmarkController = Get.find();

  @override
  Widget build(BuildContext context) {
    final list = allListingsBookmarkController.favList;
    return Scaffold(
        body: Obx(
      () => SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: ((context, index) => GestureDetector(
                      onTap: list[index].onPress,
                      child: SizedBox(
                        width: 120,
                        height: 100,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(list[index].title),
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        allListingsBookmarkController
                                            .removeBookmark(list[index]);
                                      });

                                      // AllListingsBookmarkController
                                      //     .removeBookmark(list[index]);
                                    },
                                    child: Text('Remove'))
                              ],
                            )
                          ],
                        ),
                      ),
                    )))
          ],
        ),
      ),
    ));
  }
}
