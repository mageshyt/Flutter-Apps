import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/constants/appwrite_constants.dart';
import 'package:twitter_clone/core/provider.dart';

final storageProvider = Provider((ref) {
  return StorageAPI(storage: ref.watch(appwriteStorageProvider));
});

class StorageAPI {
  final Storage _storage;
  StorageAPI({required Storage storage}) : _storage = storage;

  Future<List<String>> uploadImages(List<File> files) async {
    List<String> imageUrls = [];
    for (var file in files) {
      final uploadImage = await _storage.createFile(
          bucketId: AppwriteConstants.imagesBucket,
          fileId: ID.unique(),
          file: InputFile(
            path: file.path,
          ));

      imageUrls.add(AppwriteConstants.imageUrl(uploadImage.$id));
    }
    print(imageUrls);
    return imageUrls;
  }
}
