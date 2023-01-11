import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controller/all_listings_bookmark_controller.dart';
import '../widgets/dashboard_widgets/appBar_ui.dart';
import '../widgets/dashboard_widgets/searchBar_ui.dart';

class BookmarkListings extends StatelessWidget {
  const BookmarkListings({Key? key}) : super(key: key);

  // @override
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    AllListingsBookmarkController allListingsBookmarkController = Get.find();

    final list = allListingsBookmarkController.favList;
    var brightness = MediaQuery.of(context).platformBrightness;
    final isDark = brightness == Brightness.dark;
    return Scaffold(
        appBar: AppBarUI('Favorites Listings', false),
        body: Obx(
          () => Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                Text(
                  'Your Favorites',
                  style: textTheme.headline2,
                ),
                const SizedBox(
                  height: 20,
                ),
                //Search Bar
                // DashboardSearchbarUI(textTheme: textTheme),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  // height: height * 0.8,
                  child: ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    scrollDirection: Axis.vertical,
                    itemCount: list.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: list[index].onPress,
                      child: SizedBox(
                        width: 320,
                        height: 200,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10, top: 5),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              //For Dark Color
                              color: isDark
                                  ? Color(0xFF272727)
                                  : Color(0xFFF7F6F1),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        list[index].title,
                                        style: textTheme.headline4,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Flexible(
                                        child: Image(
                                            image:
                                                AssetImage(list[index].image),
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
                                        child: list[index].favorite
                                            ? const Icon(Icons.bookmark)
                                            : const Icon(Icons
                                                .bookmark_border_outlined)),
                                    const SizedBox(width: 20),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          list[index].heading,
                                          style: textTheme.headline4,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          list[index].subheading,
                                          style: textTheme.bodyText2,
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
                ),
              ],
            ),
          ),
        ));

    // return Scaffold(
    //   body: Obx(
    //     () => Column(
    //       children: [
    //         ListView.builder(
    //             scrollDirection: Axis.vertical,
    //             shrinkWrap: true,
    //             itemCount: list.length,
    //             itemBuilder: ((context, index) => GestureDetector(
    //                   onTap: list[index].onPress,
    //                   child: SizedBox(
    //                     width: 120,
    //                     height: 100,
    //                     child: Column(
    //                       children: [
    //                         Row(
    //                           children: [
    //                             Text(list[index].title),
    //                             ElevatedButton(
    //                                 onPressed: () {
    //                                   allListingsBookmarkController
    //                                       .removeBookmark(list[index]);

    //                                   // allListingsBookmarkController
    //                                   //     .removeBookmark(list[index]);

    //                                   // AllListingsBookmarkController
    //                                   //     .removeBookmark(list[index]);
    //                                 },
    //                                 child: Text('Remove')),
    //                           ],
    //                         )
    //                       ],
    //                     ),
    //                   ),
    //                 )))
    //       ],
    //     ),
    //   ),
    // );
  }
}
