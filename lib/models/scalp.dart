import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Scalp{
  Map<String, dynamic>? top;
  Map<String, dynamic>? back;
  Map<String, dynamic>? right;
  Map<String, dynamic>? left;

  DocumentReference? reference;

  Scalp( {this.top,this.back, this.right, this.left,this.reference});

  factory Scalp.fromSnapshot(DocumentSnapshot snapshot) {
    Scalp newScalp = Scalp.fromJson(snapshot.data() as Map<String, dynamic>?);
    newScalp.reference = snapshot.reference;
    return newScalp;
  }

  factory Scalp.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Scalp(); // Handle the case where JSON is null
    }


    final top = json['Top'] as Map<String, dynamic>?;
    final back = json['Back'] as Map<String, dynamic>?;
    final right = json['Right'] as Map<String, dynamic>?; // Parse the review map
    final left = json['Left'] as Map<String, dynamic>?; // Parse the review map


    return Scalp(top:top, back:back, right:right, left:left);
  }

  @override
  String toString() => "Scalp<$top, $back, $right, $left>";
}


