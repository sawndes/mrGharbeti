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
  Stream<DocumentSnapshot<Map<String, dynamic>>>? favListStream;
  String thisUser = FireAuth.instance.user.uid;

  // Future<Future<DocumentSnapshot<Map<String, dynamic>>>>? listings;

  getListings() async {
    listingStream = (await DatabaseMethods().getListings());
    favListStream = await DatabaseMethods().getFavListings(thisUser);
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
                // stream: FirebaseFirestore.instance
                //     .collection('listings')
                //     .doc('all_listings')
                //     .snapshots(),
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

            // child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            //   stream: FirebaseFirestore.instance
            //       .collection('listings')
            //       .doc('all_listings')
            //       .snapshots(),
            //   builder: (BuildContext context,
            //       AsyncSnapshot<DocumentSnapshot> snapshot) {
            //     // if (snapshot.connectionState == ConnectionState.waiting) {
            //     //   return const Text("Loading");
            //     // }

            //     Map<String, dynamic> data =
            //         snapshot.data!.data()! as Map<String, dynamic>;
            //     return ListView(
            //         children: data['listings'].map<Widget>((e) {
            //       return ListTile(
            //         title: Text(e['description']
            //             .toString()), // 👈 printing every string
            //       );
            //     }).toList());
            //   },
            // ),
          ])

          // Expanded(
          //   // height: height * 0.8,
          //   child: ListView.builder(
          //     shrinkWrap: true,
          //     primary: false,
          //     scrollDirection: Axis.vertical,
          //     itemCount: list.length,
          //     itemBuilder: (context, index) => InkWell(
          //       // onTap: list[index].onPress,
          //       onTap: () {
          //         // print('object');
          //         Get.to(() => ListingDetail(textTheme),
          //             arguments: list[index]);
          //       },
          //       child: SizedBox(
          //         width: 320,
          //         height: 200,
          //         child: Padding(
          //           padding: const EdgeInsets.only(right: 10, top: 5),
          //           child: Container(
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(12),
          //               //For Dark Color
          //               color: isDark ? Color(0xFF272727) : Color(0xFFF7F6F1),
          //             ),
          //             padding: const EdgeInsets.all(10),
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                   children: [
          //                     Flexible(
          //                       child: Text(
          //                         list[index].title,
          //                         style: textTheme.headline4,
          //                         maxLines: 2,
          //                         overflow: TextOverflow.ellipsis,
          //                       ),
          //                     ),
          //                     Flexible(
          //                         child: Image(
          //                             image: AssetImage(list[index].image),
          //                             height: 110)),
          //                   ],
          //                 ),
          //                 Row(
          //                   children: [
          //                     ElevatedButton(
          //                         style: ElevatedButton.styleFrom(
          //                           shape: const CircleBorder(),
          //                         ),
          //                         onPressed: () {
          //                           // print('object');
          //                           // setState(() {
          //                           allListingsBookmarkController
          //                               .addBookmark(list[index]);
          //                           // });
          //                         },
          //                         child: GetBuilder<
          //                             AllListingsBookmarkController>(
          //                           builder: (_) =>
          //                               allListingsBookmarkController
          //                                       .getFav(list[index])
          //                                   ? const Icon(Icons.bookmark)
          //                                   : const Icon(Icons
          //                                       .bookmark_border_outlined),
          //                         )
          //                         // child: Obx(
          //                         //   () => allListingsBookmarkController
          //                         //           .listFavBool.value
          //                         //       ? const Icon(Icons.bookmark)
          //                         //       : const Icon(
          //                         //           Icons.bookmark_border_outlined)),
          //                         ),
          //                     const SizedBox(width: 20),
          //                     Column(
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       children: [
          //                         Text(
          //                           list[index].heading,
          //                           style: textTheme.headline4,
          //                           overflow: TextOverflow.ellipsis,
          //                         ),
          //                         Text(
          //                           list[index].subheading,
          //                           style: textTheme.bodyText2,
          //                           overflow: TextOverflow.ellipsis,
          //                         ),
          //                       ],
          //                     )
          //                   ],
          //                 )
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),

          ),
    );
  }
}

class AllListingsTile extends StatefulWidget {
  final List ds;
  // final Map<String, dynamic> favs;
  // final int favs;
  final TextTheme textTheme;
  const AllListingsTile(this.textTheme, this.ds, {super.key});

  @override
  State<AllListingsTile> createState() => _AllListingsTileState();
}

class _AllListingsTileState extends State<AllListingsTile> {
  @override
  Widget build(BuildContext context) {
    var list = widget.ds;
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
        onTap: () {
          // print(widget.favs);

          // print('object');
          // Get.to(() => ListingDetail(textTheme),
          //     arguments: list[index]);
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
                color: Color(0xFFF7F6F1),
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
                          list[index]['listing_name'],
                          style: widget.textTheme.headline4,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Flexible(
                          child: Image(
                              // image: AssetImage(list[index].image),
                              image: NetworkImage(list[index]['listing_photo']),
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
                          var fav = list[index]['favorites'][thisUser];
                          print(fav);
                          var listingId = list[index]['listing_id'];

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
                        },
                        child: list[index]['favorites'][thisUser]
                            ? const Icon(Icons.bookmark)
                            : const Icon(Icons.bookmark_border_outlined),

                        // child: widget.getFavValue()
                        //     ? Icon(Icons.bookmark)
                        //     : Icon(Icons.bookmark_border_outlined),
                        // child: GetBuilder<AllListingsBookmarkController>(
                        //   builder: (_) => allListingsBookmarkController
                        //           .getFav(list[index])
                        //       ? const Icon(Icons.bookmark)
                        //       : const Icon(Icons.bookmark_border_outlined),
                        // ),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            list[index]['listing_name'],
                            style: widget.textTheme.headline4,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            list[index]['listing_name'],
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
    );
  }
}

// class AllListingsTile extends StatefulWidget {
//   final List ds;
//   const AllListingsTile(this.ds, {super.key});

//   @override
//   State<AllListingsTile> createState() => _AllListingsTileState();
// }

// class _AllListingsTileState extends State<AllListingsTile> {
//   @override
//   Widget build(BuildContext context) {
//     var name = widget.ds[2]['listing_address'];
//     var len = widget.ds.length;
//     return ElevatedButton(
//         onPressed: () {
//           print(len);
//           // print(widget.ds['name']);
//         },
//         child: Text('sdasdas'));
//   }
// }
