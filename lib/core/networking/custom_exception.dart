import 'package:dio/dio.dart';

class CustomException extends DioError implements Exception {
  CustomException([this._message])
      : super(requestOptions: RequestOptions(path: ''));

  final String? _message;

  @override
  String toString() => _message!;
}

class FetchDataException extends CustomException {
  FetchDataException([String? message]) : super(message);
}

class BadRequestException extends CustomException {
  BadRequestException([String? message]) : super(message);
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([String? message]) : super(message);
}

class MinAppVersionException extends CustomException {
  MinAppVersionException()
      : super('Please update the app to continue using it.');
}
