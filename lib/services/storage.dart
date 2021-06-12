import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class StorageServices {
  static Future getImage(BuildContext context) async {
    final picker = ImagePicker();
    var imageFile;
    PickedFile? pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      var result = await _uploadPostImage(imageFile);
      return result;
    } else {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Tidak ada foto yang dipilih")),
      );
    }
  }

  static Future<String> _uploadPostImage(File imageFile) async {
    String fileName = basename(imageFile.path);

    Reference ref = FirebaseStorage.instance.ref('books').child(fileName);
    UploadTask task = ref.putFile(imageFile);
    TaskSnapshot taskSnapshot = await task;

    return await taskSnapshot.ref.getDownloadURL();
  }
}
