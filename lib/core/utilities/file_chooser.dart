import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui show Image;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:igroove_fan_box_one/base/keys.dart';
import 'package:igroove_fan_box_one/constants/routes.dart';
import 'package:igroove_fan_box_one/constants/sizes.dart';
import 'package:igroove_fan_box_one/core/utilities/compressor.dart';
import 'package:igroove_fan_box_one/core/utilities/selection_helper.dart';
import 'package:igroove_fan_box_one/localization/localization.dart';
import 'package:igroove_fan_box_one/management/helper.dart';
import 'package:igroove_fan_box_one/ui/pages/common/error_alert.dart';
import 'package:igroove_fan_box_one/ui/shared/themes.dart';
import 'package:igroove_fan_box_one/ui/shared/typography.dart';
import 'package:igroove_fan_box_one/ui/widgets/app_bar.dart';
import 'package:igroove_fan_box_one/ui/widgets/buttons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

class ImageFileMinSizeException implements Exception {
  ImageFileMinSizeException(
      [this._message = 'ImageFileMinSizeException', this._prefix]);

  final String _message;
  final String? _prefix;

  @override
  String toString() => '${_prefix ?? ''} $_message';
}

class ImageFileNotCompatibleException implements Exception {
  ImageFileNotCompatibleException(
      [this._message = 'ImageFileNotCompatibleException', this._prefix]);

  final String _message;
  final String? _prefix;

  @override
  String toString() => '${_prefix ?? ''} $_message';
}

class ChooserFile {
  String? name;
  String? path;
  File? rawFile;
  String? base64;

  ChooserFile({
    this.name,
    this.rawFile,
    this.path,
    this.base64,
  });

  @override
  String toString() {
    return 'ChooserFile{name: $name, '
        'path: $path, '
        'rawFile: $rawFile, '
        'base64: $base64}';
  }
}

class FileChooser {
  static const List<String> videoExtensions = [
    'mp4',
    'mov',
    'mkv',
  ];
  static const List<String> imageExtensions = [
    'png',
    'jpeg',
    'jpg',
    'PNG',
    'JPEG',
    'JPG'
  ];
  static const List<String> audioExtensions = ['wav', 'WAV', 'mp3', 'm4a'];
  static const List<String> imageDropBoxExtensions = [
    '.png',
    '.jpeg',
    '.jpg',
    '.PNG',
    '.JPEG',
    '.JPG'
  ];
  static const List<String> audioDropBoxExtensions = ['.wav', '.WAV'];

  Future<ChooserFile?> pickVideo() async {
    String? option = await _getChooserOption(type: 'video');
    final picker = ImagePicker();
    switch (option) {
      case 'gallery':
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.video,
        );
        if (result == null) return null;

        if (result.files.isEmpty) throw ('No file selected');
        File file = File(result.files.single.path!);

        double size = file.lengthSync() / 1024 / 1024;
        if (size > fileSizeLimit) {
          BuildContext context = AppKeys.navigatorKey.currentContext!;

          await Navigator.pushNamed(
            context,
            AppRoutes.errorAlert,
            arguments: ErrorAlertParams(
                title: AppLocalizations.of(context)!.generalDialogSorry!,
                message: AppLocalizations.of(context)!.fileTooLarge!),
          );
          return null;
        }
        ChooserFile returnFile = await VideoFileUtils.compressVideo(file);
        return returnFile;
      case 'camera':
        XFile? pickedFile = await picker.pickVideo(source: ImageSource.camera);
        if (pickedFile == null) return throw ('No file selected');
        File file = File(pickedFile.path);
        double size = file.lengthSync() / 1024 / 1024;
        if (size > fileSizeLimit) {
          BuildContext context = AppKeys.navigatorKey.currentContext!;
          await Navigator.pushNamed(
            context,
            AppRoutes.errorAlert,
            arguments: ErrorAlertParams(
                title: AppLocalizations.of(context)!.generalDialogSorry!,
                message: AppLocalizations.of(context)!.fileTooLarge!),
          );
          return null;
        }
        return VideoFileUtils.compressVideo(file);
      default:
        return null;
    }
  }

  static Future<ChooserFile?> pickImage({
    double? minWidth,
    double? minHeight,
    bool isSquare = false,
    String? title,
  }) async {
    String? option = await _getChooserOption();

    ChooserFile? chooserFile = ChooserFile();

    switch (option) {
      case 'dropbox':
        BuildContext context = AppKeys.navigatorKey.currentContext!;
        final ChooserFile? file = await Navigator.of(context).pushNamed(
          AppRoutes.dropboxChooser,
          arguments: DropboxChooserParameters(
            allowedExtensions: imageDropBoxExtensions,
            onlyPath: false,
          ),
        ) as ChooserFile?;
        File selected = File(file!.path!);
        double size = selected.lengthSync() / 1024 / 1024;
        if (size > fileSizeLimit) {
          BuildContext context = AppKeys.navigatorKey.currentContext!;
          await Navigator.pushNamed(
            context,
            AppRoutes.errorAlert,
            arguments: ErrorAlertParams(
                title: AppLocalizations.of(context)!.generalDialogSorry!,
                message: AppLocalizations.of(context)!.fileTooLarge!),
          );
          return null;
        }

        chooserFile = file;
        break;
      case 'cloud':
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: imageExtensions,
        );
        if (result == null) return null;
        if (result.files.isEmpty) throw ('Image not compatible');

        File file = File(result.files.single.path!);

        double size = file.lengthSync() / 1024 / 1024;
        if (size > fileSizeLimit) {
          BuildContext context = AppKeys.navigatorKey.currentContext!;
          await Navigator.pushNamed(
            context,
            AppRoutes.errorAlert,
            arguments: ErrorAlertParams(
                title: AppLocalizations.of(context)!.generalDialogSorry!,
                message: AppLocalizations.of(context)!.fileTooLarge!),
          );
          return null;
        }

        chooserFile.name = result.names.single;
        chooserFile.path = file.path;
        chooserFile.rawFile = file;
        break;
      case 'gallery':
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.image,
        );
        // did cancel and not select
        if (result == null) return null;
        // did select but not compatible
        if (result.files.isEmpty) throw ImageFileNotCompatibleException();

        File file = File(result.files.single.path!);

        double size = file.lengthSync() / 1024 / 1024;
        if (size > fileSizeLimit) {
          BuildContext context = AppKeys.navigatorKey.currentContext!;
          await Navigator.pushNamed(
            context,
            AppRoutes.errorAlert,
            arguments: ErrorAlertParams(
                title: AppLocalizations.of(context)!.generalDialogSorry!,
                message: AppLocalizations.of(context)!.fileTooLarge!),
          );
          return null;
        }

        chooserFile.name = result.names.single;
        chooserFile.path = file.path;
        chooserFile.rawFile = file;
        break;
      case 'camera':
        final ImagePicker _picker = ImagePicker();

        XFile? pickedFile = await _picker.pickImage(
          source: ImageSource.camera,
          imageQuality: 100,
        );

        if (pickedFile != null) {
          chooserFile.name = pickedFile.name;
          chooserFile.path = pickedFile.path;
          chooserFile.rawFile = File(pickedFile.path);
          double size = chooserFile.rawFile!.lengthSync() / 1024 / 1024;
          if (size > fileSizeLimit) {
            BuildContext context = AppKeys.navigatorKey.currentContext!;
            await Navigator.pushNamed(
              context,
              AppRoutes.errorAlert,
              arguments: ErrorAlertParams(
                  title: AppLocalizations.of(context)!.generalDialogSorry!,
                  message: AppLocalizations.of(context)!.fileTooLarge!),
            );
            return null;
          }
        }

        break;
    }

    if (chooserFile.path == null || chooserFile.path!.isEmpty) return null;

    /// determine Width & Height for validation (minWidth & minHeight)
    if (chooserFile.rawFile != null &&
        (minHeight != null || minHeight != null)) {
      ui.Image decodedImage =
          await decodeImageFromList(chooserFile.rawFile!.readAsBytesSync());

      if ((minWidth != null && decodedImage.width < minWidth) ||
          (decodedImage.height < minHeight) ||
          ((decodedImage.width != decodedImage.height) && isSquare)) {
        throw ImageFileMinSizeException(
            "${AppLocalizations().fileChooserCurrentCoverSize!} "
            " ${decodedImage.width} x ${decodedImage.height}");
      }
    }

    // File croppedFile =
    //     await _cropImage(chooserFile?.rawFile?.path ??
    // chooserFile.path, title);
    chooserFile.rawFile = chooserFile.rawFile;

    // convert cropped image to base64
    List<int> imageBytes = chooserFile.rawFile!.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    chooserFile.base64 = base64Image;

    return chooserFile;
  }

  static Future<Selection?> pickAudio({bool onlyPath = false}) async {
    String? option = await _getChooserOption(type: 'audio');
    ChooserFile chooserFile = ChooserFile();
    switch (option) {
      case 'record':
        return Selection(type: 'record', file: chooserFile);
      case 'files':
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: audioExtensions,
        );

        if (result == null) return null;
        if (result.files.isEmpty) throw ('Image not compatible');

        File file = File(result.files.single.path!);

        double size = file.lengthSync() / 1024 / 1024;
        if (size > fileSizeLimit) {
          BuildContext context = AppKeys.navigatorKey.currentContext!;
          await Navigator.pushNamed(
            context,
            AppRoutes.errorAlert,
            arguments: ErrorAlertParams(
                title: AppLocalizations.of(context)!.generalDialogSorry!,
                message: AppLocalizations.of(context)!.fileTooLarge!),
          );
          return null;
        }

        chooserFile.name = result.names.single;
        chooserFile.path = file.path;
        chooserFile.rawFile = file;
        print(file);
        return Selection(type: 'file', file: chooserFile);
    }
    return null;
  }

  static Future<String?> _getChooserOption({type = 'image'}) async {
    BuildContext? context = AppKeys.navigatorKey.currentContext;

    List options = [
      if (type != 'audio') {'Gallery', 'gallery'},
      if (type == 'image') {'Files', 'cloud'},
      if (type == 'video' || type == 'image') {'Camera', 'camera'},
      if (type == 'audio') {'Record', 'record'},
      if (type == 'audio') {'Files', 'files'},
    ];

    String? selectedOption;

    if (Platform.isIOS) {
      selectedOption = await showCupertinoModalPopup(
        context: context!,
        builder: (BuildContext context) => CupertinoActionSheet(
          title: Text(AppLocalizations.of(context)!.fileChooserUploadOptions!),
          message:
              Text(AppLocalizations.of(context)!.fileChooserPickMediaUpload!),
          actions: options
              .map((e) => CupertinoActionSheetAction(
                    child: Text(e.first),
                    onPressed: () => Navigator.pop(context, e.last),
                  ))
              .toList(),
          cancelButton: CupertinoActionSheetAction(
            child: Text(AppLocalizations.of(context)!.generalClose!),
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      );
    } else {
      selectedOption = await showModalBottomSheet(
        context: context!,
        isScrollControlled: true,
        builder: (BuildContext context) => Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocalizations.of(context)!.fileChooserUploadOptions!,
                style: IGrooveFonts.kBody13.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                AppLocalizations.of(context)!.fileChooserPickMediaUpload!,
                style: IGrooveFonts.kBody13.copyWith(
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 20),
              Divider(
                height: 0,
                color: IGrooveTheme.colors.white3,
              ),
              ...options
                  .map(
                    (e) => Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Center(
                            child: Text(
                              e.first,
                              style: TextStyle(
                                color: IGrooveTheme.colors.primary,
                              ),
                            ),
                          ),
                          onTap: () => Navigator.pop(context, e.last),
                        ),
                        Divider(
                          height: 0,
                          color: IGrooveTheme.colors.white3,
                        ),
                      ],
                    ),
                  )
                  .toList(),
              Padding(
                padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
                child: IGrooveGreyButton(
                  labelText: AppLocalizations.of(context)!.generalClose!,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              )
            ],
          ),
        ),
      );
    }

    return selectedOption;
  }
}

class DropboxChooserParameters {
  final List<String> allowedExtensions;
  final bool onlyPath;

  DropboxChooserParameters({
    this.allowedExtensions = const [],
    this.onlyPath = false,
  });
}

class VideoUploadParameters {
  final List<String> allowedExtensions;
  final bool onlyPath;

  VideoUploadParameters({
    this.allowedExtensions = const [],
    this.onlyPath = false,
  });
}

class DropboxChooser extends StatefulWidget {
  final DropboxChooserParameters? parameters;

  DropboxChooser({
    this.parameters,
  });

  @override
  _DropboxChooserState createState() => _DropboxChooserState();
}

class _DropboxChooserState extends State<DropboxChooser>
    with WidgetsBindingObserver {
  List<String?> directories = [''];
  List<DropboxFile> files = [];
  bool isLoading = false;

  selectFile(DropboxFile file) async {
    setState(() => isLoading = true);

    try {} catch (e, stacktrace) {
      print(e.toString());
      print(stacktrace.toString());
    } finally {
      setState(() => isLoading = false);
    }
  }

  pushDirectory(String? path) {
    directories.add(path);
    fetchFiles();
  }

  popDirectory() {
    directories.removeLast();
    fetchFiles();
  }

  fetchFiles({bool forceAuth = true}) async {}

  @override
  void initState() {
    fetchFiles();

    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      fetchFiles(forceAuth: false);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IGrooveAppBarWidget.withRightIcon(
          context: context,
          title: "Dropbox",
          leadingIcon: const Icon(
            Icons.arrow_back_ios,
          ),
          onTap: () => Navigator.of(context).pop()) as PreferredSizeWidget?,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.grey.shade200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.fileChooserDropBoxTitle!,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.grey.shade800),
                ),
                const Spacer(),
              ],
            ),
          ),
          Expanded(
            child: Builder(
              builder: (BuildContext context) {
                if (isLoading) {
                  return loadingWidget();
                }

                if (files.isEmpty) {
                  return Center(
                      child: Text(AppLocalizations.of(context)!
                          .fileChooserNoDropBoxFilesFound!));
                }

                return Column(
                  children: [
                    if (directories.length > 1)
                      Material(
                        elevation: 2,
                        child: ListTile(
                          onTap: popDirectory,
                          leading: const Icon(
                            Icons.chevron_left,
                            size: 30,
                          ),
                          title: Text(directories.last!),
                        ),
                      ),
                    Expanded(
                      child: ListView(
                        children: files.map((DropboxFile e) {
                          final bool enabled = e.isDirectory ||
                              (widget.parameters!.allowedExtensions
                                  .contains(e.extension));

                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                child: ListTile(
                                  leading: e.isDirectory
                                      ? const Icon(
                                          Icons.folder_rounded,
                                          color: Colors.lightBlueAccent,
                                        )
                                      : FileThumbnail(file: e),
                                  onTap: e.isDirectory
                                      ? () => pushDirectory(e.path)
                                      : () => selectFile(e),
                                  title: Text(
                                    e.name!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: enabled
                                          ? Colors.black
                                          : Colors.grey.shade300,
                                    ),
                                  ),
                                  enabled: enabled,
                                  trailing: e.isDirectory
                                      ? const Icon(Icons.chevron_right)
                                      : null,
                                ),
                              ),
                              const Divider(
                                height: 0,
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FileThumbnail extends StatelessWidget {
  const FileThumbnail({
    Key? key,
    required this.file,
  }) : super(key: key);

  final DropboxFile file;

  @override
  Widget build(BuildContext context) {
    var extensions = ['.png', '.jpeg', '.jpg', '.PNG', '.JPEG', '.JPG'];

    if (extensions.contains(file.extension)) {
      return FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot<ChooserFile> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: 30,
              width: 30,
              child: const CupertinoActivityIndicator(),
            );
          }

          return CachedNetworkImage(
            imageUrl: snapshot.data?.path ?? '',
            fit: BoxFit.contain,
            height: 30,
            width: 30,
            placeholder: (BuildContext context, String url) =>
                const CupertinoActivityIndicator(),
            errorWidget: (BuildContext context, String url, error) => Icon(
              Icons.insert_drive_file,
              color: Colors.grey.shade300,
            ),
          );
        },
      );
    }

    return Icon(
      Icons.insert_drive_file,
      color: Colors.grey.shade300,
    );
  }
}

class DropboxFile {
  String? name;
  int? fileSize;
  String? path;

  String get extension {
    final String extension = p.extension(path!);
    return extension;
  }

  DropboxFile({
    this.name,
    this.fileSize,
    this.path,
  });

  DropboxFile.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    path = json['pathDisplay'];
    fileSize = json['filesize'] != null ? json['filesize'] as int? : null;
  }

  bool get isDirectory {
    return fileSize == null;
  }
}
