import 'dart:developer';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:igroove_fan_box_one/api/auth.dart';
import 'package:igroove_fan_box_one/base/info.dart';
import 'package:igroove_fan_box_one/base/keys.dart';
import 'package:igroove_fan_box_one/config.dart';
import 'package:igroove_fan_box_one/core/networking/custom_exception.dart';
import 'package:igroove_fan_box_one/localization/localization.dart';
import 'package:igroove_fan_box_one/ui/widgets/dialog.dart';

/// The service responsible for networking requests
class Client {
  static String baseUrl = 'https://' + Configs.cloudURL + Configs.CLOUD_PATH;

  static BaseOptions opts = BaseOptions(
    baseUrl: baseUrl,
    responseType: ResponseType.json,
    connectTimeout: 120000,
    receiveTimeout: 120000,
  );

  static Dio init() {
    Dio _dio = Dio(opts);
    _dio.interceptors.add(ApiInterceptors());
    return _dio;
  }
}

class ApiInterceptors extends Interceptor {
  Map<String, dynamic> get queryParams => <String, dynamic>{
        // 'api_user': Configs.CLOUD_CLEINT_ID_PROD,
        'device_id': EnvInfo().device!['uniqueID'],
        // 'api_pass': Configs.CLOUD_CLEINT_SECRET_PROD,
        // 'labelAccessKey': Configs.LABEL_ACCESS_KEY,
        'app_instance_token': Configs.APP_INSTANCE_TOKEN,
        'token': Auth.authToken,
      };

  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Do something before request is sent
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      throw FetchDataException("There is no internet connection.");
    }
    // add auth query params
    options.queryParameters.addAll(queryParams);
    log("URL: ${options.uri.toString()}");
    // log("BODY: ${options.data.toString()}");

    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    // ignore: unused_local_variable
    late CustomException error;

    // log('Error: $err');
    // log('API Error : ${err.response?.data}');

    switch (err.type) {
      case DioErrorType.receiveTimeout:
        error = FetchDataException(
          "Our servers are not reachable. "
          "Your request took too long to respond",
        );
        break;
      case DioErrorType.sendTimeout:
        if (err.message.contains('SocketException')) {
          error = FetchDataException(
            "Please verify your internet "
            "connection and try again",
          );
        }
        break;
      case DioErrorType.response:
        String? message;

        if (err.response != null) {
          message = decodeResponse(err.response!);
        } else {
          message = err.message;
        }

        if (err.response == null) {
          error = FetchDataException(message);
        } else if (err.response!.statusCode! >= 400 &&
            err.response!.statusCode! < 500) {
          error = BadRequestException(message);
        } else if (err.response!.statusCode! >= 500) {
          error = FetchDataException(message);
        } else {
          error = BadRequestException(message);
        }
        break;

      default:
        error = FetchDataException(
          'Unexpected error occurred. '
          'Please try again later.',
        );
    }

    handler.next(error);
  }

  @override
  Future<void> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    // log("API Response: ${response.data}");

    //  log(response.data.toString());
    if (response.data is String) {
      return handler.reject(
        DioError(
          type: DioErrorType.response,
          error: "Response data is malformed. (expected JSON. got String)",
          requestOptions: response.requestOptions,
        ),
        true,
      );
    }

    int? status = response.data['status'];
    // var warningMessage = response.data['warningMessages'];
    if (status == 0) {
      // print(response);
      return handler.reject(
        DioError(
          type: DioErrorType.response,
          response: response,
          requestOptions: response.requestOptions,
        ),
        true,
      );
    }

    await handleWarningMessage(response);

    handler.next(response); // continue
  }

  Future<void> handleWarningMessage(response) async {
    BuildContext? context = AppKeys.navigatorKey.currentContext;

    if (response.data['warningMessages'] is! List) return;

    List<dynamic>? warningMessages = response.data['warningMessages'];

    if (warningMessages == null || warningMessages.isEmpty) {
      return;
    }

    String warningMessage = warningMessages
        .map((e) => e.toString())
        .map((e) => e.toString())
        .join('\n');

    await IGrooveDialog.showWarning(
      context!,
      title: "Warning",
      message: warningMessage.replaceAll("[", "").replaceAll("]", ""),
    );
  }

  String? decodeResponse(Response response) {
    if (response.data is String) {
      if (response.data.isEmpty) {
        return "Internal Server Error";
      } else {
        return response.data;
      }
    }

    int? warningMessageLength = 0;
    if (response.data['warningMessages'] != null) {
      warningMessageLength = response.data['warningMessages'].length;
    }

    if (warningMessageLength! > 1) {
      Map<String, dynamic>? warningMessages = response.data['warningMessages'];

      if (warningMessages != null) {
        List<dynamic> messages =
            warningMessages.values.toList().expand((i) => i).toList();

        BuildContext? context = AppKeys.navigatorKey.currentContext;
        return messages
            .map((e) => AppLocalizations.of(context!)!.getLocale(e.toString()))
            .toList()
            .join('\n');
      }
    }

    if (response.data is String) {
      return response.data;
    }

    if (response.data['message'] is List<dynamic>) {
      List<dynamic> errors = response.data['message'] as List<dynamic>;
      List<dynamic> messages = errors.first['messages'] as List<dynamic>;

      return messages.first['message'];
    }

    if (response.data['message'] is String) return response.data['message'];

    return response.data['data']['message'];
  }
}
