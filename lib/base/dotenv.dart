/// Loads environment variables from a `.env` file.
///
/// ## usage
///
/// Once you call [load] or the factory constructor with a valid env,
/// the top-level [env] Map<dynamic, dynamic>is available.
/// You may wish to prefix the import.
///
///     import 'package:flutter_dotenv/flutter_dotenv.dart' show load, env;
///
///     void main() {
///       await DotEnv().load('.env');
///       runApp(App());
///       var x = DotEnv().env['foo'];
///       // ...
///     }
///
/// Verify required variables are present:
///
///     const _requiredEnvVars = const ['host', 'port'];
///     bool get hasEnv => isEveryDefined(_requiredEnvVars);
///
import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

///
/// ## usage
///
///   Future main() async {
///     await DotEnv().load('.env');
///     //...runapp
///   }
///
/// Verify required variables are present:
///
///     const _requiredEnvVars = const ['host', 'port'];
///     bool get hasEnv => isEveryDefined(_requiredEnvVars);

class DotEnv {
  Map<String, String> _env = <String, String>{};
  static DotEnv? _singleton;

  // Replaced stderr.writeln with print to avoid error on iOS
  Map<String, String> get env {
    if (_env.isEmpty) {
      print('[flutter_dotenv] No env values found'
          'Make sure you have called DotEnv.load()');
    }
    return _env;
  }

  set env(Map<String, String> env) {
    _env = env;
  }

  /// True if all supplied variables have nonempty value; false otherwise.
  /// Differs from [containsKey](dart:core) by excluding null values.
  /// Note [load] should be called first.
  bool isEveryDefined(Iterable<String> vars) =>
      vars.every((String k) => env[k] != null && env[k]!.isNotEmpty);

  /// Read environment variables from [filename] and add them to [env].
  /// Logs to [stderr] if [filename] does not exist.
  Future load([String filename = '.env', Parser psr = const Parser()]) async {
    List<String> lines = await _verify(filename);
    env.addAll(psr.parse(lines));
  }

  Future<List<String>> _verify(String filename) async {
    try {
      String str = await rootBundle.loadString(filename);
      if (str.isNotEmpty) return str.split('\n');
      stderr.writeln('[flutter_dotenv] Load failed: file $filename was empty');
    } on FlutterError {
      stderr.writeln('[flutter_dotenv] Load failed: file not found');
    }
    return [];
  }

  factory DotEnv({Map<String, String>? env}) {
    _singleton ??= DotEnv._internal(env: env);
    return _singleton!;
  }

  DotEnv._internal({Map<String, String>? env})
      : _env = env ?? <String, String>{};
}

/// Creates key-value pairs from strings formatted as environment
/// variable definitions.
class Parser {
  static const String _keyword = 'export';

  static final RegExp _comment = RegExp(r'''#.*(?:[^'"])$''');
  static final RegExp _surroundQuotes = RegExp(r'''^(['"])(.*)\1$''');

  /// [Parser] methods are pure functions.
  const Parser();

  /// Creates a [Map](dart:core)
  /// Duplicate keys are silently discarded.
  Map<String, String> parse(Iterable<String> lines) {
    Map<String, String> out = <String, String>{};
    for (String line in lines) {
      Map<String, String> kv = parseOne(line, env: out);
      if (kv.isEmpty) continue;
      out.putIfAbsent(kv.keys.single, () => kv.values.single);
    }
    return out;
  }

  /// Parses a single line into a key-value pair.
  @visibleForTesting
  Map<String, String> parseOne(String line,
      {Map<String, String> env = const {}}) {
    String stripped = strip(line);
    if (!_isValid(stripped)) return {};

    List<String> sides = stripped.split('=');
    String lhs = sides[0];
    String k = swallow(lhs);
    if (k.isEmpty) return {};

    String rhs = sides[1].trim();
    String v = unquote(rhs);

    return {k: v};
  }

  /// If [val] is wrapped in single or double quotes,
  /// returns the quote character.
  /// Otherwise, returns the empty string.
  @visibleForTesting
  String? surroundingQuote(String val) {
    if (!_surroundQuotes.hasMatch(val)) return '';
    return _surroundQuotes.firstMatch(val)!.group(1);
  }

  /// Removes quotes (single or double) surrounding a value.
  @visibleForTesting
  String unquote(String val) =>
      val.replaceFirstMapped(_surroundQuotes, (Match m) => m[2]!).trim();

  /// Strips comments (trailing or whole-line).
  @visibleForTesting
  String strip(String line) => line.replaceAll(_comment, '').trim();

  /// Omits 'export' keyword.
  @visibleForTesting
  String swallow(String line) => line.replaceAll(_keyword, '').trim();

  bool _isValid(String s) => s.isNotEmpty && s.contains('=');
}
