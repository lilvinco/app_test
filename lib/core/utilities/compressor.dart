import 'dart:io';

import 'package:igroove_fan_box_one/core/utilities/file_chooser.dart';
import 'package:video_compress/video_compress.dart';

class VideoFileUtils {
  static Future<ChooserFile> compressVideo(File file) async {
    ChooserFile? chooserFile = ChooserFile();
    if (VideoCompress.isCompressing) {
      await VideoCompress.cancelCompression();
    }

    MediaInfo? info = await VideoCompress.compressVideo(
      file.path,
      quality: VideoQuality.DefaultQuality,
      deleteOrigin: false,
    );

    chooserFile.name = info?.title;
    chooserFile.path = info?.path;
    chooserFile.rawFile = info?.file;
    return chooserFile;
  }

  static clearCache() async {
    await VideoCompress.deleteAllCache();
  }
}
