import 'dart:io';

class FileUtils {
  static String getExtension(File file) => file.path.split('.').last;
}
