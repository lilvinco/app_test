// ToDo to remove
class CustomException implements Exception {
  CustomException([this._message, this._prefix]);

  final String? _message;
  final String? _prefix;

  @override
  String toString() => '${_prefix ?? ''} $_message';
}
