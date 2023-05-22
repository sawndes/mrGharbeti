import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mr_gharbeti/src/controller/all_listings_bookmark_controller.dart';
import '../../models/all_listings_model.dart';
import '../../screens/listing_details.dart';
import '../authentication/database_methods.dart';
import '../authentication/fire_auth.dart';

class DashboardTopListings extends StatefulWidget {
  const DashboardTopListings({Key? key, required this.textTheme})
      : super(key: key);
  final TextTheme textTheme;

  @override
  State<DashboardTopListings> createState() => _DashboardTopListingsState();
}

class _DashboardTopListingsState extends State<DashboardTopListings> {
  Stream<DocumentSnapshot<Map<String, dynamic>>>? listingStream;
  Stream<DocumentSnapshot<Map<String, dynamic>>>? favListStream;
  String thisUser = FireAuth.instance.user.uid;
  getListings() async {
    listingStream = (await DatabaseMethods().getListings());
    // favListStream = await DatabaseMethods().getFavListings(thisUser);
    setState(() {});
  }

  onScreenLoaded() async {
    getListings();
  }

  @override
  void initState() {
    onScreenLoaded();
    super.initState();
  }

  // BookmarkClickedController bookmarkClickedController = Get.find();
  @override
  Widget build(BuildContext context) {
    AllListingsBookmarkController allListingsBookmarkController = Get.find();

    var brightness = MediaQuery.of(context).platformBrightness;
    final isDark = brightness == Brightness.dark;
    // final list = DashboardTopListingsModel.list;
    // var BookmarkiconBool = Obx((() => bookmarkClickedController.);
    final list = AllListingsModel.list;
    return SizedBox(
      height: 200,
      child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        // stream: FirebaseFirestore.instance
        //     .collection('listings')
        //     .doc('all_listings')
        //     .snapshots(),
        stream: listingStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  primary: false,
                  scrollDirection: Axis.horizontal,
                  // itemCount: snapshot.data.docs.,
                  itemCount: snapshot.data!.data()!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> data = snapshot.data!.data()!;
                    List<dynamic> listings = data['listings'];

                    List filteredListings = listings
                        .where((listing) => listing['rent_user'].length == 0)
                        // (listing) =>
                        //     listing['listings_user'] == thisUser)
                        .toList();
                    return AllListingsTile(widget.textTheme, filteredListings);
                  })
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class AllListingsTile extends StatelessWidget {
  final List ds;
  // final Map<String, dynamic> favs;
  // final int favs;
  final TextTheme textTheme;
  const AllListingsTile(this.textTheme, this.ds, {super.key});

  @override
  Widget build(BuildContext context) {
    AllListingsBookmarkController allListingsBookmarkController = Get.find();

    var list = ds;
    String thisUser = FireAuth.instance.user.uid;
    int itemCount = ds.length <= 2 ? ds.length : 2;

    // var favLists =
    // var name = widget.ds[2]['listing_address'];

    return ListView.builder(
      shrinkWrap: true,
      // primary: false,
      scrollDirection: Axis.horizontal,
      itemCount: itemCount,
      itemBuilder: (context, index) => InkWell(
        // onTap: list[index].onPress,
        onTap: () {
          Get.to(() => ListingDetail(textTheme), arguments: list[index]);
          // print(ds.length);
        },
        child: Row(
          children: [
            Ink(
              width: 320,
              height: 180,
              padding: const EdgeInsets.only(right: 10, top: 7),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F6F1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            list[index]['listing_name'],
                            style: textTheme.headline4,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Flexible(
                            child: Image(
                                // image: AssetImage(list[index].image),
                                image: NetworkImage(
                                    list[index]['listing_photo'][0]),
                                height: 110)),
                      ],
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                          ),
                          onPressed: () async {
                            allListingsBookmarkController.bookmarkAdd(
                                list, index, thisUser);
                          },
                          child: list[index]['favorites'][thisUser] == null
                              ? const Icon(Icons.bookmark_border_outlined)
                              : list[index]['favorites'][thisUser]
                                  ? const Icon(Icons.bookmark)
                                  : const Icon(Icons.bookmark_border_outlined),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              list[index]['listing_price'] + ' per month',
                              style: textTheme.headline4,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              list[index]['listing_address'],
                              style: textTheme.bodyText2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 30,
            ),
          ],
        ),
      ),
    );
  }
}
