/// Configuation parameters for Score App
class Configs {
  /*****************************************************************************
   * App Configs
   ****************************************************************************/

  /// Current app version
  static const String APP_VERSION = "1.0.17";

  /// Is the current app an whitelabel app
  static const bool APP_WHITELABEL = false;

  /// The currently runing environment
  static ENV appENV = ENV.DEV;

  /// Development Server URL
  static String cloutRootUrlDev = CLOUD_DEV_SERVER;

  /// **************************************************************************
  /// Version / Feature Configs
  ///**************************************************************************/

  // V1.2.11
  // REVSHARE FEE INTRODUCED
  // EMPTY SCREENS INTRODUCED

  // V1.2.12
  static bool appFeatureForceUpdate = true;
  static bool appFeatureProfilPictureUpload = true;
  static bool appFeatureDropbox = false;
  static bool appFeatureInternationalBankInfo = true;

  // V1.2.13
  static bool appFeatureReleaseManagement = true;
  static bool appFeatureShowReleaseTags = true;
  static bool appFeatureShowReleaseTickets = true;
  static bool appFeatureReleaseSortFunction = true;

  // V1.2.19
  static bool appFeatureDemoAccount = true;
  static bool appFeatureServices = true;
  static bool appFeatureDisableDetailCharts = true;
  static bool appFeatureReports = true;
  static bool appFeatureToDoList = true;

  /// **************************************************************************
  /// White label Configs
  ///***************************************************************************/

  // App name (Change this for whitelabel)
  static const APP_NAME = APP_WHITELABEL == true ? 'Wolfpack' : 'Cataleya';

  /// Cloud path
  static const CLOUD_PATH = APP_WHITELABEL == true ? '/api' : '/api';

  /*****************************************************************************
   * Cloud Configs
   ****************************************************************************/

  /// Local Server URL
  static const CLOUD_ROOT_URL_LOCAL = 'dev.fanapp.io';
  static const CLOUD_ROOT_URL_DEV1 = 'dev.fanapp.io';
  static const CLOUD_ROOT_URL_DEV2 = 'dev.fanapp.io';
  static const CLOUD_ROOT_URL_DEV3 = 'dev.fanapp.io';
  static const CLOUD_ROOT_URL_DEV4 = 'dev.fanapp.io';
  static const CLOUD_ROOT_URL_DEMO = 'dev.fanapp.io';
  static const CLOUD_DEV_SERVER = 'dev.fanapp.io';

  /// Production server URL
  static const CLOUD_ROOT_URL_PROD = 'dev.fanapp.io';

  /// Server sign in Client ID. This is not the user ID.
  static const CLOUD_CLEINT_ID_DEV = 'test';
  static const CLOUD_CLEINT_ID_PROD = 'test';

  /// Server sign in SECRET. This is not the user password.
  static const CLOUD_CLEINT_SECRET_DEV = 'afsddfs78fdasgfds78ds';
  static const CLOUD_CLEINT_SECRET_PROD = 'afsddfs78fdasgfds78ds';
  static const APP_INSTANCE_TOKEN =
      'WI1aIV7LEbErLaBegUMNJ5CaTgT7MnQqxP3lpe9cLoQxsaZMMq';

  static String get cloudURL => appENV == ENV.DEV
      ? cloutRootUrlDev
      : appENV == ENV.PROD
          ? CLOUD_ROOT_URL_PROD
          : CLOUD_ROOT_URL_LOCAL;

  static String get clientID =>
      appENV == ENV.DEV ? CLOUD_CLEINT_ID_DEV : CLOUD_CLEINT_ID_PROD;

  static String get clientSecret =>
      appENV == ENV.DEV ? CLOUD_CLEINT_SECRET_DEV : CLOUD_CLEINT_SECRET_PROD;

  static String get credentials =>
      '?api_user=$CLOUD_CLEINT_ID_DEV' '&api_pass=$CLOUD_CLEINT_SECRET_PROD';
}

/// App Environments
/// - DEV - Development
/// - PROD - Production
enum ENV { DEV, PROD, LOCAL }
