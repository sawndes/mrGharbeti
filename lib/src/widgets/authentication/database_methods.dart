import 'package:cloud_firestore/cloud_firestore.dart';

import '../../helper/sharedpref_helper.dart';
// import 'package:messenger_clone/helperfunctions/sharedpref_helper.dart';

class DatabaseMethods {
  Future addUserInfoToDB(
      String userId, Map<String, dynamic> userInfoMap) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .set(userInfoMap);
  }

  Future<Stream<QuerySnapshot>> getUserByUserName(String username) async {
    return FirebaseFirestore.instance
        .collection("users")
        .where("username", isEqualTo: username)
        .snapshots();
  }

  Future<QuerySnapshot> getUserInfo(String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("username", isEqualTo: username)
        .get();
  }

  Future addMessage(String chatRoomId, String messageId,
      Map<String, dynamic> messageInfoMap) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .doc(messageId)
        .set(messageInfoMap);
  }

  firstListingAdder() async {
    Map<String, dynamic> firstTimeListingsInfo = {"listings": []};

    final snapShot = await FirebaseFirestore.instance
        .collection("listings")
        .doc('all_listings')
        .get();
    // .set(firstTimeListingsInfo);

    if (snapShot.exists) {
      // chatroom already exists
      return true;
    } else {
      // chatroom does not exists
      return FirebaseFirestore.instance
          .collection("listings")
          .doc('all_listings')
          .set(firstTimeListingsInfo);
    }
  }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getChat(
      String uid) async {
    // String? myUsername = await SharedPreferenceHelper().getUserName();
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .orderBy("lastMessageSendTs", descending: true)
        .where("users", arrayContains: uid)
        .snapshots();
  }

  Future<Stream<DocumentSnapshot<Map<String, dynamic>>>> getListings() async {
    // String myUsername = await SharedPreferenceHelper().getUserName();
    // return FirebaseFirestore.instance.collection("listings").snapshots();
    return FirebaseFirestore.instance
        .collection('listings')
        .doc('all_listings')
        .snapshots();
    // return FirebaseFirestore.instance.collection("listings").doc("all_listings").get
  }

  Future<Stream<DocumentSnapshot<Map<String, dynamic>>>> getBills() async {
    // String myUsername = await SharedPreferenceHelper().getUserName();
    // return FirebaseFirestore.instance.collection("listings").snapshots();
    return FirebaseFirestore.instance
        .collection('bills')
        .doc('all_bills')
        .snapshots();
    // return FirebaseFirestore.instance.collection("listings").doc("all_listings").get
  }

  //   Future<Stream<DocumentSnapshot<Map<String, dynamic>>>> getListings() async {
  //   // String myUsername = await SharedPreferenceHelper().getUserName();
  //   // return FirebaseFirestore.instance.collection("listings").snapshots();
  // return FirebaseFirestore.instance
  //     .collection('listings')
  //     .doc('all_listings')
  //     .snapshots();
  //   // return FirebaseFirestore.instance.collection("listings").doc("all_listings").get
  // }

  // Future<Stream<DocumentSnapshot<Map<String, dynamic>>>> getFavListings (
  //     String uid) async {
  //   String userId = "21GJW3e0UpUkQdOx5H6iWaDdyLt1";
  //   FirebaseFirestore.instance
  //       .collection("listings")
  //       .doc("all_listings")
  //       .get()
  //       .then((documentSnapshot) {
  //     var listings = documentSnapshot.data()!['listings'];
  //     var favorites =
  //         listings.where((listing) => listing["favorites"][userId] == true);
  //     // do something with the favorite listings
  //     return listings;
  //   });
  // }
  Future<List<dynamic>> getFavListings(String uid) async {
    String userId = uid;
    return await FirebaseFirestore.instance
        .collection("listings")
        .doc("all_listings")
        .get()
        .then((documentSnapshot) {
      var listings = documentSnapshot.data()!['listings'];
      var favorites = listings
          .where((listing) => listing["favorites"][userId] == true)
          .toList();

      return favorites;
    });
    // return f;
  }

  // final Map<String, bool> userMap = await getUserMap();
  // print(userMap);

  // Future addFavListings(String uid, String listingId) async {
  //   final snapShot =
  //       await FirebaseFirestore.instance.collection("favorites").doc(uid).get();
  //   if (snapShot.exists) {
  //     // listings has been added before already exists
  //     return FirebaseFirestore.instance
  //         .collection("favorites")
  //         .doc(uid)
  //         .update({
  //       'listings': FieldValue.arrayUnion([
  //         {listingId: false}
  //       ])
  //     });
  //     // return true;
  //   } else {
  //     // chatroom does not exists
  //     return FirebaseFirestore.instance.collection("favorites").doc(uid).set({
  //       'listings': FieldValue.arrayUnion([
  //         {listingId: false}
  //       ])
  //     });
  //     // .set(listingsInfoMap);
  //   }
  // }

  Future addListings(String uid, Map<String, dynamic> listingsInfoMap) async {
    final QuerySnapshot qSnap =
        await FirebaseFirestore.instance.collection('listings').get();
    final int documents = qSnap.docs.length + 1;

    final snapShot = await FirebaseFirestore.instance
        .collection("listings")
        .doc('all_listings')
        .get();
    // .set(firstTimeListingsInfo);

    if (snapShot.exists) {
      // listings has been added before already exists
      return FirebaseFirestore.instance
          .collection("listings")
          .doc('all_listings')
          // .collection('listings')
          // .doc(documents.toString())

          .update({
        'listings': FieldValue.arrayUnion([listingsInfoMap])
      });
      // return true;
    } else {
      // chatroom does not exists
      return FirebaseFirestore.instance
          .collection("listings")
          .doc('all_listings')
          .set({
        'listings': FieldValue.arrayUnion([listingsInfoMap])
      });
      // .set(listingsInfoMap);
    }
  }

  Future addBills(String uid, Map<String, dynamic> listingsInfoMap) async {
    final QuerySnapshot qSnap =
        await FirebaseFirestore.instance.collection('bills').get();
    final int documents = qSnap.docs.length + 1;

    final snapShot = await FirebaseFirestore.instance
        .collection("bills")
        .doc('all_bills')
        .get();
    // .set(firstTimeListingsInfo);

    if (snapShot.exists) {
      // listings has been added before already exists
      return FirebaseFirestore.instance.collection("bills").doc('all_bills')
          // .collection('listings')
          // .doc(documents.toString())

          .update({
        'bills': FieldValue.arrayUnion([listingsInfoMap])
      });
      // return true;
    } else {
      // chatroom does not exists
      return FirebaseFirestore.instance
          .collection("bills")
          .doc('all_bills')
          .set({
        'bills': FieldValue.arrayUnion([listingsInfoMap])
      });
      // .set(listingsInfoMap);
    }
  }

  updateLastMessageSend(
      String chatRoomId, Map<String, dynamic> lastMessageInfoMap) {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .update(lastMessageInfoMap);
  }

  createChatRoom(
      String chatRoomId, Map<String, dynamic> chatRoomInfoMap) async {
    final snapShot = await FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .get();

    if (snapShot.exists) {
      // chatroom already exists
      return true;
    } else {
      // chatroom does not exists
      return FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(chatRoomId)
          .set(chatRoomInfoMap);
    }
  }

  Future<Stream<QuerySnapshot>> getChatRoomMessages(chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("ts", descending: true)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getChatRooms(String uid) async {
    // String? myUsername = await SharedPreferenceHelper().getUserName();
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .orderBy("lastMessageSendTs", descending: true)
        .where("users", arrayContains: uid)
        .snapshots();
  }
}
