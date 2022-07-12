import 'package:igroove_fan_box_one/api/igroove_api.dart';
import 'package:igroove_fan_box_one/config.dart';
import 'package:rxdart/rxdart.dart';

class DownloadFileService {
  static const String LABEL_COPY_ENDPOINT = '${Configs.CLOUD_PATH}/label-copy';
  static const String ADVANCE_DETAILS_PDF =
      '${Configs.CLOUD_PATH}/advance-contract-download-attachment';
  static const String REPORT_DOWNLOAD_ENDPOINT =
      '${Configs.CLOUD_PATH}/report-download';
  static const String INVOICE_DOWNLOAD_ENDPOINT =
      '${Configs.CLOUD_PATH}/rev-share-download-invoice';

  static const String BALANCE_HISTORY_DOWNLOAD_ENDPOINT =
      '${Configs.CLOUD_PATH}/download-balance-history-attachment';
  PublishSubject<String?> percentSender = PublishSubject<String?>();

  bool isDownloadCompleted = false;

  downloadPDF({String? savePath, String? downloadURL, String? fileID}) async {
    isDownloadCompleted = false;
    // // Clear old data by creating new object instance.
    // percentSender = BehaviorSubject<String>();
    String? errorMessage = await IGrooveAPI().downloadFiles.downloadPDF(
        savePath: savePath,
        showDownloadProgress: showDownloadProgress,
        downloadURL: downloadURL,
        fileID: fileID);

    isDownloadCompleted = true;
    return errorMessage;
  }

  downloadFile({String? savePath, String? downloadURL, String? fileID}) async {
    isDownloadCompleted = false;
    // // Clear old data by creating new object instance.
    // percentSender = BehaviorSubject<String>();
    String? errorMessage = await IGrooveAPI().downloadFiles.downloadFile(
        savePath: savePath,
        showDownloadProgress: showDownloadProgress,
        downloadURL: downloadURL,
        fileID: fileID);

    isDownloadCompleted = true;
    return errorMessage;
  }

  showDownloadProgress(received, total) {
    // print("File Download progress  $received/$total");
    // print("Total bytes of file: $total");
    percentSender.add(((received / total) * 100).toStringAsFixed(0));
  }

  getDownloadURI(
      {required String endPoint,
      required Map<String, String?> queryParams,
      String? rootURL}) {
    return IGrooveAPI().downloadFiles.getDownloadURI(
        endPoint: endPoint, queryParams: queryParams, rootURL: rootURL);
  }
}
