import 'dart:convert';

import 'package:http/http.dart';
import 'package:igroove_fan_box_one/model/basic_api_response.dart';

const String REQUEST_TIME_OUT =
    "Request time out, please check your internet connection.";
const String UNHANDLED_ERROR = "Unhandled error!";

class ApiErrorHelper {
  static Response getTimeoutErrorResponse() {
    Map<String, dynamic> bodyMap = <String, dynamic>{
      "status": 0,
      "message": REQUEST_TIME_OUT,
    };

    Response response = Response(jsonEncode(bodyMap), 408);

    return response;
  }

  static ApiBasicResponse handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return ApiBasicResponse(body: jsonDecode(response.body), message: null);
      case 408:
        return ApiBasicResponse(body: null, message: REQUEST_TIME_OUT);
      default:
        return ApiBasicResponse(body: null, message: UNHANDLED_ERROR);
    }
  }
}
