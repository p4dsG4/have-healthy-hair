import 'package:cloud_firestore/cloud_firestore.dart';

class ShampooRepository {
  final CollectionReference collection = FirebaseFirestore.instance.collection('products');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }
}