import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Products {
  String? ingredients;
  int? reviewCnt;
  double? score;
  String? imagePath;
  String? name;

  DocumentReference? reference;

  Products(this.ingredients, this.reviewCnt, this.score, this.imagePath, this.name, {this.reference});

  factory Products.fromSnapshot(DocumentSnapshot snapshot) {
    Products newProducts = Products.fromJson(snapshot.data() as Map<String, dynamic>?);
    newProducts.reference = snapshot.reference;
    return newProducts;
  }

  // factory Products.fromJson(Map<String, dynamic>? json) => _ProductsFromJson(json);

  factory Products.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Products(null, null, null, null, null); // Handle the case where JSON is null
    }

    final ingredients = json['components'] as String?;
    final reviewCnt = json['review_cnt'] as int?;
    final score = json['score'] is double ? json['score'] as double : null;
    String? imagePath;
    final name = json['name'] as String?;


    final imageRef = json['image'];
    if (imageRef is DocumentReference) {
      // If the image data is a DocumentReference, you can get its path
      // and use it as the imagePath.
      imagePath = imageRef.path;
    } else {
      // Handle other cases where the image data is not a DocumentReference.
      // You can set imagePath to null or provide a default value.
      imagePath = json['image'] as String?;
    }

    return Products(ingredients, reviewCnt, score, imagePath, name);
  }


  @override
  String toString() => "Product<$ingredients, $reviewCnt, $score, $imagePath, $name>";
}



// class Products {
//   String? ingredients;
//   int? reviewCnt;
//   double? score;
//   String? imagePath;
//
//   DocumentReference? reference;
//
//   Products(this.ingredients, this.reviewCnt, this.score, this.imagePath, {this.reference});
//
//   factory Products.fromJson(Map<String, dynamic>? json) {
//     if (json == null) {
//       return Products(null, null, null, null); // Handle the case where JSON is null
//     }
//
//     final ingredients = json['components'] as String?;
//     final reviewCnt = json['review_cnt'] as int?;
//     final score = json['score'] is double ? json['score'] as double : null;
//     final imagePath = json['image'] as String?; // Handle null value here
//
//     return Products(ingredients, reviewCnt, score, imagePath);
//   }
//
//   @override
//   String toString() => "Product<$ingredients, $reviewCnt, $score, $imagePath>";
// }
