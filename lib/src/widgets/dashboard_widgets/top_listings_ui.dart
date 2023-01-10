import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mr_gharbeti/src/controller/all_listings_bookmark_controller.dart';
import 'package:mr_gharbeti/src/controller/bookmark_clicked_controller.dart';
import '../../controller/bookmark_clicked_controller.dart';
import '../../models/all_listings_model.dart';
import '../../models/top_listings_model.dart';

class DashboardTopListings extends StatefulWidget {
  DashboardTopListings({Key? key, required this.textTheme}) : super(key: key);
  final TextTheme textTheme;

  @override
  State<DashboardTopListings> createState() => _DashboardTopListingsState();
}

class _DashboardTopListingsState extends State<DashboardTopListings> {
  // BookmarkClickedController bookmarkClickedController = Get.find();
  AllListingsBookmarkController allListingsBookmarkController = Get.find();

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    final isDark = brightness == Brightness.dark;
    // final list = DashboardTopListingsModel.list;
    // var BookmarkiconBool = Obx((() => bookmarkClickedController.);
    final list = AllListingsModel.list;

    return SizedBox(
      height: 200,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) => GestureDetector(
          onTap: list[index].onPress,
          child: SizedBox(
            width: 320,
            height: 200,
            child: Padding(
              padding: const EdgeInsets.only(right: 10, top: 5),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  //For Dark Color
                  color: isDark ? Color(0xFF272727) : Color(0xFFF7F6F1),
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            list[index].title,
                            style: widget.textTheme.headline4,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Flexible(
                            child: Image(
                                image: AssetImage(list[index].image),
                                height: 110)),
                      ],
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                            ),
                            onPressed: () {
                              // print('object');
                              // setState(() {
                              allListingsBookmarkController
                                  .addBookmark(list[index]);
                              // });
                            },
                            // child: Obx(() =>
                            //     Icon(bookmarkClickedController.icon.value))
                            // list[index].favorite == true
                            //     ? Obx(() =>
                            //         Icon(bookmarkClickedController.icon.value))
                            //     : Icon(Icons.bookmark_border_outlined)

                            child: Obx(
                              () => allListingsBookmarkController
                                      .listFavBool.value
                                  ? Icon(Icons.bookmark)
                                  : Icon(Icons.bookmark_border_outlined),
                            )

                            // child: list[index].favorite
                            //     ? Icon(Icons.bookmark)
                            //     : Icon(Icons.bookmark_border_outlined)
                            // child: Icon(bookmarkClickedController.icon.value),
                            ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              list[index].heading,
                              style: widget.textTheme.headline4,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              list[index].subheading,
                              style: widget.textTheme.bodyText2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
