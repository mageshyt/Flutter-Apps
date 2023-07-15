import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(content)),
  );
}

Future<List<File>> pickImage() async {
  List<File> images = [];
  final ImagePicker picker = ImagePicker();

  final imageFiles = await picker.pickMultiImage();

  if (imageFiles.isNotEmpty) {
    // loop through all images
    for (final image in imageFiles) {

      images.add(File(image.path));
    }
  }
  return images;
}
