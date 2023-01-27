// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';

// import '../widgets/authentication/database_methods.dart';

// class ProfileController extends GetxController {
//   final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
//   Map<String, dynamic> get user => _user.value;
//   Rx<String> name = ''.obs;
//   Rx<String> profilePic = ''.obs;

//   final Rx<String> _uid = "".obs;

//   updateUserId(String uid) {
//     _uid.value = uid;
//     // getmyInfo();
//     getUserData();
//   }

//   @override
//   void onInit() {
//     super.onInit();

//     // getmyInfo();
//   }

//   // getmyInfo() async {
//   //   QuerySnapshot querySnapshot =
//   //       await DatabaseMethods().getUserInfo(_uid.value);
//   //   name = querySnapshot.docs[0]['name'] as Rx<String>;
//   //   profilePic = querySnapshot.docs[0]['imgUrl'] as Rx<String>;
//   //   _user.value = {
//   //     'name': name,
//   //     'profilePic': profilePic,
//   //   };
//   //   update();
//   //   // setState(() {});
//   // }

//   getUserData() async {
//     DocumentSnapshot userDoc = await FirebaseFirestore.instance
//         .collection('users')
//         .doc(_uid.value)
//         .get();
//     final userData = userDoc.data()! as dynamic;
//     String name = userData['fullName'];
//     String email = userData['email'];
//     _user.value = {
//       'name': name,
//       'email': email,
//     };
//     // userData['id'];
//     // String fullname = userData['fullName'];

//     update();
//   }
// }
