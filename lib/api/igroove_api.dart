import 'dart:io';
import 'package:igroove_fan_box_one/api/file_download.dart';
import 'package:igroove_fan_box_one/api/translations/translation.dart';
import 'package:igroove_fan_box_one/config.dart';

// Export the static Auth class

/// Responsible for fetching and parsing web objects.
/// IGrooveAPI is initialized when the app starts.
/// Once the class is initialized, it's provides single instance.
class IGrooveAPI {
  // Stores the instance of API class
  static IGrooveAPI? _singleton;

  // Each resource has it own class
  // The requests should be implemented in those classes

  final DownloadFilesAPI downloadFiles;
  final Translations translations;

  // Private constructor. Used only first time when class is constructed
  IGrooveAPI._internal(
    this.downloadFiles,
    this.translations,
  );

  reset({String? url}) {
    _singleton = null;
    final HttpClient httpClient = HttpClient();

    httpClient.connectionTimeout = const Duration(milliseconds: 20000);
    IGrooveAPI(
      client: httpClient,
      // Currently the URL version of API is not working
      url: url ?? Configs.cloudURL,
    );
  }

  /// Factory constructor. Initiates and Returns singleton.
  factory IGrooveAPI( // ignore: invalid_annotation_target
      {
    HttpClient? client,
    String? url,
  }) {
    // Check if instance exists
    _singleton ??= IGrooveAPI._internal(
      //

      DownloadFilesAPI(url),
      Translations(client, url),
    );

    // Return the instance
    return _singleton!;
  }
}
