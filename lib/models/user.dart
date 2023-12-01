import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Users {
  int? birth;
  String? sex;
  String? userID;
  String? userName;
  String? zipCode;

  DocumentReference? reference;

  Users(this.birth, this.sex, this.userID, this.userName, this.zipCode, {this.reference});

  factory Users.fromSnapshot(DocumentSnapshot snapshot) {
    Users newUsers= Users.fromJson(snapshot.data() as Map<String, dynamic>?);
    newUsers.reference = snapshot.reference;
    return newUsers;
  }

  // factory Products.fromJson(Map<String, dynamic>? json) => _ProductsFromJson(json);

  factory Users.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Users(null, null, null, null, null); // Handle the case where JSON is null
    }

    final birth = json['BIRTH'] as int?;
    final sex = json['SEX'] as String?;
    final userID = json['USER_ID'] as String?;
    final userName = json['USER_NM'] as String?;
    final zipCode = json['ZIPCD'] as String?;


    return Users(birth, sex, userID, userName, zipCode);
  }


  @override
  String toString() => "User<$birth, $sex, $userID, $userName, $zipCode>";
}


