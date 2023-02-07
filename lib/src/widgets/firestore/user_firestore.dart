import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_gharbeti/src/models/user_model.dart';
import 'package:mr_gharbeti/src/widgets/authentication/fire_auth.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  static final _db = FirebaseFirestore.instance;

  tryUpdateUI() async {
    //UserModel user) async {
    var xx = await _db
        .collection("users")
        .doc(FireAuth.instance.firebaseUser!.value!.uid)
        .get();
    return xx.data()!['name'].toString();

    // print((xx.data()!['email']));
    // user = UserModel(
    //     id: FireAuth.instance.firebaseUser.value!.uid,
    //     fullName: user.fullName,
    //     email: 'email',
    //     phoneNo: 'phoneNo',
    //     password: 'password');
    // print(user.id);
  }

  createUser(UserModel user) async {
    //   if ((await _db.collection("users").doc('Veta7YK4OkoZfGKviutF').get())
    //       .exists) {
    //     print('psych that\'s a wronnggg number haha kidding document exists');
    //   } else {
    await _db
        .collection("users")
        .doc(FireAuth.instance.firebaseUser!.value!.uid)
        .set({
          'id': FireAuth.instance.firebaseUser!.value!.uid,
          'fullName': user.fullName,
          'email': user.email,
          'phoneNo': user.phoneNo,
          'password': user.password
        })
        // .add({
        //   'id': FireAuth.instance.firebaseUser.value!.uid,
        //   'fullName': user.fullName,
        //   'email': user.email,
        //   'phoneNo': user.phoneNo,
        //   'password': user.password
        // })
        // .add(user.toJson())
        .whenComplete(
          () => Get.snackbar(
            'Sucess',
            'Your account has been created.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.1),
            colorText: Colors.green,
          ),
        )
        .catchError((error, stackTrace) {
          Get.snackbar(
            'Error',
            'Something went wrong. Try again',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent.withOpacity(0.1),
            colorText: Colors.red,
          );
          print("Firestore User Error: " + error.toString());
        });
  }
  // }
}
