import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mr_gharbeti/src/screens/listing_details.dart';
import 'package:mr_gharbeti/src/widgets/dashboard_widgets/appBar_ui.dart';
import '../widgets/authentication/fire_auth.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.textTheme});
  final TextTheme textTheme;

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  FocusNode _focusNode = FocusNode();
  final _searchController = TextEditingController();
  // List<Map<String, dynamic>> _listings = [];
  // Map<String, dynamic>> _filteredListings = [];
  List<dynamic> _listings = [];
  List<dynamic> _filteredListings = [];
  List<Map<String, dynamic>> data = [];
  String thisUser = FireAuth.instance.user.uid;

  void loadPage() async {
    await FirebaseFirestore.instance
        .collection('listings')
        .doc('all_listings')
        // .collection('listings')
        .get()
        .then((snapshot) {
      setState(() {
        Map<String, dynamic> data = snapshot.data()!;

        _listings = data['listings'];

        _filteredListings = _listings
            .where((listing) => listing['rent_user'].length == 0)
            .toList();
      });
    });
  }

  @override
  void initState() {
    _focusNode.requestFocus();
    loadPage();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterListings(String query) {
    setState(() {
      _filteredListings = _listings
          .where((listing) =>
              listing['description']
                  .toLowerCase()
                  .contains(query.toLowerCase()) ??
              false)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // AllListingsBookmarkController allListingsBookmarkController = Get.find();

    return Scaffold(
      appBar: AppBarUI('Search', true),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(width: 6),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.transparent),
                ),
                child: TextField(
                  focusNode: _focusNode,
                  style: widget.textTheme.headline2,
                  controller: _searchController,
                  decoration: const InputDecoration(
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Search...',
                    border: InputBorder.none,
                  ),
                  onChanged: (value) => _filterListings(value),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                scrollDirection: Axis.vertical,
                itemCount: _filteredListings.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> listing = _filteredListings[index];
                  // return ListTile(
                  //   title: Text(listing['description']?.toString() ?? ""
                  //       // title: Text(listing['description']
                  //       ),
                  // );
                  return InkWell(
                    // onTap: list[index].onPress,
                    onTap: () async {
                      Get.to(() => ListingDetail(widget.textTheme),
                          arguments: listing);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Row(
                        children: [
                          Ink(
                            width: 350,
                            height: 200,
                            padding: const EdgeInsets.only(right: 5, top: 7),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7F6F1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 18.0, right: 4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          listing['listing_name'],
                                          style: widget.textTheme.headline4,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Flexible(
                                          child: Image(
                                              // image: AssetImage(list[index].image),
                                              image: NetworkImage(
                                                  listing['listing_photo'][0]),
                                              height: 110)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(width: 20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            listing['listing_price'] +
                                                ' per month',
                                            style: widget.textTheme.headline4,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            listing['listing_address'],
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
                        ],
                      ),
                    ),
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
