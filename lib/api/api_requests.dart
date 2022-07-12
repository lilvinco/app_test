import 'package:http/http.dart' as http;
import 'package:igroove_fan_box_one/api/api_error_helper.dart';

class AppBasicRequests {
  static Future<http.Response> httpGet(Uri uri,
      {Map<String, String>? headers}) async {
    return http
        .get(
      uri,
      headers: headers,
    )
        .timeout(const Duration(seconds: 20), onTimeout: () async {
      return ApiErrorHelper.getTimeoutErrorResponse();
    });
  }
}
