import 'dart:io';

abstract class StorageBase {
  Future<String> uploadImage(String userdId, String fileName, File image);
}
