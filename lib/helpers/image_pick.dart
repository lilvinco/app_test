import 'dart:async';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePick {
  static Future<File?> getAlbumImage() async {
    XFile? xFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (xFile == null) {
      return null;
    }

    return xFile as File;
  }

  static Future<File?> getCameraImage() async {
    XFile? xFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 100);

    if (xFile == null) {
      return null;
    }

    return xFile as File;
  }
}
