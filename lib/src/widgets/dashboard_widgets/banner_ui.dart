import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mr_gharbeti/src/models/user_model.dart';
import 'package:mr_gharbeti/src/screens/all_listings.dart';
import 'package:mr_gharbeti/src/screens/listing_details.dart';
import 'package:mr_gharbeti/src/screens/manage_all_listings.dart';
import 'package:mr_gharbeti/src/screens/search_page.dart';
import 'package:mr_gharbeti/src/widgets/firestore/user_firestore.dart';

import '../../screens/tenant_all_listings.dart';
import '../auth_sign_in_btn_widget.dart';

class DashboardBannerUI extends StatefulWidget {
  const DashboardBannerUI({
    Key? key,
    required this.textTheme,
  }) : super(key: key);

  // final bool isDark;
  final TextTheme textTheme;

  @override
  State<DashboardBannerUI> createState() => _DashboardBannerUIState();
}

class _DashboardBannerUIState extends State<DashboardBannerUI> {
  String listing_name = 'NO LISTINGS', address = 'NO LISTINGS';
  List? infoListings;

  Future<List?> retrieveDescription() async {
    List listings;
    List? x;
    await FirebaseFirestore.instance
        .collection("listings")
        .doc("all_listings")
        .get()
        .then((documentSnapshot) {
      listings = documentSnapshot.data()!['listings'].toList();
      listings =
          listings.where((listing) => listing['rent_user'] == '').toList();
      // .where((listing) => listing['rent_user'].length == 0);
      infoListings = listings;
      listing_name = listings[0]['listing_name'];
      address = listings[0]['listing_address'];
      // return documentSnapshot.data()!['listings'];
    });
    setState(() {});
    // return [description];
  }

  @override
  void initState() {
    // Future<List?> x = retrieveDescription();
    retrieveDescription();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // List listings = getAddressandtitle().data['listings'];
    var brightness = MediaQuery.of(context).platformBrightness;
    final isDark = brightness == Brightness.dark;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //1st banner
        Expanded(
          child: ManageYourTenantButton(
            textTheme: widget.textTheme,
            btnIcon: AssetImage('assets/images/login_ui.png'),
            title: 'Manage your tenant here',
            paddingVertical: 20,
            onTap: () {
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                context: context,
                builder: (context) => Container(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Make Selection',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      Text(
                        style: Theme.of(context).textTheme.bodyText1,
                        'Select one of the options given below to go to portals',
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SignInAllButtons(
                        btnIcon: Icons.manage_accounts,
                        title: 'Landlord',
                        subtitle: 'Go to landlord Portal',
                        onTap: () {
                          Get.to(() => ManageAllListings(
                                textTheme: widget.textTheme,
                              ));
                          // print('dsasd');
                          // FireAuth().signInWithGoogle();
                          // Navigator.of(context).pop();
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => ForgotPasswordMailScreen()));
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SignInAllButtons(
                        btnIcon: Icons.people_sharp,
                        title: 'Tenant',
                        subtitle: 'Go to tenant Portal',
                        onTap: () {
                          Get.to(() =>
                              TenantAllListings(textTheme: widget.textTheme));
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 20),
        //2nd Banner
        Expanded(
          child: Column(
            children: [
              //Card
              MainViewApartment(
                  // photoUrl: infoListings![0]['listing_photo'][0],
                  listingName: listing_name,
                  address: address,
                  onTap: () {
                    Get.to(() => ListingDetail(widget.textTheme),
                        arguments: infoListings![0]);
                  },
                  textTheme: widget.textTheme,
                  paddingVertical: 35),

              const SizedBox(height: 5),
            ],
          ),
        ),
      ],
    );
  }
}

class ManageYourTenantButton extends StatelessWidget {
  const ManageYourTenantButton({
    required this.btnIcon,
    required this.title,
    required this.paddingVertical,
    // required this.subtitle,
    required this.onTap,
    required this.textTheme,
    Key? key,
  }) : super(key: key);
  final TextTheme textTheme;
  final double paddingVertical;
  final AssetImage btnIcon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        padding:
            EdgeInsets.symmetric(horizontal: 10, vertical: paddingVertical),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFF7F6F1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Lottie.asset(
                    alignment: Alignment.center,
                    'animation/manage_animation.json',
                    height: 150,
                  ),
                  // Icon(Icons.house)
                  //     Image(
                  //   image: btnIcon,
                  // ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Text('Manage your tenants here',
                style: textTheme.headline4,
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis),
            // Text('Naxal-8, Kathmandu',
            //     style: textTheme.bodyText2,
            //     maxLines: 1,
            //     overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}

class MainViewApartment extends StatelessWidget {
  const MainViewApartment({
    // required this.btnIcon,
    required this.listingName,
    required this.address,
    // required this.photoUrl,
    // required this.subtitle,
    required this.onTap,
    required this.textTheme,
    Key? key,
    required this.paddingVertical,
  }) : super(key: key);
  final TextTheme textTheme;
  final double paddingVertical;
  // final String photoUrl;
  // final AssetImage btnIcon;
  final String listingName, address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        padding:
            EdgeInsets.symmetric(horizontal: 10, vertical: paddingVertical),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFF7F6F1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Flexible(child: Icon(Icons.bookmark_border)),
                Flexible(
                  child: Lottie.asset(
                    alignment: Alignment.center,
                    'animation/house_animation.json',
                    height: 150,
                  ),
                ),
              ],
            ),
            Text(listingName,
                style: textTheme.headline4, overflow: TextOverflow.ellipsis),
            Text(address,
                style: textTheme.bodyText2, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}
