import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String content, String title,
    ContentType contentTyp) {
  final snackBar = SnackBar(

      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: content,

        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        contentType: contentTyp,
      ));
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
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
