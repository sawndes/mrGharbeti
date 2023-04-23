import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_gharbeti/src/screens/add_bills.dart';
import 'package:mr_gharbeti/src/screens/bill_view.dart';
import 'package:mr_gharbeti/src/widgets/dashboard_widgets/appBar_ui.dart';

import '../controller/all_listings_bookmark_controller.dart';
import '../widgets/authentication/database_methods.dart';
import '../widgets/authentication/fire_auth.dart';
import '../widgets/dashboard_widgets/top_listings_ui.dart';
import 'listing_details.dart';

class LandlordBills extends StatefulWidget {
  const LandlordBills({super.key});

  @override
  State<LandlordBills> createState() => _LandlordBillsState();
}

class _LandlordBillsState extends State<LandlordBills> {
  Stream<DocumentSnapshot<Map<String, dynamic>>>? listingStream, billsStream;
  String thisUser = FireAuth.instance.user.uid;
  getListings() async {
    listingStream = (await DatabaseMethods().getListings());
    // favListStream = await DatabaseMethods().getFavListings(thisUser);
    setState(() {});
  }

  getBills() async {
    billsStream = (await DatabaseMethods().getBills());
    // favListStream = await DatabaseMethods().getFavListings(thisUser);
    setState(() {});
  }

  onScreenLoaded() async {
    getListings();
    getBills();
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
      appBar: AppBarUI('Bills', true),
      // body: const Center(
      //   child: Text('There is no bills added!'),
      // ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                // stream: listingStream,
                stream: billsStream,
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
                            // List<dynamic> listings = data['listings'];
                            List<dynamic> bills = data['bills'];

                            List filteredBills = bills
                                .where((listing) =>
                                    listing['listings_user'] == thisUser)
                                .toList();
                            // return Center(
                            //   child: Text(filteredBills.toString()),
                            // );
                            return AllBillsTile(textTheme, filteredBills);
                            // return AllListingsTile(textTheme, filteredListings);
                            // return AllListingsTile(textTheme, bills);
                          })
                      : const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => const AddBillsPage());
        },
        label: const Text('Add Bills'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }
}

class AllBillsTile extends StatelessWidget {
  final List ds;
  final TextTheme textTheme;
  const AllBillsTile(this.textTheme, this.ds) : super();

  @override
  Widget build(BuildContext context) {
    var list = ds;
    String thisUser = FireAuth.instance.user.uid;

    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      scrollDirection: Axis.vertical,
      itemCount: list.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          Get.to(() => BillView(), arguments: list[index]);
          // handle card click
        },
        splashColor: Theme.of(context).accentColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Ink(
            decoration: BoxDecoration(
              color: const Color(0xFFF7F6F1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 4,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: Image.network(
                      list[index]['bill_photo'][0],
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fill,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      list[index]['bill_name'],
                      style: const TextStyle(fontSize: 20),
                    ),
                    trailing: Text(
                      "Rs " + list[index]['bill_price'],
                      style: const TextStyle(fontSize: 20),
                    ),
                    subtitle: Text(list[index]['description']),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
