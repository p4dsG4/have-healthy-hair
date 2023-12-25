import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final CollectionReference collection = FirebaseFirestore.instance.collection('users');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }
}