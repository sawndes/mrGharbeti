import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:mr_gharbeti/src/screens/bills_landlord.dart';
import '../widgets/authentication/database_methods.dart';
import '../widgets/authentication/fire_auth.dart';
import '../widgets/chat/chat_screen_final.dart';
import '../widgets/dashboard_widgets/appBar_ui.dart';
import 'listing_details.dart';

class TenantPortal extends StatefulWidget {
  @override
  State<TenantPortal> createState() => _TenantPortalState();
}

class _TenantPortalState extends State<TenantPortal> {
  Stream<QuerySnapshot>? messageStream;

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

  getAndSetMessages() async {
    // chatRoomId = getChatRoomIdByUsernames(
    //   thisUser,
    //   chatWithUserName.toString(),
    // );
    var messageStream =
        await DatabaseMethods().getNotifications(username + '_' + 'thisUser');
    messageStream = await DatabaseMethods()
        .getChatRoomMessages(username + '_' + FireAuth.instance.user.uid);
    setState(() {});
  }

  // Widget chatMessages() {
  //   return StreamBuilder<QuerySnapshot>(
  //     stream: messageStream,
  //     builder: (context, snapshot) {
  //       return snapshot.hasData
  //           ? ListView.builder(
  //               padding: const EdgeInsets.only(bottom: 70, top: 16),
  //               itemCount: snapshot.data!.docs.length,
  //               // itemCount: snapshot.data,
  //               reverse: true,
  //               itemBuilder: (context, index) {
  //                 DocumentSnapshot ds = snapshot.data!.docs[index];
  //                 // return chatMessageTile(
  //                 //     ds["message"], thisUser == ds["sendBy"]);
  //               })
  //           : const Center(child: CircularProgressIndicator());
  //     },
  //   );
  // }

  @override
  void initState() {
    getThisUserInfo();
    getAndSetMessages();

    super.initState();
  }

  // const LandlordPortal({super.key});
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    var brightness = MediaQuery.of(context).platformBrightness;
    final isDark = brightness == Brightness.dark;
    var args = Get.arguments;
    String thisUser = FireAuth.instance.user.uid;

    return Scaffold(
      appBar: AppBarUI('Manage listings', true),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Welcome to Tenant portal',
                    style: textTheme.headline4,
                  ),
                  const SizedBox(
                    width: 80,
                  ),
                  // IconButton(
                  //   onPressed: () async {
                  //     print(username);
                  //     print(thisUser);

                  //     // print(messageStream);
                  //   },
                  //   icon: const Icon(Icons.notifications),
                  // )
                ],
              ),

              const SizedBox(
                height: 20,
              ),
              //Search Bar
              const SizedBox(
                height: 20,
              ),
              // DashBoardCategories(
              //   textTheme: textTheme,
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              //Banner
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //1st banner
                  Expanded(
                    child: ManageYourTenantButton(
                      animation_name: 'bills-animation.json',
                      textTheme: textTheme,
                      btnIcon: AssetImage('assets/images/login_ui.png'),
                      title: 'View bills',
                      paddingVertical: 20,
                      onTap: () {
                        Get.to(() => LandlordBills(), arguments: args);
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  //2nd Banner
                  Expanded(
                    child: ManageYourTenantButton(
                      animation_name: 'ecommerce-animation.json',
                      textTheme: textTheme,
                      btnIcon: AssetImage('assets/images/login_ui.png'),
                      title: 'View Listing',
                      paddingVertical: 20,
                      onTap: () {
                        print(args);
                        Get.to(() => ListingDetail(textTheme), arguments: args);

                        // print(listname);
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Expanded(
                    child: ManageYourTenantButtonn(
                      animation_name: 'chat-animation.json',
                      textTheme: textTheme,
                      btnIcon: AssetImage('assets/images/login_ui.png'),
                      title: 'Chat with Landlord',
                      paddingVertical: 10,
                      onTap: () {
                        var chatRoomId = getChatRoomIdByUsernames(
                          thisUser,
                          args['listings_user'],
                        );
                        Map<String, dynamic> chatRoomInfoMap = {
                          "users": [thisUser, args['listings_user']]
                        };

                        DatabaseMethods()
                            .createChatRoom(chatRoomId, chatRoomInfoMap);

                        Get.to(() => FinalChatScreen(), arguments: [
                          profilePicUrl,
                          name,
                          args['listings_user'],
                          chatRoomId
                        ]);
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  // Expanded(
                  //   child: ManageYourTenantButton(
                  //     textTheme: textTheme,
                  //     animation_name: 'notifications-animation.json',
                  //     btnIcon: AssetImage('assets/images/login_ui.png'),
                  //     title: 'All Notifications',
                  //     paddingVertical: 20,
                  //     onTap: () {},
                  //   ),
                  // )
                ],
              )
              // DashboardTopListings(textTheme: textTheme),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          payWithKhalti();
          // Get.to(() => const AddBillsPage());
        },
        label: const Text('Pay with khalti'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.black,
      ),
    );
  }

  payWithKhalti() {
    // KhaltiScope.of
    KhaltiScope.of(context).pay(
      config: PaymentConfig(
          amount: 1000,
          productIdentity: "Landlord Payment",
          productName: "Rent"),
      preferences: [PaymentPreference.khalti],
      onSuccess: onSucess,
      onFailure: onFailure,
      onCancel: onCancel,
    );
  }

  void onSucess(PaymentSuccessModel sucess) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Payment Successful'),
            actions: [
              SimpleDialogOption(
                child: Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  void onFailure(PaymentFailureModel failure) {
    debugPrint(failure.toString());
  }

  void onCancel() {
    debugPrint("Cancelled");
  }
}

class ManageYourTenantButton extends StatelessWidget {
  const ManageYourTenantButton({
    required this.btnIcon,
    required this.title,
    required this.paddingVertical,
    // required this.subtitle,
    required this.animation_name,
    required this.onTap,
    required this.textTheme,
    Key? key,
  }) : super(key: key);
  final TextTheme textTheme;
  final double paddingVertical;
  final AssetImage btnIcon;
  final String title;
  final String animation_name;
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
                  // 'animation/manage_animation.json',
                  'animation/$animation_name',
                  height: 150,
                )),
              ],
            ),
            const SizedBox(height: 25),
            Text(title,
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

class ManageYourTenantButtonn extends StatelessWidget {
  const ManageYourTenantButtonn({
    required this.btnIcon,
    required this.title,
    required this.paddingVertical,
    // required this.subtitle,
    required this.animation_name,
    required this.onTap,
    required this.textTheme,
    Key? key,
  }) : super(key: key);
  final TextTheme textTheme;
  final double paddingVertical;
  final AssetImage btnIcon;
  final String title;
  final String animation_name;
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
                        alignment: Alignment.centerRight,
                        // 'animation/manage_animation.json',
                        'animation/$animation_name',
                        height: 150,
                        width: 200)),
              ],
            ),
            const SizedBox(height: 25),
            Text(title,
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
    // required this.subtitle,
    required this.onTap,
    required this.textTheme,
    Key? key,
    required this.paddingVertical,
  }) : super(key: key);
  final TextTheme textTheme;
  final double paddingVertical;
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
              children: const [
                // Flexible(child: Icon(Icons.bookmark_border)),
                Flexible(
                    child:
                        Image(image: AssetImage('assets/images/login_ui.png'))),
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

class DashboardSearchbarUI extends StatefulWidget {
  const DashboardSearchbarUI({
    Key? key,
    required this.textTheme,
  }) : super(key: key);

  final TextTheme textTheme;

  @override
  State<DashboardSearchbarUI> createState() => _DashboardSearchbarUIState();
}

class _DashboardSearchbarUIState extends State<DashboardSearchbarUI> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Get.to(() => SearchPage(textTheme: widget.textTheme));
      },
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            left: BorderSide(width: 4),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Search...',
              style: widget.textTheme.headline2
                  ?.apply(color: Colors.grey.withOpacity(0.5)),
            ),
            // const Icon(
            //   Icons.mic,
            //   size: 25,
            // )
          ],
        ),
      ),
    );
  }
}
