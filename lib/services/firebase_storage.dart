import 'dart:io';

import 'package:chataplication/services/storage_base.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireBaseStorage extends StorageBase {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  @override
  Future<String> uploadImage(String userId, String fileName, File image) async {
    Reference ref = _firebaseStorage.ref().child(userId).child(fileName);
    await ref.putFile(image);
    return await ref.getDownloadURL();
  }
}
