import 'dart:async';
import 'package:universal_io/io.dart' as io;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

/// Provides methods to get the web based images.
///
/// Use `imageProvider` method to get the image from network.
///
/// Use `downloadImage` method to download the image to app's
///  documents directory.
class AppImages {
  // Stores the path for cached images
  static late String _cachePath;

  static late Dio dio;

  /// Sets the images cache path
  static set cachePath(String path) {
    dio = Dio();
    _cachePath = path;
  }

  /// Static method, which returns `NetworkImage` when
  ///  the image is not exists on cache directory and
  ///  `FileImage` when image is already cached.
  /// If the image is not exists, the function will
  ///  return the `NetworkImage` instance and start
  ///  downloading the image in background.
  static ImageProvider? imageProvider(String url) {
    if (url.isEmpty) {
      return null;
    }
    // Create File object to be able to check if file
    //  exits and save into it if file doesn't exists.
    io.File imageFile = _imageFileFromURL(url);

    // Check if file exists
    if (imageFile.existsSync()) {
      // File from cached images directory
      return FileImage(imageFile);
    } else {
      // File doesn't exists.
      // Start downloading, but return NetworkImage
      downloadImage(url, imageFile);

      return NetworkImage(url);
    }
  }

  /// Puts the images into queue and downloads with bulks.
  static Future<void> downloadBulkImage(List<String> urls) async {
    // Reuqests will be stored inside this list
    //  so we can donwload them in one shot.
    List<Future> downloads = [];

    // Check the URLs and put into queue to dowload.
    for (String url in urls) {
      // Do not put into queue if no URL specified.
      if (url.isNotEmpty) {
        // Use download method from Dio library.
        // The path should be the chache path and the image name from url.
        downloads.add(
          // Wrap each download action into Future to resolve later.
          Future<void>(() {
            // Get the image body by GET request
            dio
                .get(
              url,
              options: Options(
                responseType: ResponseType.bytes,
              ),
            )
                .then((Response response) {
              if (response.statusCode == io.HttpStatus.notModified) {
                print('HttpStatus.notModified == $url');
              }

              // Check the response and response status
              if (response.statusCode == io.HttpStatus.ok) {
                io.File imageFile = _imageFileFromURL(url);

                // Write to local file
                imageFile.writeAsBytesSync(response.data);
              } else {
                debugPrint('Server responde with null body. URL = $url');
              }
            });
          }),
        );
      }
    }

    // Start downloading the images.
    // dio.lock will lock the incoming requests,
    //  once the current list of images are downloaded,
    //  we will unlock the dio instance.
    dio.lock();
    await Future.wait(downloads);
    dio.unlock();
  }

  /// Funtion does network request and saves the `response.bodyBytes`
  ///  into given `File` object.
  static Future<void> downloadImage(String url, [io.File? imageFile]) async {
    // Check if the URL is empty
    if (url.isEmpty) {
      debugPrint('No URL specified.');
      return;
    }

    // Get the image body by GET request
    Response response = await dio.get(
      url,
      options: Options(
        responseType: ResponseType.bytes,
      ),
    );

    // Check the response and response status
    if (response.statusCode == io.HttpStatus.ok) {
      io.File imageFile = _imageFileFromURL(url);

      // Write to local file
      imageFile.writeAsBytesSync(response.data);
    } else {
      debugPrint('Server responde with null body. URL = $url');
    }
  }

  /// Parses the `URL` and creates `File` object in image cache directory.
  static io.File _imageFileFromURL(String url) {
    // Get the file name
    String filename = url.split('/').last;

    // Create path string for cached image
    String cachedImagePath = join(_cachePath, filename);

    // Create File object
    io.File imageFile = io.File(cachedImagePath);

    return imageFile;
  }
}
