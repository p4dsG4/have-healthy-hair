import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ImageStorage {
  static final _picker = ImagePicker();

  static Future uploadImageToFirebase({
          required String path,
          required String imageName,
          Function()? uploadStartCallback}) async {

    XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    var ext = image!.name
        .split('.')
        .last;

    var file = File(image.path);

    uploadStartCallback != null? () => uploadStartCallback():null;

    var snapshot = await FirebaseStorage.instance
        .ref()
        .child("$path/$imageName.$ext")
        .putFile(file);

    return await snapshot.ref.getDownloadURL();
  }

  static Future fetchImage(String path) async {
    var ref = FirebaseStorage.instance.ref();
    var child = ref.child(path);
    return await child.getDownloadURL();
  }

  static Future<String> waitUntilAvailable(String path, {int interval = 5, int timeout = 90000}) async {
    var ref = FirebaseStorage.instance.ref();
    int spent = 0;
    String url = "";
    while (spent < timeout) {
      try {
        url = await ref.child(path).getDownloadURL();
        return url;
      } catch (e) {
        print("wait for $interval seconds...");
        await Future.delayed(Duration(seconds: interval));
      }
      spent += interval;
    }
    return throw Exception("Timeout to wait for $path");
  }
}

