import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'
    as secure_storage;
import 'package:igroove_fan_box_one/api/auth.dart';
import 'package:igroove_fan_box_one/api/igroove_api.dart';
import 'package:igroove_fan_box_one/base/base.dart';
import 'package:igroove_fan_box_one/core/services/push_service.dart';
import 'package:igroove_fan_box_one/helpers/utils.dart';
import 'package:igroove_fan_box_one/igroove.dart';
import 'package:igroove_fan_box_one/localization/localization.dart';
import 'package:igroove_fan_box_one/management/date.dart';
import 'package:igroove_fan_box_one/model/assets_comments_model.dart';
import 'package:igroove_fan_box_one/model/assets_model.dart';
import 'package:igroove_fan_box_one/model/fan_boxes_model.dart';
import 'package:igroove_fan_box_one/model/fan_ranking_model.dart';
import 'package:igroove_fan_box_one/model/fan_ranking_point_system_model.dart';
import 'package:igroove_fan_box_one/model/notifications/notification.dart';
import 'package:igroove_fan_box_one/model/profile_model.dart';
import 'package:igroove_fan_box_one/model/question_model.dart';
import 'package:igroove_fan_box_one/model/releases_model.dart';
import 'package:igroove_fan_box_one/model/user_model.dart';
import 'package:igroove_fan_box_one/ui/widgets/success_dialog.dart';
import 'package:intl/intl.dart';

import '../../management/app_model.dart';

/// Contains actions specific for `Users`.
/// `Users` class is created and used in `AppModel` object.
/// Actions provided by this class should not be called directly from
///  UI layer and should be called only from
///  Main Management class - app_model.dart.
class UserService {
  // Stream will provide the most recent user status.
  // At first it will be UserStatus.Checking

  // The instance of IGrooveAPI.
  // final IGrooveAPI _iGrooveAPI = IGrooveAPI();
  //The instance of user data
  static UserModel? userDataModel;
  static LoginResponse? userData;
  static Timezones? timezones;
  static int userPoints = 0;
  static StreamController<int> streamControllerUserPoints =
      StreamController.broadcast();

  // User status, can be Checking | LogedIn | NotAuthorized
  // When the app starts UserStatus is always 'Checking'
  // UserStatus _userStatus = UserStatus.Checking;

  final UserStatus _userStatusState = UserStatus.Checking;

  final Dio _client;
  final secure_storage.FlutterSecureStorage _flutterSecureStorage;

  UserService({
    required Dio client,
    required secure_storage.FlutterSecureStorage flutterSecureStorage,
  })  : _client = client,
        _flutterSecureStorage = flutterSecureStorage;

  /// Getter for userStatusState
  UserStatus get userStatusState {
    return _userStatusState;
  }

  // Check if logged in
  Future<bool> isLoggedIn() async {
    return Auth.authToken != null;
  }

  checkUserPoints() async {
    await getProfile().then((userProfile) {
      streamControllerUserPoints.add(userProfile.payload!.fanPoints!);
      userPoints = userProfile.payload!.fanPoints!;
    });
  }

  //user sign in function
  Future<dynamic> signIn({
    String? email,
    String? password,
    bool saveCredentials = false,
  }) async {
    BuildContext? context = AppKeys.navigatorKey.currentContext;
    AppModel().currentPageIndex = 0;
    var data = FormData.fromMap({
      'email': email,
      'password': password,
      'app_version': EnvInfo().package.version,
      'app_os': Platform.isIOS
          ? 1
          : Platform.isAndroid
              ? 2
              : 0
    });

    final Response response = await _client.post(
      '/login',
      options: Options(contentType: "multipart/form-data"),
      data: data,
    );

    // Make the request and parse the response body
    Map<String, dynamic> parsedResponse = response.data;

    userData = LoginResponse.fromJson(parsedResponse);
    String? token = parsedResponse['token'];

    // Save Auth Token & User Data model
    Auth.authToken = token;
    // userDataModel = userData;

    // AppSettings appSettings;
    // if (parsedResponse['app_settings'] != null) {
    //   appSettings = AppSettings.fromJson(parsedResponse['app_settings']);
    // } else {
    //   appSettings = AppSettings(
    //       showFeedbackButton: false,
    //       showRevShare: false,
    //       allowWithholdingTax: 0,
    //       showDashboard: false,
    //       revShareCurrency: "CHF",
    //       revShareFeeAmount: "0",
    //       revShareFeesActivated: "0");
    // }
    // AppModel().appSettings.setAppSettings(appSettings);

    // checking if remember button is checked
    // then saveing user data to secure storage
    // check remember me button
    if (saveCredentials) {
      await _flutterSecureStorage.write(key: 'igrooveissaved', value: 'yes');
      await _flutterSecureStorage.write(key: 'igrooveusername', value: email);
      await _flutterSecureStorage.write(
          key: 'igroovepassword', value: password);
    } else {
      await _flutterSecureStorage.write(key: 'igrooveissaved', value: 'no');
      await _flutterSecureStorage.delete(key: 'igrooveusername');
      await _flutterSecureStorage.delete(key: 'igroovepassword');
    }

    // if (UserService.userDataModel!.isDemoUser) {
    //   String newLocale = "en";
    //   String defaultLocale = Platform.localeName;
    //   defaultLocale = defaultLocale.substring(0, 2);

    //   switch (defaultLocale) {
    //     case "en":
    //       newLocale = "en";
    //       break;
    //     case "fr":
    //       newLocale = "fr";
    //       break;
    //     case "de":
    //       newLocale = "de";
    //       break;
    //   }

    //   await IGroove.setLocale(localeCode: newLocale);
    //   // userData.language = newLocale;
    // } else {
    //   await IGroove.setLocale(localeCode: "de");
    // }
    await IGroove.setLocale(localeCode: "de");
    AppModel().currentPageIndex = 0;

    // Set Login time
    final DateFormat df = DateFormat('dd.MM.yyyy HH:mm:ss');
    String startResult = df.format(DateTime.now());
    AppModel().appinfo.setUserLoginTime(startResult);

    // Set default start / end date
    DateInfo info = DateInfoFormatter.dateInfoForType(PeriodType.Last30Days)!;
    DateStartEnd.startDate = info.start;
    DateStartEnd.endDate = info.end;

    // Set Device size information
    double realDeviceWidth = MediaQuery.of(context!).devicePixelRatio *
        MediaQuery.of(context).size.width;
    double realDeviceHeight = MediaQuery.of(context).devicePixelRatio *
        MediaQuery.of(context).size.height;
    AppModel().appinfo.setDeviceInfo(realDeviceWidth, realDeviceHeight);

    final String ipv4 = await Ipify.ipv4();
    AppModel().appinfo.setDeviceIP(ipv4);

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String platform = Platform.operatingSystem;

    switch (platform) {
      case 'android':
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        AppModel().appinfo.setDeviceName(
            "${androidInfo.device} ${androidInfo.brand} ${androidInfo.model}");

        AppModel()
            .appinfo
            .setDevicePhysicalDevice(androidInfo.isPhysicalDevice);
        print(AppModel().appinfo.deviceName);
        break;
      case 'ios':
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        AppModel().appinfo.setDeviceName("${iosInfo.name} ${iosInfo.model}"
            " ${iosInfo.systemName} ${iosInfo.systemVersion}");
        AppModel().appinfo.setDevicePhysicalDevice(iosInfo.isPhysicalDevice);
        print(AppModel().appinfo.deviceName);
        break;
      default:
    }

    if (AppModel().appinfo.deviceConnection == null ||
        AppModel().appinfo.deviceConnection == "") {
      ConnectivityResult connectivityResult =
          await Connectivity().checkConnectivity();
      String connectivityStr;

      switch (connectivityResult) {
        case ConnectivityResult.mobile:
          connectivityStr = 'mobile';
          break;
        case ConnectivityResult.wifi:
          connectivityStr = 'wifi';
          break;
        default:
          connectivityStr = 'unknown';
      }

      AppModel().appinfo.setDeviceConnection(connectivityStr);
    }

    // // Initialize Intercom
    // await Intercom.logout();
    // await Intercom.registerIdentifiedUser(email: email);

    // Initialize Wiredash
    // Wiredash.of(context)!.setUserProperties(
    //   userEmail: email,
    //   userId: email,
    // );
    // Wiredash.of(context);

    // Initialize Cashboard

    PushService();
    checkUserPoints();

    // await FirebaseDeviceRegistering().register(loggedUserEmail: email);
    // await IGrooveAPI().account.registerFCMTokenToServer();

    // Fetch notification for regular users
    // if (Configs.APP_WHITELABEL == false) {
    //   await NotificationsAction().getUserNotificationsCount();
    // }
  }

  //user sign in function
  Future<AssetsResponse> getAssets(
      {String? type, required int fanBoxId}) async {
    final Response response = await _client.get('/assets',
        queryParameters: <String, dynamic>{
          'type': type,
          'digital_fan_box_id': fanBoxId
        });
    Map<String, dynamic> parsedResponse = response.data;

    AssetsResponse assetsResponse = AssetsResponse.fromJson(parsedResponse);
    return assetsResponse;
  }

  Future<NotificationModel> getNotifications({int? page}) async {
    Response response;
    if (page == null) {
      response = await _client.get('/notifications');
    } else {
      response = await _client.get('/notifications?page=$page');
    }

    Map<String, dynamic> parsedResponse = response.data;

    NotificationModel notifications =
        NotificationModel.fromJson(parsedResponse);

    if (notifications.status == 1) {
      await Utils.setNotificationCount(
          count: notifications.unseenNotificationCount ?? 0);
      int count = await Utils.getNotificationCount();
      print("Notification Count from backend saved to SecureStorage =>"
          " ${count.toString()}");
    }

    return notifications;
  }

  markAsRead({required int id}) async {
    Response response = await _client.post(
      '/notifications/$id/mark-notification-as-seen',
    );
    Map<String, dynamic> parsedResponse = response.data;
    RegisterResponse markAsReadResposnse =
        RegisterResponse.fromJson(parsedResponse);
    if (markAsReadResposnse.status == 1) {
      print("Notification with ID $id marked as seen");
      await Utils.decreaseNotificationCount();
      int count = await Utils.getNotificationCount();
      print("Notification Count after markAsRead from SecureStorage =>"
          " ${count.toString()}");
    }
  }

  Future<AssetsResponse> getAsset({required String assetID}) async {
    final Response response = await _client.get('/assets/$assetID');
    Map<String, dynamic> parsedResponse = response.data;

    AssetsResponse assetsResponse = AssetsResponse.fromJson(parsedResponse);
    return assetsResponse;
  }

  Future<ReleaseModel> getReleases({required int fanBoxId}) async {
    final Response response = await _client.get('/releases',
        queryParameters: <String, dynamic>{'digital_fan_box_id': fanBoxId});

    Map<String, dynamic> parsedResponse = response.data;

    ReleaseModel assetsResponse = ReleaseModel.fromJson(parsedResponse);
    return assetsResponse;
  }

  //user sign in function
  Future<AssetsResponse> getNewsfeed({
    required int page,
    String? type,
    int? fromPage,
  }) async {
    print('getNewsfeed $page');
    String url = '/newsfeed?page=$page';

    if (fromPage != null) {
      url += '&fromPage=$fromPage';
    }
    final Response response = await _client.get(url);

    // Make the request and parse the response body
    Map<String, dynamic> parsedResponse = response.data;

    AssetsResponse assetsResponse = AssetsResponse.fromJson(parsedResponse);
    return assetsResponse;
  }

  Future<AssetsCommentResponse> getAssetComment({
    String? assetID,
    int? pageNumber,
    int? order,
    int? from,
  }) async {
    String url =
        '/assets/$assetID/comments?page=$pageNumber&custom_order=$order';
    if (from != null) {
      url = '$url&fromPage=$from';
    }
    final Response response = await _client.get(url);

    // Make the request and parse the response body
    Map<String, dynamic> parsedResponse = response.data;

    AssetsCommentResponse assetsResponse =
        AssetsCommentResponse.fromJson(parsedResponse);
    return assetsResponse;
  }

  Future<RegisterResponse> setAssetComment(
      {String? assetID, String? comment, String? parentID}) async {
    var data = FormData.fromMap({
      'comment': comment,
      'parent_id': parentID,
    });

    final Response response = await _client.post(
      '/assets/$assetID/comments/add',
      options: Options(contentType: "multipart/form-data"),
      data: data,
    );

    Map<String, dynamic> parsedResponse = response.data;

    RegisterResponse assetsResponse = RegisterResponse.fromJson(parsedResponse);
    checkUserPoints();
    if (assetsResponse.status == 1) {
      showSuccessMessage(
        title: AppLocalizations().addCommentTitle,
        text: assetsResponse.message!,
      );
    }
    return assetsResponse;
  }

  Future<QuestionResponse> getFanQuestions({
    int? pageNumber,
    int? type = 0,
    int? order,
  }) async {
    final Response response = await _client.get(
      '/fan-questions?page=$pageNumber&filter_type=$type&custom_order=$order',
    );

    Map<String, dynamic> parsedResponse = response.data;

    QuestionResponse questionsResponse =
        QuestionResponse.fromJson(parsedResponse);
    return questionsResponse;
  }

  Future<FanRankingModel> getFanRanking() async {
    final Response response = await _client.get('/fan-ranking');

    Map<String, dynamic> parsedResponse = response.data;

    FanRankingModel fanRankingResponse =
        FanRankingModel.fromJson(parsedResponse);

    return fanRankingResponse;
  }

  Future<FanRankingPointSystem> getPointSystem() async {
    final Response response = await _client.get('/fan-ranking-point-system');

    Map<String, dynamic> parsedResponse = response.data;

    FanRankingPointSystem fanRankingPointSystemResponse =
        FanRankingPointSystem.fromJson(parsedResponse);

    return fanRankingPointSystemResponse;
  }

  Future<RegisterResponse> addFanQuestion({
    String? question,
    String? parentID,
  }) async {
    var data = FormData.fromMap({
      'question': question,
      'parent_id': parentID,
    });

    final Response response = await _client.post(
      '/fan-questions/add',
      options: Options(contentType: "multipart/form-data"),
      data: data,
    );

    print("/fan-questions/add => $question");

    Map<String, dynamic> parsedResponse = response.data;

    RegisterResponse assetsResponse = RegisterResponse.fromJson(parsedResponse);
    checkUserPoints();

    if (assetsResponse.status == 1) {
      if (parentID != null) {
        showSuccessMessage(
            title: AppLocalizations().addAnswerTitle,
            text: AppLocalizations().addAnswerText);
      } else {
        showSuccessMessage(
            title: AppLocalizations().addQuestionTitle,
            text: assetsResponse.message!);
      }
    }

    return assetsResponse;
  }

  Future<RegisterResponse> addVoteToFanQuestion(
      {String? questionID, int? type = 1}) async {
    final Response response = await _client.post(
        '/fan-questions/$questionID/vote',
        queryParameters: <String, dynamic>{'type': type});

    Map<String, dynamic> parsedResponse = response.data;

    RegisterResponse assetsResponse = RegisterResponse.fromJson(parsedResponse);
    checkUserPoints();
    return assetsResponse;
  }

  Future<RegisterResponse> addLikeToComment(
      {String? assetID, String? commentID, int? type = 1}) async {
    final Response response = await _client.post(
        '/assets/$assetID/comments/$commentID/like',
        queryParameters: <String, dynamic>{'type': type});

    Map<String, dynamic> parsedResponse = response.data;

    RegisterResponse assetsResponse = RegisterResponse.fromJson(parsedResponse);
    checkUserPoints();
    return assetsResponse;
  }

  Future<RegisterResponse> addViewCountToAsset({
    String? assetID,
  }) async {
    final Response response = await _client.post('/assets/$assetID/view');

    Map<String, dynamic> parsedResponse = response.data;

    RegisterResponse assetsResponse = RegisterResponse.fromJson(parsedResponse);
    checkUserPoints();
    return assetsResponse;
  }

  Future<RegisterResponse> addLikeToAsset({
    String? assetID,
  }) async {
    final Response response = await _client.post('/assets/$assetID/like');

    Map<String, dynamic> parsedResponse = response.data;

    RegisterResponse assetsResponse = RegisterResponse.fromJson(parsedResponse);
    checkUserPoints();
    return assetsResponse;
  }

  Future<RegisterResponse> register(
      {String? email,
      String? name,
      String? password,
      String? passwordConfirmation,
      String? username,
      String? city,
      DateTime? birthday,
      String? telephone}) async {
    var data = FormData.fromMap({
      'email': email,
      'name': name,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'user_name': username,
      'city': city,
      if (birthday != null)
        'birthday': "${birthday.year}-${birthday.month}-${birthday.day}",
      'phone_number': telephone,
    });

    Response response = await _client.post(
      '/register',
      options: Options(contentType: "multipart/form-data"),
      data: data,
    );
    RegisterResponse registerResponse =
        RegisterResponse.fromJson(response.data);

    return registerResponse;
  }

  Future<RegisterResponse> verifyRegistration({
    String? verificationCode,
    String? email,
  }) async {
    var data = FormData.fromMap({
      'email': email,
      'email_verification_code': verificationCode,
    });

    Response response = await _client.post(
      '/verify-email',
      options: Options(contentType: "multipart/form-data"),
      data: data,
    );

    RegisterResponse registerResponse =
        RegisterResponse.fromJson(response.data);

    return registerResponse;
  }

  Future<RegisterResponse> applyDigitalFanBoxCode({
    String? email,
    String? fanBoxCode,
  }) async {
    var data = FormData.fromMap({
      'email': email,
      'digital_fan_box_code': fanBoxCode,
    });

    Response response = await _client.post(
      '/activate-digital-fan-box',
      options: Options(contentType: "multipart/form-data"),
      data: data,
    );

    RegisterResponse registerResponse =
        RegisterResponse.fromJson(response.data);

    return registerResponse;
  }

  Future<List<DigitalFanBoxes>> getFanBoxes() async {
    Response response = await _client.get('/digital-fan-boxes');

    FanBoxesModel fanBoxResponse = FanBoxesModel.fromJson(response.data);

    return fanBoxResponse.digitalFanBoxes ?? [];
  }

  Future<RegisterResponse> forgotPassword({
    String? email,
  }) async {
    var data = FormData.fromMap({
      'email': email,
    });

    Response response = await _client.post(
      '/forgot-password',
      options: Options(contentType: "multipart/form-data"),
      data: data,
    );
    RegisterResponse registerResponse =
        RegisterResponse.fromJson(response.data);

    return registerResponse;
  }

  Future<RegisterResponse> sendSupport({
    String? message,
  }) async {
    var data = FormData.fromMap({
      'message': message,
    });

    Response response = await _client.post(
      '/contact-support',
      options: Options(contentType: "multipart/form-data"),
      data: data,
    );

    RegisterResponse registerResponse =
        RegisterResponse.fromJson(response.data);

    return registerResponse;
  }

  Future<ProfileResponse> getProfile() async {
    Response response = await _client.get('/profile');
    ProfileResponse profile = ProfileResponse.fromJson(response.data);
    return profile;
  }

  Future<dynamic> checkAuthToken() async {
    try {
      await _client.get('/check-auth-token');
    } on DioError catch (e) {
      IGrooveAPI().reset();

      AppModel().currentPageIndex = 0;

      await Navigator.of(AppKeys.navigatorKey.currentState!.context)
          .pushReplacementNamed(AppRoutes.login)
          .then((Object? v) {});
      print(e.toString());
    }
  }

  Future<RegisterResponse> createNewsfeed({
    required String text,
    File? file,
    required String fileType,
    String? fileName,
    String? id,
    File? thumbnail,
    int? userId,
    required int assetType,
    required bool hideFromNewsfeed,
  }) async {
    String _fileName = '';
    String _thumbnailFileName = '';
    switch (assetType) {
      case 3:
        _fileName = "${DateTime.now().microsecondsSinceEpoch}_feed.jpg";
        break;
      case 2:
        if (fileName == null && file != null) {
          String fileExtension = file.path.split('.').last;
          _fileName =
              "${DateTime.now().microsecondsSinceEpoch}_feed.$fileExtension";
        } else {
          _fileName = fileName ?? "";
        }
        break;
      case 1:
        if (file == null) break;
        String fileExtension = file.path.split('.').last;
        _fileName =
            "${DateTime.now().microsecondsSinceEpoch}_feed.$fileExtension";
        break;
    }

    if (thumbnail != null) {
      String fileExtension = thumbnail.path.split('.').last;
      _thumbnailFileName =
          "${DateTime.now().microsecondsSinceEpoch}_thumb.$fileExtension";
    }

    var data = FormData.fromMap({
      'assetId': id,
      'assetType': assetType,
      'artist': UserService.userData!.payload!.user!.userName,
      'title': text,
      if (hideFromNewsfeed) 'show_only_in_notification': 1,
      'description': text,
      if (userId != null) 'target_user_id': userId,
      if (file != null)
        'file': await MultipartFile.fromFile(
          file.path,
          filename: _fileName,
        ),
      if (thumbnail != null)
        'thumbnail_file': await MultipartFile.fromFile(
          thumbnail.path,
          filename: _thumbnailFileName,
        ),
    });

    debugPrint(data.fields.toString());
    Response response = await _client.post(
      '/newsfeed/add',
      options: Options(contentType: "multipart/form-data"),
      data: data,
    );

    RegisterResponse registerResponse =
        RegisterResponse.fromJson(response.data);

    return registerResponse;
  }

  Future<RegisterResponse> archiveNewsfeed({required String assetID}) async {
    Response response = await _client.post(
      '/newsfeed/$assetID/archive',
      options: Options(contentType: "multipart/form-data"),
    );

    RegisterResponse registerResponse =
        RegisterResponse.fromJson(response.data);

    showSuccessMessage(
      title: AppLocalizations().generalSuccessArchivedTitle!,
      text: AppLocalizations().generalSuccessArchivedText!,
    );

    return registerResponse;
  }

  Future<RegisterResponse> togglePinNewsfeed(
      {required String assetID, required bool wasPinned}) async {
    Response response = await _client.post(
      '/newsfeed/$assetID/toggle-pin',
      options: Options(contentType: "multipart/form-data"),
    );

    RegisterResponse registerResponse =
        RegisterResponse.fromJson(response.data);

    showSuccessMessage(
      title: wasPinned
          ? AppLocalizations().generalSuccessUnpinTitle!
          : AppLocalizations().generalSuccessPinTitle!,
      text: wasPinned
          ? AppLocalizations().generalSuccessUnpinText!
          : AppLocalizations().generalSuccessPinText!,
    );

    return registerResponse;
  }

  Future<RegisterResponse> archiveComment({
    required int commentID,
    required String assetID,
  }) async {
    Response response = await _client.post(
      '/assets/$assetID/comments/$commentID/archive',
      options: Options(contentType: "multipart/form-data"),
    );

    RegisterResponse registerResponse =
        RegisterResponse.fromJson(response.data);

    showSuccessMessage(
      title: AppLocalizations().generalSuccessArchivedTitle!,
      text: AppLocalizations().generalSuccessArchivedText!,
    );

    return registerResponse;
  }

  Future<RegisterResponse> archiveQuestion({required int questionID}) async {
    Response response = await _client.post(
      '/fan-questions/$questionID/archive',
      options: Options(contentType: "multipart/form-data"),
    );

    RegisterResponse registerResponse =
        RegisterResponse.fromJson(response.data);

    showSuccessMessage(
      title: AppLocalizations().generalSuccessArchivedTitle!,
      text: AppLocalizations().generalSuccessArchivedText!,
    );

    return registerResponse;
  }

  Future<RegisterResponse> reportAsset({required String assetID}) async {
    Response response = await _client.post(
      '/assets/$assetID/report',
      options: Options(contentType: "multipart/form-data"),
    );

    RegisterResponse registerResponse =
        RegisterResponse.fromJson(response.data);

    return registerResponse;
  }

  Future<RegisterResponse> sendFirebaseToken({required String token}) async {
    var data = FormData.fromMap({
      'firebase_token': token,
    });

    Response response = await _client.post(
      '/save-firebase-token',
      options: Options(contentType: "multipart/form-data"),
      data: data,
    );

    RegisterResponse registerResponse =
        RegisterResponse.fromJson(response.data);

    return registerResponse;
  }

  Future<RegisterResponse> reportQuestion({
    required int questionID,
    int reportType = 0,
  }) async {
    var data = FormData.fromMap({
      'type': reportType,
    });

    Response response = await _client.post(
      '/fan-questions/$questionID/report',
      options: Options(contentType: "multipart/form-data"),
      data: data,
    );

    showSuccessMessage(
      title: AppLocalizations().generalSuccessReportedTitle!,
      text: AppLocalizations().generalSuccessReportedText!,
    );

    RegisterResponse registerResponse =
        RegisterResponse.fromJson(response.data);

    return registerResponse;
  }

  Future<RegisterResponse> reportComment({
    required int commentID,
    required String assetID,
    int reportType = 0,
  }) async {
    var data = FormData.fromMap({
      'type': reportType,
    });

    Response response = await _client.post(
      '/assets/$assetID/comments/$commentID/report',
      options: Options(contentType: "multipart/form-data"),
      data: data,
    );

    RegisterResponse registerResponse =
        RegisterResponse.fromJson(response.data);

    showSuccessMessage(
      title: AppLocalizations().generalSuccessReportedTitle!,
      text: AppLocalizations().generalSuccessReportedText!,
    );

    return registerResponse;
  }

  showSuccessMessage({
    required String title,
    String? text,
  }) async {
    await showGeneralDialog(
      context: AppKeys.navigatorKey.currentState!.overlay!.context,
      barrierColor: IGrooveTheme.colors.black!.withOpacity(0.3),
      barrierDismissible: false,
      barrierLabel: 'chooseDate',
      transitionDuration: const Duration(milliseconds: 0),
      pageBuilder: (BuildContext context, Animation<double> animation1,
          Animation<double> animation2) {
        return SuccessDialog(
            title: title, message: text, clickBack: 1, celebration: false);
      },
    );
  }

  Future<RegisterResponse> setProfile({
    required ProfileResponse profile,
  }) async {
    Map<String, dynamic> profileJson = profile.payload!.toJson();

    Response response = await _client.post(
      '/update-profile',
      options: Options(contentType: "multipart/form-data"),
      data: FormData.fromMap({
        ...profileJson,
        if (profile.payload?.profilePictureFile != null)
          'profile_picture': await MultipartFile.fromFile(
            profile.payload!.profilePictureFile!.path,
            filename:
                "${UserService.userData!.payload!.user!.userName}_profile.jpg",
          ),
      }),
    );

    RegisterResponse registerResponse =
        RegisterResponse.fromJson(response.data);

    return registerResponse;
  }

  Future<RegisterResponse> requestPhoneVerify() async {
    Response response = await _client.post(
      '/request-phone-number-verify-sms',
      options: Options(contentType: "multipart/form-data"),
    );

    RegisterResponse registerResponse =
        RegisterResponse.fromJson(response.data);

    return registerResponse;
  }

  Future<RegisterResponse> deleteUser() async {
    Response response = await _client.post('/user-delete',
        options: Options(contentType: "multipart/form-data"));

    RegisterResponse registerResponse =
        RegisterResponse.fromJson(response.data);

    return registerResponse;
  }

  Future<RegisterResponse> verifyPhone({
    required String code,
  }) async {
    var data = FormData.fromMap({
      'code': code,
    });

    Response response = await _client.post(
      '/verify-phone-number',
      options: Options(contentType: "multipart/form-data"),
      data: data,
    );

    RegisterResponse registerResponse =
        RegisterResponse.fromJson(response.data);

    return registerResponse;
  }
}

class RegisterResponse {
  int? status;
  String? message;

  RegisterResponse({this.status, this.message});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}

class LoginResponse {
  int? status;
  String? token;
  Payload? payload;

  LoginResponse({this.status, this.token, this.payload});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    payload =
        json['payload'] != null ? Payload.fromJson(json['payload']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['token'] = token;
    if (payload != null) {
      data['payload'] = payload!.toJson();
    }
    return data;
  }
}

class Payload {
  User? user;
  List<DigitalFanBoxes>? digitalFanBoxes;

  Payload({this.user, this.digitalFanBoxes});

  Payload.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['digitalFanBoxes'] != null) {
      digitalFanBoxes = <DigitalFanBoxes>[];
      json['digitalFanBoxes'].forEach((v) {
        digitalFanBoxes!.add(DigitalFanBoxes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (digitalFanBoxes != null) {
      data['digitalFanBoxes'] =
          digitalFanBoxes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? profilePicture;
  String? city;
  String? userName;
  String? email;
  String? userProfilePictureUrl;
  String? firebaseTopic;
  bool? isArtist;
  int? fanPoints;
  int? fanRankingPosition;
  bool? hasDigitalFanBoxCodeApplied;
  String? phoneNumber;
  String? birthday;
  bool? phoneNumberVerified;

  User(
      {this.id,
      this.name,
      this.profilePicture,
      this.city,
      this.userName,
      this.firebaseTopic,
      this.fanRankingPosition,
      this.email,
      this.userProfilePictureUrl,
      this.isArtist,
      this.fanPoints,
      this.hasDigitalFanBoxCodeApplied,
      this.phoneNumber,
      this.birthday,
      this.phoneNumberVerified});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profilePicture = json['profile_picture'];
    city = json['city'];
    firebaseTopic = json['firebase_topic'];
    userName = json['user_name'];
    email = json['email'];
    fanRankingPosition = json['fanranking_position'] ?? 0;
    isArtist = json['is_artist'] == 1 ? true : false;
    userProfilePictureUrl = json['user_profile_picture_url'];
    hasDigitalFanBoxCodeApplied = json['has_digital_fan_box_code_applied'];
    fanPoints = json['fan_points'];
    phoneNumber = json['phone_number'];
    birthday = json['birthday'];
    phoneNumberVerified = json['phone_number_verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['profile_picture'] = profilePicture;
    data['city'] = city;
    data['firebase_topic'] = firebaseTopic;
    data['user_name'] = userName;
    data['email'] = email;
    data['user_profile_picture_url'] = userProfilePictureUrl;
    data['fanranking_position'] = fanRankingPosition;
    data['birthday'] = birthday;
    data['phone_number'] = phoneNumber;
    data['fan_points'] = fanPoints;
    data['has_digital_fan_box_code_applied'] = hasDigitalFanBoxCodeApplied;
    data['is_artist'] = isArtist! ? 1 : 0;
    data['phone_number_verified'] = phoneNumberVerified;
    return data;
  }
}

class DigitalFanBoxes {
  int? id;
  String? artists;
  String? title;
  String? cover;
  String? releaseDate;
  String? coverUrl;
  int? releaseDateTimestamp;
  bool? hasAccess;
  String? dynamicLink;

  DigitalFanBoxes(
      {this.id,
      this.artists,
      this.title,
      this.cover,
      this.releaseDate,
      this.dynamicLink,
      this.coverUrl,
      this.releaseDateTimestamp,
      this.hasAccess});

  DigitalFanBoxes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    artists = json['artists'];
    title = json['title'];
    cover = json['cover'];
    dynamicLink = json['dynamic_link'];
    releaseDate = json['release_date'];
    coverUrl = json['cover_url'];
    releaseDateTimestamp = json['release_date_timestamp'];
    hasAccess = json['has_access'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['artists'] = artists;
    data['title'] = title;
    data['cover'] = cover;
    data['dynamic_link'] = dynamicLink;
    data['release_date'] = releaseDate;
    data['cover_url'] = coverUrl;
    data['has_access'] = hasAccess;
    data['release_date_timestamp'] = releaseDateTimestamp;
    return data;
  }
}
