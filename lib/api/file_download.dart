import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import "package:http/http.dart" as http;
import 'package:igroove_fan_box_one/api/auth.dart';
import 'package:igroove_fan_box_one/base/info.dart';
import 'package:igroove_fan_box_one/helpers/api_errors.dart';

class DownloadFilesAPI {
  final String? root;

  DownloadFilesAPI(this.root);

  Future<String?> downloadPDF({
    Function? showDownloadProgress,
    String? savePath,
    String? downloadURL,
    String? fileID,
  }) async {
    // Create object from Dio
    dio.Dio myDio = dio.Dio();

    String? errorMessage;

    dio.CancelToken cancelToken = dio.CancelToken();
    // print(savePat)
    // ignore: unused_local_variable
    dio.Response response;
    // Create and return UUID when everything is fine.

    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      errorMessage = APIErrors.SOCKET_EXCEPTION;
    } else {
      try {
        Map result = await _getFileContentLength(downloadURL!);

        if (result['error'] == null) {
          response = await myDio.download(
            downloadURL,
            savePath,
            onReceiveProgress: (int received, int total) {
              int? totalBytes;
              if (total == -1) {
                totalBytes = result['file_length'];
              } else {
                totalBytes = total;
              }
              showDownloadProgress!(received, totalBytes);
            },
            cancelToken: cancelToken,
          );
          // if (response != null) {
          await const FlutterSecureStorage()
              .write(key: fileID!, value: savePath);
          // } else {
          //   errorMessage = "Response is null";
          // }
        } else {
          errorMessage = result['error'];
        }
      } catch (e, stacktrace) {
        print(e.toString());
        print(stacktrace.toString());
      }
    }

    return errorMessage;
  }

  Future<String?> downloadFile({
    Function? showDownloadProgress,
    String? savePath,
    String? downloadURL,
    String? fileID,
  }) async {
    // Create object from Dio
    dio.Dio myDio = dio.Dio();

    String? errorMessage;

    dio.CancelToken cancelToken = dio.CancelToken();
    // print(savePat)
    // ignore: unused_local_variable
    dio.Response response;
    // Create and return UUID when everything is fine.

    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      errorMessage = APIErrors.SOCKET_EXCEPTION;
    } else {
      try {
        // Map result = await _getFileContentLength(downloadURL!);
        print(downloadURL);
        // if (result['error'] == null) {
        response = await myDio.download(
          downloadURL!,
          savePath,
          onReceiveProgress: (int received, int total) {
            showDownloadProgress!(received, total);
          },
          cancelToken: cancelToken,
        );
        // if (response != null) {
        await const FlutterSecureStorage().write(key: fileID!, value: savePath);
        // } else {
        //   errorMessage = "Response is null";
        // }
        // } else {
        //   errorMessage = result['error'];
        // }
      } catch (e, stacktrace) {
        print(e.toString());
        print(stacktrace.toString());
      }
    }

    return errorMessage;
  }

  Future<Map<String, dynamic>> _getFileContentLength(String url) async {
    http.Response fileResponse = await http.get(Uri.parse(url));

    if (fileResponse.statusCode == 200) {
      try {
        Map<dynamic, dynamic> responseMap = jsonDecode(fileResponse.body);
        //print("PDF file downloading has error: Something went wrong.");
        return <String, dynamic>{
          'file_length': null,
          'error': (responseMap)['message'],
        };
      } catch (e, stacktrace) {
        if (e is FormatException) {
          //print("PDF file downloading is fine.");
          return <String, dynamic>{
            'file_length': fileResponse.contentLength,
          };
        } else {
          print(e.toString());
          print(stacktrace.toString());
        }
      }
    }

    return <String, dynamic>{};
  }

  Uri getDownloadURI(
      {required String endPoint,
      required Map<String, String?> queryParams,
      String? rootURL}) {
    // Create Uri for request and parameters
    Uri uri = Uri.https(
        rootURL ?? "",
        endPoint,
        <String, dynamic>{
          'device_id': EnvInfo().device!['uniqueID'],
          'token': Auth.authToken,
        }..addAll(queryParams));
    return uri;
  }
}
