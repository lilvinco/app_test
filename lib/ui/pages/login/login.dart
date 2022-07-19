import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Checkbox;
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:igroove_fan_box_one/base/base.dart';
import 'package:igroove_fan_box_one/config.dart';
import 'package:igroove_fan_box_one/constants/assets.dart';
import 'package:igroove_fan_box_one/core/networking/custom_exception.dart';
import 'package:igroove_fan_box_one/core/services/general_service.dart';
import 'package:igroove_fan_box_one/core/services/user_service.dart';
import 'package:igroove_fan_box_one/localization/localization.dart';
import 'package:igroove_fan_box_one/management/app_model.dart';
import 'package:igroove_fan_box_one/management/helper.dart';
import 'package:igroove_fan_box_one/ui/pages/common/error_alert.dart';
import 'package:igroove_fan_box_one/ui/widgets/buttons.dart';
import 'package:igroove_fan_box_one/ui/widgets/input_fields/base.dart';
import 'package:provider/provider.dart';
import 'package:version/version.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  String? email = kDebugMode ? "test@igroove.ch" : null;
  String? password = kDebugMode ? "Test.2206" : null;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => initPlugin());
    checkUserCredentialsInSecureStorage();
  }

  Future<void> initPlugin() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final TrackingStatus status =
          await AppTrackingTransparency.trackingAuthorizationStatus;
      // setState(() => _authStatus = '$status');
      // If the system can show an authorization request dialog
      if (status == TrackingStatus.notDetermined) {
        //Show a custom explainer dialog before the system dialog
        //if (await showCustomTrackingDialog(context)) {
        // Wait for dialog popping animation
        await Future.delayed(const Duration(milliseconds: 200));
        // Request system's tracking authorization dialog
        await AppTrackingTransparency.requestTrackingAuthorization();
        // setState(() => _authStatus = '$status');
        //}
      }
    } on PlatformException {
      // setState(() => _authStatus = 'PlatformException was thrown');
    }

    final String uuid =
        await AppTrackingTransparency.getAdvertisingIdentifier();
    print("UUID: $uuid");
  }

  Future<bool> showCustomTrackingDialog(BuildContext context) async =>
      await (showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Dear User'),
          content: const Text(
            'We care about your privacy and data security.'
            ' We keep this app free by showing ads. '
            'Can we continue to use your data to tailor ads for'
            ' you?\n\nYou can change your choice anytime in the app settings. '
            'Our partners will collect data and use a unique'
            ' identifier on your device to show you ads.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("I'll decide later"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Allow tracking'),
            ),
          ],
        ),
      ) as FutureOr<bool>?) ??
      false;

  signIn(
    String? usernameText,
    String? passwordText,
  ) async {
    if (usernameText == "empty" || passwordText == "empty") {
      usernameText = email;
      passwordText = password;
    }
    setState(() => isLoading = true);
    try {
      UserService userService =
          Provider.of(AppKeys.navigatorKey.currentContext!, listen: false);

      await userService.signIn(
        email: usernameText,
        password: passwordText,
        saveCredentials: isChecked,
      );
      AppModel().appinfo.setFailedLogin(false);

      await Navigator.of(AppKeys.navigatorKey.currentContext!)
          .pushNamedAndRemoveUntil(AppRoutes.home, (Route e) => false);
    } on MinAppVersionException {
      GeneralService _generalService =
          Provider.of(AppKeys.navigatorKey.currentContext!, listen: false);
      await _generalService.systemInfo();
    } on CustomException catch (e, stacktrace) {
      print(e.toString());
      print(stacktrace.toString());

      print("failedLogin =>" + AppModel().appinfo.failedLogin.toString());

      if (!AppModel().appinfo.failedLogin) {
        Navigator.of(context).pop();
        AppModel().appinfo.setFailedLogin(true);
      }

      print("failedLogin after =>" + AppModel().appinfo.failedLogin.toString());

      unawaited(Navigator.pushNamed(context, AppRoutes.errorAlert,
          arguments: ErrorAlertParams(
              title: AppLocalizations.of(context)!.generalDialogSorry!,
              message: e.toString())));
      setState(() => isLoading = false);
    } catch (e, stacktrace) {
      print(e.toString());
      print(stacktrace.toString());

      setState(() => isLoading = false);
    }
  }

  Future _checkVersion() async {
    GeneralService _generalService = Provider.of(context, listen: false);
    await _generalService.systemInfo();

    if (Platform.isIOS) {
      if (Version.parse(Configs.APP_VERSION) <
          Version.parse(
              _generalService.systemData!.appInstance!.iosAppVersion)) {
        throw MinAppVersionException();
      }
    } else if (Platform.isAndroid) {
      if (Version.parse(Configs.APP_VERSION) <
          Version.parse(
              _generalService.systemData!.appInstance!.androidAppVersion)) {
        throw MinAppVersionException();
      }
    }
  }

  Future<void> checkUserCredentialsInSecureStorage() async {
    setState(() {
      isLoading = true;
    });
    String? userCredentialIsSaved = await _storage.read(key: 'igrooveissaved');
    isChecked = userCredentialIsSaved == 'yes';
    if (mounted) {
      setState(() {});
    }
    if (userCredentialIsSaved == 'yes') {
      email = await (_storage.read(key: 'igrooveusername')) ?? '';
      password = await (_storage.read(key: 'igroovepassword')) ?? '';
    }
    bool emailValid = RegExp(RegularExpressions.email).hasMatch(email!);

    try {
      await _checkVersion();
    } on MinAppVersionException {
      return;
    }

    if (email != "" &&
        password != "" &&
        emailValid &&
        !AppModel().appinfo.failedLogin) {
      signIn("empty", "empty");
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return loadingWidget();
    }

    return Scaffold(
      body: body(),
      backgroundColor: IGrooveTheme.colors.black2,
    );
  }

  Widget body() {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 60),
            Text(
              AppLocalizations.of(context)!.loginWelcometext!,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 35,
                  letterSpacing: -1.4,
                  height: 35 / 35,
                  fontWeight: FontWeight.w600,
                  color: IGrooveTheme.colors.white),
            ),
            const SizedBox(height: 20),
            Image.asset(
              IGrooveAssets.introPNG,
              height: 291,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitWidth,
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    //emailErrorMessage(),
                    IGrooveTextField(
                      label:
                          AppLocalizations.of(context)!.loginEmailFieldLabel!,
                      initialValue: email,
                      hintText:
                          AppLocalizations.of(context)!.loginEmailFieldHint!,
                      onSaved: (val) => email = val,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return AppLocalizations.of(context)!
                              .loginEmailFieldValidationEmpty!;
                        }

                        bool emailValid =
                            RegExp(RegularExpressions.email).hasMatch(val);

                        if (!emailValid) {
                          return AppLocalizations.of(context)!
                              .loginEmailFieldValidationRegex!;
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    IGrooveTextField(
                      label: AppLocalizations.of(context)!
                          .loginPasswordFieldLabel!,
                      initialValue: password,
                      obscureText: true,
                      hintText:
                          AppLocalizations.of(context)!.loginPasswordFieldHint!,
                      onSaved: (val) => password = val,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return AppLocalizations.of(context)!
                              .loginPasswordFieldValidationEmpty!;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // Flexible(
                        //   flex: 1,
                        //   child: _buildRememberCheckBox(),
                        // ),
                        const SizedBox(width: 10),
                        // Expanded(
                        //   flex: 1,
                        //   child: forgotPassword(),
                        // )
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            signInButton(),
            const SizedBox(height: 20),
            // registerButton(),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }

  Widget signInButton() {
    return FanBoxOutlineButton(
      onPressed: () {
        if (!_formKey.currentState!.validate()) return;
        _formKey.currentState!.save();
        bool emailValid = RegExp(RegularExpressions.email).hasMatch(email!);
        if (email != "" && password != "" && emailValid) {
          signIn("empty", "empty");
        }
      },
      labelText: AppLocalizations.of(context)!.loginButton!,
    );
  }

  Widget registerButton() {
    return Theme(
      data: ThemeData(
        splashColor: IGrooveTheme.colors.transparent,
        highlightColor: IGrooveTheme.colors.transparent,
        focusColor: IGrooveTheme.colors.transparent,
        hoverColor: IGrooveTheme.colors.transparent,
      ),
      child: Container(
        margin: const EdgeInsets.only(top: 0),
        //height: screenHeight < 667 ? screenHeight / 15 : 46,
        width: MediaQuery.of(context).size.width,
        child: Container(
          child: InkWell(
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.loginRegisterButton!,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  color: IGrooveTheme.colors.white,
                ),
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.register);
              //Navigator.of(context).pushNamed(AppRoutes.magicCode);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildRememberCheckBox() {
    return IGrooveCheckboxField(
      shape: CheckboxShape.square,
      inactiveBackgroundColor: IGrooveTheme.colors.transparent,
      activeBackgroundColor: IGrooveTheme.colors.white!.withOpacity(0.75),
      checkColor: IGrooveTheme.colors.primary,
      borderColor: IGrooveTheme.colors.white!.withOpacity(0.75),
      value: isChecked,
      onChanged: (value) => setState(() => isChecked = value),
      crossAxisAlignment: CrossAxisAlignment.center,
      title: FittedBox(
        child: Text(
          AppLocalizations.of(context)!.loginSaveButton!,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              height: 14 / 12,
              color: IGrooveTheme.colors.white!.withOpacity(0.75)),
        ),
      ),
    );
  }

  Widget forgotPassword() {
    return Theme(
      data: ThemeData(
        splashColor: IGrooveTheme.colors.transparent,
        highlightColor: IGrooveTheme.colors.transparent,
        focusColor: IGrooveTheme.colors.transparent,
        hoverColor: IGrooveTheme.colors.transparent,
      ),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(0),
            side: const BorderSide(color: Colors.transparent),
            splashFactory: NoSplash.splashFactory,
          ),
          child: FittedBox(
            child: Text(
              AppLocalizations.of(context)!.loginForgetPasswordButton!,
              style: TextStyle(
                color: IGrooveTheme.colors.primary,
                fontSize: 14,
                height: 14 / 12,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
