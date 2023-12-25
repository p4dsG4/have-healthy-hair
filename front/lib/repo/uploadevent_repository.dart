
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UploadEvent {
  static void uploadTimestamp(String imageName) async {
    FirebaseFirestore.instance.collection('upload_events').doc(imageName).set({
      'timestamp': FieldValue.serverTimestamp() // Use server timestamp
    }, SetOptions(merge: true)) // Merge with existing data if the document already exists
        .then((_) {
      if (kDebugMode) { print('Timestamp added for image: $imageName'); }
    }).catchError((error) {
      if (kDebugMode) { print('Error adding timestamp: $error'); }
    });
  }

  static Future<bool> getAnalyzeResult(String imageName) async {
    var uploadEvents = FirebaseFirestore.instance.collection("upload_events");
    var docRef = uploadEvents.doc(imageName);

    var result = await docRef.get();
    if (result.data()!['success'] != null) {
      if (result.data()!['success'] == true) {
        return true;
      }
      else if (result.data()!['success'] == false) {
        // Remove the 'success' field from the document
        await docRef.update({'success': FieldValue.delete()}).catchError((e) {
          print('Error deleting success field: $e');
        });

        throw Exception("Analyze failed");
      }
    }
    return false;
  }



}