import 'dart:io';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:path_provider/path_provider.dart';

class ConvertAudio {
  Future<String> covertAudioToMp3FromWave(File file) async {
    final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();
    String fileExtension = file.path.split('.').last;
    final Directory tempDir = await getTemporaryDirectory();

    final File tempFile =
        await file.copy('${tempDir.path}/temp.$fileExtension');

    if (await tempFile.exists()) {
      final File renamedFile = await tempFile.rename(
        '${tempDir.path}/temp.$fileExtension',
      );
      file = renamedFile;
    } else {
      file = tempFile;
    }

    final String outputPath = '${DateTime.now().microsecondsSinceEpoch}_.mp3';
    // output file
    await _flutterFFmpeg.execute(
      '-i ${file.path} -acodec libmp3lame -y ${tempDir.path}/$outputPath',
    );

    await file.delete();
    return '${tempDir.path}/$outputPath';
  }
}
