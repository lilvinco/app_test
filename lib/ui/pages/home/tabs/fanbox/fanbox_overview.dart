import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:igroove_fan_box_one/api/auth.dart';
import 'package:igroove_fan_box_one/base/base.dart';
import 'package:igroove_fan_box_one/constants/assets.dart';
import 'package:igroove_fan_box_one/core/services/audio_handler.dart';
import 'package:igroove_fan_box_one/core/services/media_player_service.dart';
import 'package:igroove_fan_box_one/core/services/user_service.dart';
import 'package:igroove_fan_box_one/helpers/validators.dart';
import 'package:igroove_fan_box_one/localization/localization.dart';
import 'package:igroove_fan_box_one/management/helper.dart';
import 'package:igroove_fan_box_one/management/push_navigate_service.dart';
import 'package:igroove_fan_box_one/model/magic_code.dart';
import 'package:igroove_fan_box_one/page_notifier.dart';
import 'package:igroove_fan_box_one/ui/pages/common/error_alert.dart';
import 'package:igroove_fan_box_one/ui/pages/home/tabs/fanbox/fanbox.dart';
import 'package:igroove_fan_box_one/ui/widgets/app_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:igroove_fan_box_one/ui/widgets/input_fields/text_field.dart';
import 'package:igroove_fan_box_one/ui/widgets/success_dialog.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class FanBoxOverviewPage extends StatefulWidget {
  FanBoxOverviewPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FanBoxOverviewPageState();
  }
}

class _FanBoxOverviewPageState extends State<FanBoxOverviewPage> {
  bool isLoading = false;
  List<DigitalFanBoxes> fanBoxList = [];
  TextEditingController textEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  StreamController<ErrorAnimationType>? errorController;
  bool hasError = false;
  String currentText = "";
  String? email;

  @override
  void initState() {
    getFanBoxes();
    super.initState();
  }

  getFanBoxes() async {
    setState(() {
      isLoading = true;
    });

    await Auth.check();
    fanBoxList = UserService.userData!.payload!.digitalFanBoxes!;
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: IGrooveAppBarWidget.fanBoxAppBar(showNotifications: true)
            as PreferredSizeWidget,
        backgroundColor: IGrooveTheme.colors.fanBoxBlack,
        body: body());
  }

  Widget body() {
    if (isLoading) {
      return loadingWidget();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.bottomLeft,
            child: Text(
              "Music",
              textAlign: TextAlign.end,
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w600,
                  color: IGrooveTheme.colors.white!,
                  letterSpacing: -1.4,
                  height: 35 / 35),
            ),
          ),
          ListView.builder(
            padding: const EdgeInsets.only(top: 0),
            itemCount: fanBoxList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return fanBoxItem(fanBox: fanBoxList[index]);
            },
          ),
          const SizedBox(height: 90)
        ],
      )),
    );
  }

  Widget fanBoxItem({required DigitalFanBoxes fanBox}) {
    return GestureDetector(
      onTap: () async {
        if (!fanBox.hasAccess!) {
          showVerification(fanBox: fanBox);
        } else {
          if (DateTime.now().isAfter(DateTime.fromMillisecondsSinceEpoch(
                  fanBox.releaseDateTimestamp! * 1000)) &&
              fanBox.hasAccess!) {
            PlayerStateManager.setYPositionOfWidget(25);
            await Navigator.pushNamed(
                AppKeys.navigatorKey.currentState!.context, AppRoutes.fanBox,
                arguments: FanBoxParameters(fanBox: fanBox));
          }
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Container(
                  height: MediaQuery.of(context).size.width - 40,
                  width: MediaQuery.of(context).size.width - 40,
                  child: CachedNetworkImage(
                    imageUrl: fanBox.coverUrl!,
                    fit: BoxFit.cover,
                    placeholder: (BuildContext context, String url) => Center(
                        child: CircularProgressIndicator(
                      backgroundColor: IGrooveTheme.colors.white4,
                      valueColor: AlwaysStoppedAnimation<Color?>(
                          IGrooveTheme.colors.grey12),
                    )),
                    errorWidget: (BuildContext context, String url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              if (DateTime.now().isBefore(DateTime.fromMillisecondsSinceEpoch(
                      fanBox.releaseDateTimestamp! * 1000)) &&
                  fanBox.hasAccess!)
                Container(
                  height: MediaQuery.of(context).size.width - 40,
                  width: MediaQuery.of(context).size.width - 40,
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width - 40,
                      decoration: BoxDecoration(
                          color: IGrooveTheme.colors.fanBoxBlack,
                          border: Border.all(
                              color: IGrooveTheme.colors.white!, width: 1)),
                      child: Column(
                        children: [
                          const SizedBox(height: 11),
                          Text(
                            AppLocalizations().fanBoxOverviewAvailable!,
                            style: TextStyle(
                              color:
                                  IGrooveTheme.colors.white!.withOpacity(0.75),
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              height: 14 / 12,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            // ignore: lines_longer_than_80_chars
                            "${DateTime.fromMillisecondsSinceEpoch(fanBox.releaseDateTimestamp! * 1000).difference(DateTime.now()).inDays} ${DateTime.fromMillisecondsSinceEpoch(fanBox.releaseDateTimestamp! * 1000).difference(DateTime.now()).inDays == 1 ? AppLocalizations().fanBoxOverviewDay : AppLocalizations().fanBoxOverviewDays} "
                            // ignore: lines_longer_than_80_chars
                            "${DateTime.fromMillisecondsSinceEpoch(fanBox.releaseDateTimestamp! * 1000).difference(DateTime.now()).inHours - (DateTime.fromMillisecondsSinceEpoch(fanBox.releaseDateTimestamp! * 1000).difference(DateTime.now()).inDays * 24)} ${DateTime.fromMillisecondsSinceEpoch(fanBox.releaseDateTimestamp! * 1000).difference(DateTime.now()).inHours - (DateTime.fromMillisecondsSinceEpoch(fanBox.releaseDateTimestamp! * 1000).difference(DateTime.now()).inDays * 24) == 1 ? AppLocalizations().fanBoxOverviewHour : AppLocalizations().fanBoxOverviewHours} "
                            // ignore: lines_longer_than_80_chars
                            "${60 - DateTime.now().minute} ${60 - DateTime.now().minute == 1 ? AppLocalizations().fanBoxOverviewMinute : AppLocalizations().fanBoxOverviewMinutes}",
                            style: TextStyle(
                              color: IGrooveTheme.colors.white!,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              height: 18 / 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
                ),
            ],
          ),
          const SizedBox(height: 15),
          Text(fanBox.title!,
              style: TextStyle(
                  color: IGrooveTheme.colors.white,
                  height: 19 / 16,
                  letterSpacing: 0,
                  fontSize: 16,
                  fontWeight: FontWeight.w500)),
          const SizedBox(height: 5),
          Text(fanBox.artists!,
              style: TextStyle(
                  color: IGrooveTheme.colors.white!.withOpacity(0.75),
                  height: 17 / 14,
                  letterSpacing: 0,
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  showVerification({required DigitalFanBoxes fanBox}) async {
    textEditingController = TextEditingController();

    PlayerStateManager.setYPositionOfWidget(
        MediaQuery.of(context).size.height / 100 * 70);
    await showModalBottomSheet(
        context: AppKeys.navigatorKey.currentState!.context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter modelState) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            IGrooveTheme.colors.goldDark!,
                            IGrooveTheme.colors.black2!,
                          ],
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          topRight: Radius.circular(25.0),
                        )),
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      top: 16.5, bottom: 16.5),
                                  width: MediaQuery.of(context).size.width,
                                  height: 8,
                                  child: SvgPicture.asset(
                                    IGrooveAssets.svgArrowBoldDownIcon,
                                    width: 22,
                                    height: 8,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ]),
                        const SizedBox(height: 50),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 62),
                          child: Column(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.fanboxActivate!,
                                style: TextStyle(
                                    fontSize: 20,
                                    letterSpacing: 0,
                                    height: 20 / 20,
                                    fontWeight: FontWeight.w600,
                                    color: IGrooveTheme.colors.white,
                                    decoration: TextDecoration.none),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                AppLocalizations.of(context)!.fanboxEnterCode!,
                                style: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 0,
                                    height: 17 / 14,
                                    fontWeight: FontWeight.w500,
                                    color: IGrooveTheme.colors.white!
                                        .withOpacity(0.75),
                                    decoration: TextDecoration.none),
                              ),
                              const SizedBox(height: 50),
                              Form(
                                key: _formKey2,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 20),
                                      child: IGrooveTextField(
                                        thickBorder: true,
                                        label: AppLocalizations.of(context)!
                                            .verifyRegisterEmailFieldLabel!,
                                        hintText: AppLocalizations.of(context)!
                                            .verifyRegisterEmailFieldHint!,
                                        onSaved: (val) => email = val,
                                        validator: (val) {
                                          if (val == null || val.isEmpty) {
                                            return AppLocalizations.of(context)!
                                                // ignore: lines_longer_than_80_chars
                                                .verifyRegisterEmailFieldValidationEmpty!;
                                          }

                                          bool emailValid =
                                              RegExp(RegularExpressions.email)
                                                  .hasMatch(val);

                                          if (!emailValid) {
                                            return AppLocalizations.of(context)!
                                                // ignore: lines_longer_than_80_chars
                                                .verifyRegisterEmailFieldValidationRegex!;
                                          }

                                          return null;
                                        },
                                      ),
                                    ),
                                    PinCodeTextField(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      appContext: context,
                                      pastedTextStyle: TextStyle(
                                        color: IGrooveTheme.colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      dialogConfig: DialogConfig(),
                                      length: 4,
                                      obscureText: false,
                                      animationType: AnimationType.fade,
                                      pinTheme: PinTheme(
                                        shape: PinCodeFieldShape.box,
                                        borderRadius: BorderRadius.circular(8),
                                        inactiveColor: IGrooveTheme
                                            .colors.white!
                                            .withOpacity(0.25),
                                        fieldHeight: 55,
                                        fieldOuterPadding:
                                            const EdgeInsets.only(right: 0),
                                        fieldWidth: 55,
                                        selectedColor:
                                            IGrooveTheme.colors.white,
                                        borderWidth: 2,
                                        disabledColor: IGrooveTheme
                                            .colors.white!
                                            .withOpacity(0.25),
                                        activeFillColor: IGrooveTheme
                                            .colors.black2!
                                            .withOpacity(0.75),
                                        activeColor: IGrooveTheme.colors.white,
                                        inactiveFillColor: IGrooveTheme
                                            .colors.black2!
                                            .withOpacity(0.25),
                                        selectedFillColor: IGrooveTheme
                                            .colors.black2!
                                            .withOpacity(0.75),
                                      ),
                                      cursorColor: IGrooveTheme.colors.white,
                                      animationDuration:
                                          const Duration(milliseconds: 300),
                                      textStyle: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w500,
                                        height: 36 / 30,
                                        letterSpacing: -1.2,
                                        color: IGrooveTheme.colors.white,
                                      ),
                                      enableActiveFill: true,
                                      useExternalAutoFillGroup: true,
                                      errorAnimationController: errorController,
                                      controller: textEditingController,
                                      //keyboardType: TextInputType,
                                      onCompleted: (v) {
                                        if (v.length != 4) {
                                          errorController!
                                              .add(ErrorAnimationType.shake);
                                          setState(() {
                                            hasError = true;
                                          });
                                        } else {
                                          startVerify(currentText);
                                          setState(() {
                                            hasError = false;
                                          });
                                        }

                                        print("Completed");
                                      },
                                      onChanged: (value) {
                                        print(value);
                                        setState(() {
                                          currentText = value;
                                        });
                                      },
                                      beforeTextPaste: (text) {
                                        print("Allowing to paste $text");
                                        return false;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              OutlinedButton(
                                style: TextButton.styleFrom(
                                  splashFactory: NoSplash.splashFactory,
                                  side: const BorderSide(
                                      color: Colors.transparent),
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .verifyRegisterEmptyField!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: IGrooveTheme.colors.primary,
                                      fontSize: 16,
                                      height: 19 / 16),
                                ),
                                onPressed: () {
                                  textEditingController.clear();
                                },
                              ),
                              OutlinedButton(
                                style: TextButton.styleFrom(
                                  splashFactory: NoSplash.splashFactory,
                                  side: const BorderSide(
                                      color: Colors.transparent),
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .verifyRegisterPasteCode!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: IGrooveTheme.colors.primary,
                                      fontSize: 16,
                                      height: 19 / 16),
                                ),
                                onPressed: () async {
                                  ClipboardData? copied =
                                      await Clipboard.getData(
                                    Clipboard.kTextPlain,
                                  );
                                  String? text = copied?.text;
                                  if (text != null) {
                                    // Check if text is a four digit number
                                    if (validatePastedCode(text, 4)) {
                                      textEditingController.text = text;
                                      // Navigator.of(context).pop();
                                    } else {
                                      await Navigator.pushNamed(
                                        context,
                                        AppRoutes.errorAlert,
                                        arguments: ErrorAlertParams(
                                            title: AppLocalizations.of(context)!
                                                .generalDialogSorry!,
                                            message:
                                                AppLocalizations.of(context)!
                                                    .invalidPin!),
                                      );
                                    }
                                  } else {
                                    await Navigator.pushNamed(
                                      context,
                                      AppRoutes.errorAlert,
                                      arguments: ErrorAlertParams(
                                          title: AppLocalizations.of(context)!
                                              .generalDialogSorry!,
                                          message: AppLocalizations.of(context)!
                                              .nothingOnClipBoard!),
                                    );
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 100,
                              ),
                              if (fanBox.dynamicLink != null)
                                RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: AppLocalizations().moreInfo,
                                          style: TextStyle(
                                              color: IGrooveTheme.colors.white!
                                                  .withOpacity(0.7)),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () async {
                                              PushNavigationService
                                                  .currentPageName = "openUrl";
                                              // ignore: lines_longer_than_80_chars

                                              PushNavigationService
                                                      .currentPageName =
                                                  'more_page';
                                            },
                                        ),
                                      ],
                                    )),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
        }).whenComplete(() {
      PlayerStateManager.setYPositionOfWidget(100);
    });
  }

  startVerify(String value) {
    setState(() {
      verifyRegistration(verificationCode: value);
    });
  }

  MagicCodeData? data;

  Future verifyRegistration({
    String? verificationCode,
  }) async {
    if (!_formKey2.currentState!.validate()) {
      textEditingController.clear();
      return;
    }

    _formKey2.currentState!.save();
    UserService userService = Provider.of(context, listen: false);

    try {
      RegisterResponse response = await userService.applyDigitalFanBoxCode(
          email: email, fanBoxCode: verificationCode);

      if (response.status == 1) {
        UserService.userData!.payload!.digitalFanBoxes =
            await userService.getFanBoxes();
        fanBoxList = UserService.userData!.payload!.digitalFanBoxes!;
        setState(() {});

        await showGeneralDialog(
          context: AppKeys.navigatorKey.currentState!.overlay!.context,
          barrierColor: IGrooveTheme.colors.black!.withOpacity(0.3),
          barrierDismissible: false,
          barrierLabel: 'chooseDate',
          transitionDuration: const Duration(milliseconds: 0),
          pageBuilder: (BuildContext context, Animation<double> animation1,
              Animation<double> animation2) {
            return SuccessDialog(
                title: AppLocalizations.of(context)!.verifyRegisterFanBoxTitle!,
                message: response.message,
                clickBack: 1,
                celebration: false);
          },
        );
        Navigator.of(context).pop();
      } else {
        await Navigator.pushNamed(
          context,
          AppRoutes.errorAlert,
          arguments: ErrorAlertParams(
            title: AppLocalizations.of(context)!.generalDialogSorry!,
            message: response.message,
          ),
        );
      }
    } on DioError catch (e) {
      await Navigator.pushNamed(context, AppRoutes.errorAlert,
          arguments: ErrorAlertParams(
              title: AppLocalizations.of(context)!.generalDialogSorry!,
              message: e.toString()));
    } catch (e, stacktrace) {
      print(e.toString());
      print(stacktrace.toString());
    }
  }
}
