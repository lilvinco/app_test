class AppInfoManagement {
  bool _isDragging = false;
  bool get getCurrentDrag => _isDragging;

  bool _failedLogin = false;
  bool get failedLogin => _failedLogin;

  setFailedLogin(bool failed) {
    _failedLogin = failed;
  }

  setCurrentDrag(bool isDragging) {
    _isDragging = isDragging;
  }

  int _productDetailTabIndex = 0;
  int get getproductDetailTabIndex => _productDetailTabIndex;

  setProductDetailTabIndex(int productDetailTabIndex) {
    _productDetailTabIndex = productDetailTabIndex;
  }

  String _loginTime = "";
  String get getUserLoginTime => _loginTime;

  setUserLoginTime(String loginTime) {
    _loginTime = loginTime;
  }

  String _deviceInfo = "";
  double _screenWidth = 0.0;
  double _screenHeight = 0.0;

  String get getDeviceInfo => _deviceInfo;
  double get screenHeight => _screenHeight;
  double get screenWidth => _screenWidth;

  setDeviceInfo(double screenWidth, double screenHeight) {
    _screenWidth = screenWidth;
    _screenHeight = screenHeight;
    _deviceInfo = "Width: $screenWidth | Height: $screenHeight";
  }

  bool _openNewDeal = false;
  bool get showOpenNewDeal => _openNewDeal;

  setShowOpenNewDeal(bool showOpenNewDeal) {
    _openNewDeal = showOpenNewDeal;
  }

  bool _shouldDealsBeUpdated = false;
  bool get shouldDealsBeUpdated => _shouldDealsBeUpdated;

  setShouldDealsBeUpdated(bool shouldDealsBeUpdated) {
    _shouldDealsBeUpdated = shouldDealsBeUpdated;
  }

  bool _shouldDealsDetailBeUpdated = false;
  bool get shouldDealsDetailBeUpdated => _shouldDealsDetailBeUpdated;

  setShouldDealsDetailBeUpdated(bool shouldDealsDetailBeUpdated) {
    _shouldDealsDetailBeUpdated = shouldDealsDetailBeUpdated;
  }

  bool _showRejectedMessage = false;
  bool get showRejectedMessage => _showRejectedMessage;

  setShowRejectedMessage(bool showRejectedMessage) {
    _showRejectedMessage = showRejectedMessage;
  }

  bool _dealsDetailLoaded = false;
  bool get dealsDetailLoaded => _dealsDetailLoaded;

  setDealsDetailLoaded(bool dealLoaded) {
    _dealsDetailLoaded = dealLoaded;
  }

  String? _deviceConnection;
  String? get deviceConnection => _deviceConnection;

  setDeviceConnection(String deviceConnection) {
    _deviceConnection = deviceConnection;
  }

  String? _deviceIP;
  String? get deviceIP => _deviceIP;

  setDeviceIP(String deviceIP) {
    _deviceIP = deviceIP;
  }

  String? _deviceName;
  String? get deviceName => _deviceName;

  setDeviceName(String deviceName) {
    _deviceName = deviceName;
  }

  bool? _devicePhysicalDevice;
  bool? get devicePhysicalDevice => _devicePhysicalDevice;

  setDevicePhysicalDevice(bool isPhysical) {
    _devicePhysicalDevice = isPhysical;
  }
}
