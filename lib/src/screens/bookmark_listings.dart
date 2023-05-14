import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controller/all_listings_bookmark_controller.dart';
import '../widgets/authentication/database_methods.dart';
import '../widgets/authentication/fire_auth.dart';
import '../widgets/dashboard_widgets/appBar_ui.dart';
import '../widgets/dashboard_widgets/searchBar_ui.dart';
import 'listing_details.dart';

class BookmarkListings extends StatefulWidget {
  const BookmarkListings({Key? key}) : super(key: key);

  @override
  State<BookmarkListings> createState() => _BookmarkListingsState();
}

class _BookmarkListingsState extends State<BookmarkListings> {
  String thisUser = FireAuth.instance.user.uid;
  Stream<DocumentSnapshot<Map<String, dynamic>>>? favListStream;

  String? listings_user, address;

  getFavListings() async {
    favListStream = (await DatabaseMethods().getListings());
    // favListStream = await DatabaseMethods().getFavListings(thisUser);
    setState(() {});
  }

  onScreenLoaded() async {
    getFavListings();
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
      appBar: AppBarUI('Mr. Gharbeti', false),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Text(
              'Favorites',
              style: textTheme.headline2,
            ),
            const SizedBox(
              height: 20,
            ),
            //Search Bar

            Expanded(
              child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: favListStream,
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

                            List<dynamic> listings = data['listings'];

                            List favoriteListings = listings
                                .where((listing) =>
                                    listing['favorites']?[thisUser] ?? false)
                                // (listing) =>
                                //     listing['listings_user'] == thisUser)
                                .toList();

                            if (favoriteListings.isEmpty) {
                              return const Center(
                                child:
                                    Text('There is no favorites listings yet'),
                              );
                            }

                            return AllListingsTile(textTheme, favoriteListings);
                          })
                      : const Center(
                          child: CircularProgressIndicator(),
                        );
                },
              ),
            ),
          ],
        ),
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
    String thisUser = FireAuth.instance.user.uid;

    var list = ds;

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
                padding: const EdgeInsets.only(right: 5, top: 7),
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
                              continueCallBack() => {
                                    allListingsBookmarkController.bookmarkAdd(
                                        list, index, thisUser),
                                    Navigator.of(context).pop(),

                                    // code on continue comes here
                                  };

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return BlurryDialog(
                                      "Confirm",
                                      "Are you sure you want to remove this listings from favorites?",
                                      continueCallBack);
                                },
                              );
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

class BlurryDialog extends StatelessWidget {
  String title;
  String content;
  VoidCallback continueCallBack;

  BlurryDialog(this.title, this.content, this.continueCallBack, {super.key});
  TextStyle textStyle = const TextStyle(color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: AlertDialog(
          title: Text(
            title,
            style: textStyle,
          ),
          content: Text(
            content,
            style: textStyle,
          ),
          actions: <Widget>[
            SizedBox(
              width: 100,
              child: ElevatedButton(
                child: const Text("Continue"),
                onPressed: () {
                  continueCallBack();
                },
              ),
            ),
            SizedBox(
              width: 70,
              child: OutlinedButton(
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ));
  }
}
