import 'package:flutter/material.dart';

class FocusHelper {
  static unfocus({required BuildContext context}) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
