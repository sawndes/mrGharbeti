import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../controller/bookmark_clicked_controller.dart';

class BookmarkListings extends StatelessWidget {
  BookmarkListings({super.key});
  BookmarkClickedController bookmarkClickedController = Get.find();

  @override
  Widget build(BuildContext context) {
    final list = bookmarkClickedController.favList;
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
                                      bookmarkClickedController
                                          .removeBookmark(list[index]);
                                    },
                                    child: Text('Remove '))
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
