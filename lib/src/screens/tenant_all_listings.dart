import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_gharbeti/src/screens/tenant_portal.dart';
import 'package:mr_gharbeti/src/widgets/dashboard_widgets/appBar_ui.dart';

import '../widgets/authentication/database_methods.dart';
import '../widgets/authentication/fire_auth.dart';
import 'listing_details.dart';

class TenantAllListings extends StatefulWidget {
  const TenantAllListings({
    super.key,
    required this.textTheme,
  });
  final TextTheme textTheme;

  @override
  State<TenantAllListings> createState() => _TenantAllListingsState();
}

class _TenantAllListingsState extends State<TenantAllListings> {
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
              'Your Rentings',
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
                                    listing['rent_user'] == thisUser)
                                .toList();
                            if (favoriteListings.isEmpty) {
                              return const Center(
                                child: Text(
                                    'You have not been added as tenants to any listings'),
                              );
                            } else {
                              return AllListingsTile(
                                  textTheme, favoriteListings);
                            }
                            // return Center(
                            //   child: CircularProgressIndicator(),
                            // );
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

class AllListingsTile extends StatelessWidget {
  final List ds;
  // final Map<String, dynamic> favs;
  // final int favs;
  final TextTheme textTheme;
  const AllListingsTile(this.textTheme, this.ds, {super.key});

  @override
  Widget build(BuildContext context) {
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
          Get.to(() => TenantPortal(), arguments: list[index]);
          // print(list[index]);
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
