import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_gharbeti/src/controller/all_listings_bookmark_controller.dart';
import 'package:mr_gharbeti/src/models/all_listings_model.dart';
import 'package:mr_gharbeti/src/screens/listing_details.dart';
import 'package:mr_gharbeti/src/widgets/authentication/fire_auth.dart';

import '../widgets/authentication/database_methods.dart';
import '../widgets/dashboard_widgets/appBar_ui.dart';
import '../widgets/dashboard_widgets/searchBar_ui.dart';

class AllListings extends StatefulWidget {
  const AllListings({Key? key, required this.textTheme}) : super(key: key);
  final TextTheme textTheme;

  @override
  State<AllListings> createState() => _AllListingsState();
}

class _AllListingsState extends State<AllListings> {
  Stream<DocumentSnapshot<Map<String, dynamic>>>? listingStream;
  String thisUser = FireAuth.instance.user.uid;

  // Future<Future<DocumentSnapshot<Map<String, dynamic>>>>? listings;

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

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // var height = MediaQuery.of(context).size.height;
    var brightness = MediaQuery.of(context).platformBrightness;
    final isDark = brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBarUI('Mr. Gharbeti', true),
      body: Container(
          padding: const EdgeInsets.all(30),
          child: Column(children: [
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
              child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: listingStream,
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? ListView.builder(
                          primary: false,
                          scrollDirection: Axis.vertical,
                          // itemCount: snapshot.data.docs.,
                          itemCount: snapshot.data!.data()!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> data = snapshot.data!.data()!;

                            return AllListingsTile(textTheme, data['listings']);
                          })
                      : const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ])),
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

    // var favLists =
    // var name = widget.ds[2]['listing_address'];

    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      scrollDirection: Axis.vertical,
      itemCount: list.length,
      itemBuilder: (context, index) => InkWell(
        // onTap: list[index].onPress,
        onTap: () async {
          Get.to(() => ListingDetail(textTheme), arguments: list[index]);

          // print(allListingsBookmarkController.favList);
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Row(
            children: [
              Ink(
                width: 332,
                height: 200,
                // padding: const EdgeInsets.only(right: 5, top: 7),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F6F1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0),
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
                                    : const Icon(
                                        Icons.bookmark_border_outlined),
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
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
