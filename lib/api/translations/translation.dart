import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:igroove_fan_box_one/api/api_error_helper.dart';
import 'package:igroove_fan_box_one/api/headers.dart';
import 'package:igroove_fan_box_one/helpers/api_errors.dart';

class Translations {
  final String? root;
  final HttpClient? client;

  Translations(this.client, this.root);

  Future<TranslationsResponse<dynamic>> getTranslations(
      {required String lang}) async {
    // Request error object.
    String? error;
    Map<String, dynamic>? parsedResponse;
    Map<String, String>? translations;
    // Get the URI
    Uri uri = Uri.https(root!, "/api/get-translations", <String, dynamic>{
      'lang': lang,
    });

    // Set headers.
    Map<String, String> _headers = {
      HttpHeaders.acceptHeader: Headers.accept,
    };
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      error = APIErrors.SOCKET_EXCEPTION;
    } else {
      try {
        http.Response response = await http
            .get(
          uri,
          headers: _headers,
        )
            .timeout(const Duration(seconds: 20), onTimeout: () async {
          return ApiErrorHelper.getTimeoutErrorResponse();
        });

        if (response.statusCode == 408) {
        } else {
          if (response.statusCode == 200) {
            parsedResponse = jsonDecode(response.body);

            translations = parsedResponse!.map((String key, value) {
              return MapEntry(key, value.toString());
            });

            if (parsedResponse['status'] == 1 &&
                parsedResponse['message'] != null) {
            } else {
              error = parsedResponse['message'];
            }
          }
        }
      } catch (e, stacktrace) {
        print(e.toString());
        print(stacktrace.toString());
      }
    }
    return TranslationsResponse(
      response: translations,
      error: error,
    );
  }
}

class TranslationsResponse<T> {
  final T? response;
  final String? error;

  TranslationsResponse({this.response, this.error});
}
