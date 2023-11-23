import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class TImageHandler {
  /// Get image from gallery
  static Future<File?> getImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      if (kDebugMode) {
        print('No image selected.');
      }
      return null;
    }
  }

  /// Get multiple images from gallery
  static Future<List<File>?> getMultipleImagesFromGallery() async {
    List<XFile>? pickedFiles = await ImagePicker().pickMultiImage(
      imageQuality: 70,
    );

    if (pickedFiles.isNotEmpty) {
      List<File> images = pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
      return images;
    } else {
      if (kDebugMode) {
        print('No images selected.');
      }
      return null;
    }
  }

  /// Get image from camera
  static Future<File?> getImageFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      if (kDebugMode) {
        print('No image selected.');
      }
      return null;
    }
  }

  /// Get multiple images from camera
  static Future<List<File>?> getMultipleImagesFromCamera() async {
    List<XFile>? pickedFiles = await ImagePicker().pickMultiImage(
      imageQuality: 70,
    );
    if (pickedFiles.isNotEmpty) {
      List<File> images = pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
      return images;
    } else {
      if (kDebugMode) {
        print('No images selected.');
      }
      return null;
    }
  }
}
