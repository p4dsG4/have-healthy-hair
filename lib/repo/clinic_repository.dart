import 'package:cloud_firestore/cloud_firestore.dart';

class ClinicRepository {
  final CollectionReference collection = FirebaseFirestore.instance.collection('clinic');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }
}