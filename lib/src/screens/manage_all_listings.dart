import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mr_gharbeti/src/screens/dashboard.dart';
import 'package:mr_gharbeti/src/screens/landlord_portal.dart';
import 'package:mr_gharbeti/src/widgets/dashboard_widgets/appBar_ui.dart';

import '../controller/all_listings_bookmark_controller.dart';
import '../widgets/auth_sign_in_btn_widget.dart';
import '../widgets/authentication/database_methods.dart';
import '../widgets/authentication/fire_auth.dart';
import 'listing_details.dart';

class ManageAllListings extends StatefulWidget {
  const ManageAllListings({
    super.key,
    required this.textTheme,
  });
  final TextTheme textTheme;

  @override
  State<ManageAllListings> createState() => _ManageAllListingsState();
}

class _ManageAllListingsState extends State<ManageAllListings> {
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

    return Scaffold(
      appBar: AppBarUI('Select Listings', true),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Text(
              'Your Listings',
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
                          itemCount: snapshot.data!.data()!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> data = snapshot.data!.data()!;

                            List<dynamic> listings = data['listings'];

                            List favoriteListings = listings
                                .where((listing) =>
                                    listing['listings_user'] == thisUser)
                                .toList();

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

      // body: ,
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
  String name = '';
  Map<String, String> _usernameNameMap = {};

  Future<void> getUsernameNameMap() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').get();
    final List<DocumentSnapshot> documents = snapshot.docs;

    for (var document in documents) {
      final Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      _usernameNameMap[data['username']] = data['name'];
    }
    // print(_usernameNameMap);
    setState(() {});
  }

  @override
  void initState() {
    getUsernameNameMap();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String thisUser = FireAuth.instance.user.uid;

    var list = widget.ds;

    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      scrollDirection: Axis.vertical,
      itemCount: list.length,
      itemBuilder: (context, index) => InkWell(
        // onTap: list[index].onPress,
        onTap: () async {
          list[index]['rent_user'] == ''
              ? showModalAddTenant(context, list, index)
              : Get.to(() => LandlordPortal(), arguments: list[index]);
          // Get.to(()=>());
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
                              style: widget.textTheme.headline4,
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                list[index]['listing_price'] + ' per month',
                                style: widget.textTheme.headline4,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                list[index]['listing_address'],
                                style: widget.textTheme.bodyText2,
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

  Future<dynamic> showModalAddTenant(
      BuildContext context, List<dynamic> list, int index) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      context: context,
      builder: (context) =>
          StatefulBuilder(builder: (BuildContext context, StateSetter mystate) {
        void closeModal() {
          Navigator.of(context).pop();
        }

        return Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Make Selection',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    style: Theme.of(context).textTheme.bodyText1,
                    'Select user you want to add as your tenant.',
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              !(list[index]['rent_requests'].length == 0)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: const [
                                Expanded(
                                  child: Text(
                                    'Name',
                                    style: TextStyle(
                                      fontSize: 22,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Accept/Decline',
                                  style: TextStyle(
                                    fontSize: 22,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            ...List.generate(
                              list[index]['rent_requests'].length,
                              (i) {
                                return Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${_usernameNameMap[list[index]['rent_requests'][i]]}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.check,
                                        size: 30,
                                        color: Colors.green,
                                      ),
                                      onPressed: () {
                                        acceptOffer() async {
                                          await FirebaseFirestore.instance
                                              .collection("listings")
                                              .doc("all_listings")
                                              .get()
                                              .then((documentSnapshot) async {
                                            var listings = documentSnapshot
                                                .data()!['listings'];
                                            var indexxx = listings.indexWhere(
                                                (listing) =>
                                                    // listing["favorites"] == fav &&
                                                    listing["listing_id"] ==
                                                    list[index]['listing_id']);

                                            if (indexxx != -1) {
                                              listings[indexxx]['rent_user'] =
                                                  list[index]['rent_requests']
                                                      [i];
                                            }
                                            return FirebaseFirestore.instance
                                                .collection("listings")
                                                .doc("all_listings")
                                                .update({"listings": listings});
                                          });
                                          closeModal();
                                          // Navigator.of(context).pop();

                                          // Get.to(() => DashBoard());
                                        }

                                        setState(() {});

                                        continueCallBack() async => {
                                              await acceptOffer(),
                                              Navigator.of(context).pop(),
                                            };
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return BlurryDialog(
                                                "Confirm",
                                                "Are you sure you want to add this user as your tenant?",
                                                continueCallBack);
                                          },
                                        );
                                        // Perform the "Accept" action
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.clear,
                                        size: 30,
                                        color: Colors.red,
                                      ),
                                      onPressed: () async {
                                        declineOffer() async {
                                          await FirebaseFirestore.instance
                                              .collection("listings")
                                              .doc("all_listings")
                                              .get()
                                              .then((documentSnapshot) async {
                                            var listings = documentSnapshot
                                                .data()!['listings'];
                                            var indexxx = listings.indexWhere(
                                                (listing) =>
                                                    // listing["favorites"] == fav &&
                                                    listing["listing_id"] ==
                                                    list[index]['listing_id']);

                                            if (indexxx != -1) {
                                              listings[indexxx]['rent_requests']
                                                  .remove(list[index]
                                                      ['rent_requests'][i]);
                                            }
                                            return FirebaseFirestore.instance
                                                .collection("listings")
                                                .doc("all_listings")
                                                .update({"listings": listings});
                                          });
                                          closeModal();
                                          // Navigator.of(context).pop();

                                          // Get.to(() => DashBoard());
                                        }

                                        setState(() {});

                                        continueCallBack() async => {
                                              // print('Declined'),
                                              await declineOffer(),
                                              Navigator.of(context).pop(),
                                            };
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return BlurryDialog(
                                                "Confirm",
                                                "Are you sure you want to remove this user's proposal?",
                                                continueCallBack);
                                          },
                                        );

                                        // Perform the "Decline" action
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        )
                      ],
                    )
                  : const Text('No any tenants requests')
            ],
          ),
        );
      }),
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
                  // Get.to(() => DashBoard());
                },
              ),
            ),
          ],
        ));
  }
}
