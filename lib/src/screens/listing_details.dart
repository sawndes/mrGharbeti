import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mr_gharbeti/src/screens/dashboard.dart';

import 'package:mr_gharbeti/src/widgets/dashboard_widgets/appBar_ui.dart';

import '../widgets/authentication/database_methods.dart';
import '../widgets/authentication/fire_auth.dart';
import '../widgets/chat/chat_screen_final.dart';

class ListingDetail extends StatefulWidget {
  const ListingDetail(this.textTheme, {super.key});
  final TextTheme textTheme;

  @override
  State<ListingDetail> createState() => _ListingDetailState();
}

class _ListingDetailState extends State<ListingDetail> {
  int currentPos = 0;
  List<String> listPaths = [
    "assets/images/house1.jpg",
    "assets/images/house2.jpg",

    // "assets/images/house2.jpg",
    // "assets/images/house2.jpg",
    // "assets/images/house2.jpg",
  ];

  getChatRoomIdByUsernames(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  String profilePicUrl = "", name = "", username = "";

  getThisUserInfo() async {
    username = Get.arguments['listings_user'];
    QuerySnapshot querySnapshot = await DatabaseMethods().getUserInfo(username);
    print(
        "something bla bla ${querySnapshot.docs[0].id} ${querySnapshot.docs[0]["name"]}  ${querySnapshot.docs[0]["imgUrl"]}");
    name = "${querySnapshot.docs[0]["name"]}";
    profilePicUrl = "${querySnapshot.docs[0]["imgUrl"]}";
    setState(() {});
  }

  @override
  void initState() {
    getThisUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var arguments = Get.arguments;
    String thisUser = FireAuth.instance.user.uid;

    return Scaffold(
      appBar: AppBarUI(arguments['listing_name'], true),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   width: double.infinity,
            //   height: 300,
            //   decoration: BoxDecoration(
            //     color: Colors.grey.shade400,
            //     borderRadius: BorderRadius.circular(16),
            //     image: DecorationImage(
            //       image: NetworkImage(arguments['listing_photo']),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                arguments['listing_photo'].length == 1
                    ? Container(
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: NetworkImage(arguments['listing_photo'][0]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : CarouselSlider.builder(
                        itemCount: arguments['listing_photo'].length,
                        options: CarouselOptions(
                            height: 300,
                            autoPlay: true,
                            onPageChanged: (index, reason) {
                              setState(() {
                                currentPos = index;
                              });
                            }),
                        itemBuilder: (context, index, x) {
                          // listPaths.add(arguments['listing_photo']);

                          return MyImageView(arguments['listing_photo'][index]);
                        },
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // children: [
                  //   arguments['listing_photo'].map((url) {
                  //     int index = listPaths.indexOf(url);
                  //   })
                  // ],
                  children: arguments['listing_photo'].map<Widget>((url) {
                    int index = arguments['listing_photo'].indexOf(url);
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: currentPos == index
                            ? const Color.fromRGBO(0, 0, 0, 0.9)
                            : const Color.fromRGBO(0, 0, 0, 0.4),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              arguments['description'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 23,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              arguments['listing_name'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.grey,
                ),
                Text(
                  arguments['listing_address'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rs ${arguments['listing_price']} per month',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.bookmark_border_outlined),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            // !(thisUser == Get.arguments['listings_user']) ||
            if (((Get.arguments['rent_user'].length == 0)) &&
                !(thisUser == Get.arguments['listings_user'])) ...[
              // ?
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment,
                    children: [
                      SizedBox(
                        width: 240,
                        child: ElevatedButton(
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection("listings")
                                .doc("all_listings")
                                .get()
                                .then((documentSnapshot) async {
                              var listings =
                                  documentSnapshot.data()!['listings'];
                              var index = listings.indexWhere((listing) =>
                                  // listing["favorites"] == fav &&
                                  listing["listing_id"] ==
                                  arguments['listing_id']);

                              if (index != -1) {
                                if (listings[index]['rent_requests']
                                    .contains(thisUser)) {
                                  print('');
                                } else {
                                  listings[index]['rent_requests']
                                      .add(thisUser);
                                }
                                // FieldValue.arrayUnion([thisUser]);
                              }
                              return FirebaseFirestore.instance
                                  .collection("listings")
                                  .doc("all_listings")
                                  .update({"listings": listings});
                            });
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Request sent"),
                                  content: const Text(
                                      "Your request has been sent to the listing owner."),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      child: Text("OK"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: const Text('Rent'),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 100,
                        child: OutlinedButton(
                          onPressed: () {
                            print(arguments['listings_user']);

                            var chatRoomId = getChatRoomIdByUsernames(
                              thisUser,
                              arguments['listings_user'],
                            );
                            Map<String, dynamic> chatRoomInfoMap = {
                              "users": [thisUser, arguments['listings_user']]
                            };

                            DatabaseMethods()
                                .createChatRoom(chatRoomId, chatRoomInfoMap);

                            Get.to(() => FinalChatScreen(), arguments: [
                              profilePicUrl,
                              name,
                              arguments['listings_user'],
                              chatRoomId
                            ]);
                          },
                          child: const Text('Chat'),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ] else if ((thisUser == Get.arguments['listings_user']) &&
                !(Get.arguments['rent_user'].length == 0)) ...[
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment,
                    children: [
                      SizedBox(
                        width: 220,
                        child: ElevatedButton(
                          onPressed: () async {
                            // await FirebaseFirestore.instance
                            //     .collection("listings")
                            //     .doc("all_listings")
                            //     .get()
                            //     .then((documentSnapshot) async {
                            //   var listings =
                            //       documentSnapshot.data()!['listings'];
                            //   var index = listings.indexWhere((listing) =>
                            //       // listing["favorites"] == fav &&
                            //       listing["listing_id"] ==
                            //       arguments['listing_id']);

                            //   return FirebaseFirestore.instance
                            //       .collection("listings")
                            //       .doc("all_listings")
                            //       .update({"listings": listings});
                            // });
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Delete Listing"),
                                  content: const Text(
                                      "Are you sure you want to remove this listing?"),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      child: Text("Yes"),
                                      onPressed: () async {
                                        final collectionRef = FirebaseFirestore
                                            .instance
                                            .collection('listings');
                                        final docRef =
                                            collectionRef.doc('all_listings');

                                        docRef.get().then((doc) {
                                          if (doc.exists) {
                                            List<dynamic> listings =
                                                doc['listings'];
                                            if (listings.isNotEmpty) {
                                              List<dynamic> firstElement = [
                                                listings[4]
                                              ];
                                              docRef.update({
                                                'listings':
                                                    FieldValue.arrayRemove(
                                                        firstElement)
                                              });
                                            } else {
                                              print(
                                                  'The listings array is empty');
                                            }
                                          } else {
                                            print(
                                                'The document does not exist');
                                          }
                                        });
                                        Get.back();
                                        Get.back();
                                      },
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('No'))
                                  ],
                                );
                              },
                            );
                          },
                          child: const Text('Delete Listing'),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 120,
                        child: OutlinedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Remove Tenant?"),
                                  content: const Text(
                                      "Are you sure you want to remove tenant?"),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      child: Text("Yes"),
                                      onPressed: () async {
                                        await FirebaseFirestore.instance
                                            .collection("listings")
                                            .doc("all_listings")
                                            .get()
                                            .then((documentSnapshot) async {
                                          var listings = documentSnapshot
                                              .data()!['listings'];
                                          var index = listings.indexWhere(
                                              (listing) =>
                                                  // listing["favorites"] == fav &&
                                                  listing["listing_id"] ==
                                                  arguments['listing_id']);
                                          listings[index]["rent_user"] = "";
                                          print(listings[index]['rent_user']);

                                          return FirebaseFirestore.instance
                                              .collection("listings")
                                              .doc("all_listings")
                                              .update({"listings": listings});
                                        });

                                        // Get.back();
                                        // Get.back();
                                        Get.offAll(() => DashBoard());
                                      },
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('No'))
                                  ],
                                );
                              },
                            );
                          },
                          child: Text('Remove tenant'),
                        ),
                      )
                    ],
                  ),
                ),
              )

              // const Text(
              //   'This listing is not available to rent. So, it will not be shown on ecommerce page',
              //   style: TextStyle(
              //     color: Colors.red,
              //   ),
              // )
            ]

            // :
            else if ((thisUser == Get.arguments['listings_user'])) ...[
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment,
                    children: [
                      SizedBox(
                        width: 350,
                        child: ElevatedButton(
                          onPressed: () async {
                            // await FirebaseFirestore.instance
                            //     .collection("listings")
                            //     .doc("all_listings")
                            //     .get()
                            //     .then((documentSnapshot) async {
                            //   var listings =
                            //       documentSnapshot.data()!['listings'];
                            //   var index = listings.indexWhere((listing) =>
                            //       // listing["favorites"] == fav &&
                            //       listing["listing_id"] ==
                            //       arguments['listing_id']);

                            //   return FirebaseFirestore.instance
                            //       .collection("listings")
                            //       .doc("all_listings")
                            //       .update({"listings": listings});
                            // });
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Delete Listing"),
                                  content: const Text(
                                      "Are you sure you want to remove this listing?"),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      child: Text("Yes"),
                                      onPressed: () async {
                                        final collectionRef = FirebaseFirestore
                                            .instance
                                            .collection('listings');
                                        final docRef =
                                            collectionRef.doc('all_listings');

                                        docRef.get().then((doc) {
                                          if (doc.exists) {
                                            List<dynamic> listings =
                                                doc['listings'];
                                            if (listings.isNotEmpty) {
                                              List<dynamic> firstElement = [
                                                listings[4]
                                              ];
                                              docRef.update({
                                                'listings':
                                                    FieldValue.arrayRemove(
                                                        firstElement)
                                              });
                                            } else {
                                              print(
                                                  'The listings array is empty');
                                            }
                                          } else {
                                            print(
                                                'The document does not exist');
                                          }
                                        });
                                        Get.back();
                                        Get.back();
                                      },
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('No'))
                                  ],
                                );
                              },
                            );
                          },
                          child: const Text('Delete Listing'),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}

class MyImageView extends StatelessWidget {
  String imgPath;

  MyImageView(this.imgPath, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        // color: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(imgPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
