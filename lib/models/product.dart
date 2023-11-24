import 'package:cloud_firestore/cloud_firestore.dart';

class Products {
  String? ingredients;
  String? reviewCnt;
  String? score;

  DocumentReference? reference;

 Products(this.ingredients, this.reviewCnt, this.score, {this.reference});

  factory Products.fromSnapshot(DocumentSnapshot snapshot) {
    Products newProducts = Products.fromJson(snapshot.data() as Map<String, dynamic>?);
    newProducts.reference = snapshot.reference;
    return newProducts;
  }

  factory Products.fromJson(Map<String, dynamic>? json) => _ProductsFromJson(json);

  @override
  String toString() => "Products<$ingredients, $reviewCnt, $score>";
}

Products _ProductsFromJson(Map<String, dynamic>? json) {
  print(json.toString());
  return Products(
      json?['components'] as String,
      json?['review_cnt'] as String,
      json?['score'] as String,

  );
}