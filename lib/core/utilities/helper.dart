import 'package:uuid/uuid.dart';

class IGrooveHelper {
  static String getRequestID() {
    Uuid uuid = const Uuid();
    return uuid.v4();
  }
}
