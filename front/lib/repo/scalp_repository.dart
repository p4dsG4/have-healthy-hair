import 'package:cloud_firestore/cloud_firestore.dart';

class ScalpRepository {
  final CollectionReference collection = FirebaseFirestore.instance.collection('scalp_ml');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  // fetch document with ids
  Future<DocumentSnapshot> fetchDocument(String id) {
    return collection.doc(id).get();
  }

  static Future<bool> getAnalyzeResult(String docId) async {
    var uploadEvents = FirebaseFirestore.instance.collection("upload_events");

    var result = await uploadEvents.doc(docId).get();
    if (result.data() != null){
      if(result.data()!['Top'] != null) {
        return true;
      }
    }
    return false;
  }
}