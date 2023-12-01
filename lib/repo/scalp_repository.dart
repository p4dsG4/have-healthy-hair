import 'package:cloud_firestore/cloud_firestore.dart';

class ScalpRepository {
  final CollectionReference collection = FirebaseFirestore.instance.collection('scalp_ml');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }
}