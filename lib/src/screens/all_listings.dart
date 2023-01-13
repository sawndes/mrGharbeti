import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_gharbeti/src/controller/all_listings_bookmark_controller.dart';
import 'package:mr_gharbeti/src/models/all_listings_model.dart';
import 'package:mr_gharbeti/src/screens/listing_details.dart';

import '../widgets/dashboard_widgets/appBar_ui.dart';
import '../widgets/dashboard_widgets/searchBar_ui.dart';

class AllListings extends StatelessWidget {
  const AllListings({Key? key, required this.textTheme}) : super(key: key);
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    AllListingsBookmarkController allListingsBookmarkController = Get.find();

    final textTheme = Theme.of(context).textTheme;
    // var height = MediaQuery.of(context).size.height;
    var brightness = MediaQuery.of(context).platformBrightness;
    final isDark = brightness == Brightness.dark;
    final list = AllListingsModel.list;
    return Scaffold(
      appBar: AppBarUI('Mr. Gharbeti', true),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Text(
              'Listings',
              style: textTheme.headline2,
            ),
            const SizedBox(
              height: 20,
            ),
            //Search Bar
            DashboardSearchbarUI(textTheme: textTheme),
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
                itemBuilder: (context, index) => InkWell(
                  // onTap: list[index].onPress,
                  onTap: () {
                    // print('object');
                    Get.to(() => ListingDetail(), arguments: list[index]);
                  },
                  child: SizedBox(
                    width: 320,
                    height: 200,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10, top: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
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
                                    style: textTheme.headline4,
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
                                    child: GetBuilder<
                                            AllListingsBookmarkController>(
                                        builder: (_) =>
                                            allListingsBookmarkController
                                                    .getFav(list[index])
                                                ? const Icon(Icons.bookmark)
                                                : const Icon(Icons
                                                    .bookmark_border_outlined))
                                    // child: Obx(
                                    //   () => allListingsBookmarkController
                                    //           .listFavBool.value
                                    //       ? const Icon(Icons.bookmark)
                                    //       : const Icon(
                                    //           Icons.bookmark_border_outlined)),
                                    ),
                                const SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
    );
  }
}
