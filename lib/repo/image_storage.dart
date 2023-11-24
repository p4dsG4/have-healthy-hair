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
}