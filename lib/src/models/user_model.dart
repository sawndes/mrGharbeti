import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String fullName;
  final String email;
  final String phoneNo;
  final String password;

  const UserModel({
    this.id,
    required this.fullName,
    required this.email,
    required this.phoneNo,
    required this.password,
  });

  toJson() {
    return {
      "id": '',
      "fullName": fullName,
      "fmail": email,
      "phoneNo": phoneNo,
      "password": password,
    };
  }

  // fromJSON(Map<String, dynamic> json) {
  //   return {
  //     id: json['id'],
  //     fullName: json['FullName'],
  //     email: json['email'],
  //     phoneNo: json['phoneNo'],
  //     password: password
  //   };
  // }

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      id: snapshot['id'],
      fullName: snapshot['FullName'],
      email: snapshot['email'],
      phoneNo: snapshot['phoneNo'],
      password: snapshot['password'],
    );
  }
}
