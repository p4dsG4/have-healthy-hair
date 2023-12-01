import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Products {
  String? ingredients;
  int? reviewCnt;
  double? score;
  String? imagePath;
  String? name;
  Map<String, dynamic>? review; // Added field to represent the review
String? id;


  DocumentReference? reference;

  Products(this.ingredients, this.reviewCnt, this.score, this.imagePath, this.name, this.id, {this.review, this.reference});

  factory Products.fromSnapshot(DocumentSnapshot snapshot) {
    Products newProducts = Products.fromJson(snapshot.data() as Map<String, dynamic>?);
    newProducts.reference = snapshot.reference;
    return newProducts;
  }

  factory Products.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Products(null, null, null, null, null, null); // Handle the case where JSON is null
    }

    final ingredients = json['components'] as String?;
    final reviewCnt = json['review_cnt'] as int?;
    final score = json['score'] is double ? json['score'] as double : null;
    String? imagePath;
    final name = json['name'] as String?;
    final review = json['review'] as Map<String, dynamic>?; // Parse the review map
    final id = json['TF'] as String?;


    final imageRef = json['image'];
    if (imageRef is DocumentReference) {
      imagePath = imageRef.path;
    } else {
      imagePath = json['image'] as String?;
    }

    return Products(ingredients, reviewCnt, score, imagePath, name, id, review: review);
  }

  @override
  String toString() => "Product<$ingredients, $reviewCnt, $score, $imagePath, $name, $review, $id>";
}


