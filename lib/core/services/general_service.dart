import 'dart:async';

import 'package:dio/dio.dart';
import 'package:igroove_fan_box_one/model/system_model.dart';

class GeneralService {
  final Dio _client;
  System? systemData;

  GeneralService({
    required Dio client,
  }) : _client = client;

  Future<dynamic> systemInfo() async {
    final Response response = await _client.get('/system');
    Map<dynamic, dynamic> parsedResponse = response.data;
    systemData = System.fromJson(parsedResponse as Map<String, dynamic>);
  }
}
