import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/clinic.dart';

class ClinicRepository {
  final CollectionReference collection = FirebaseFirestore.instance.collection('clinic');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Stream<QuerySnapshot> getStreamWithZip(String zipCode) {
    return collection.where('ZIPCD', isEqualTo: zipCode).snapshots();
  }

  Future<DocumentReference> addClinic(Clinic clinic) {
    return collection.add(clinic.toJson());
  }


  updateClinic(Clinic clinic) async {
    await collection.doc(clinic.reference!.id).update(clinic.toJson());
  }
}