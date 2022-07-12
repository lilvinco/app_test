import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:igroove_fan_box_one/constants/assets.dart';
import 'package:igroove_fan_box_one/localization/localization.dart';
import 'package:igroove_fan_box_one/ui/shared/themes.dart';
import 'package:igroove_fan_box_one/ui/shared/typography.dart';
import 'package:igroove_fan_box_one/ui/widgets/loading_overlay.dart';

import 'attention_dialog.dart';

class IGrooveDialog {
  final String? title;
  final String? message;
  final Widget? widget;

  IGrooveDialog(this.title, this.message, {this.widget});

  static bool isLoadingShown = false;

  Future show(BuildContext context) async {
    isLoadingShown = true;

    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 15.0),
            contentPadding: const EdgeInsets.all(0),
            titlePadding: const EdgeInsets.all(0),
            title: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 15, 15, 3),
                        child: SvgPicture.asset(
                          IGrooveAssets.svgClose,
                          height: 12,
                          width: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                if (title != "")
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            title!,
                            maxLines: 5,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 21.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Graphik'),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (title != "") const SizedBox(height: 15),
                Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.7,
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            message!,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 15,
                                color: IGrooveTheme.colors.lightGrey,
                                height: 21 / 15,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Graphik'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            content: Container(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 0.0),
                ],
              ),
            ),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
          );
        }).then((value) {
      isLoadingShown = false;
    });
  }

  static Future showWarning(
    BuildContext context, {
    String? title,
    String? message,
  }) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 15.0),
          contentPadding: const EdgeInsets.all(0),
          titlePadding: const EdgeInsets.all(0),
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 3),
                      child: SvgPicture.asset(
                        IGrooveAssets.svgClose,
                        height: 12,
                        width: 12,
                      ),
                    ),
                  ),
                ],
              ),
              SvgPicture.asset(
                IGrooveAssets.svgAttentionIcon,
                height: 50,
                width: 50,
              ),
              const SizedBox(height: 20),
              if (title != "")
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    title!,
                    maxLines: 5,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 21.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Graphik'),
                  ),
                ),
              if (title != "") const SizedBox(height: 15),
              Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.7,
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          message!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              color: IGrooveTheme.colors.lightGrey,
                              height: 21 / 15,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Graphik'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 30,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  decoration: BoxDecoration(
                    color: IGrooveTheme.colors.grey2,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.generalClose!,
                    style: IGrooveFonts.kBodyMedium16,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 0.0),
              ],
            ),
          ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
        );
      },
    );
  }

  Future showWidget(BuildContext context) async {
    isLoadingShown = true;

    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 15.0),
            contentPadding: const EdgeInsets.all(0),
            titlePadding: const EdgeInsets.all(0),
            title: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 15, 15, 3),
                        child: SvgPicture.asset(
                          IGrooveAssets.svgClose,
                          height: 12,
                          width: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                if (title != "")
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text(
                          title!,
                          maxLines: 5,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 21.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Graphik',
                          ),
                        ),
                      ],
                    ),
                  ),
                if (title != "") const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                  child: widget,
                ),
              ],
            ),
            content: Container(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 0.0),
                ],
              ),
            ),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
          );
        }).then((value) {
      isLoadingShown = false;
    });
  }

  static Future showLoading(BuildContext context,
      {bool isTransparentHeader = true}) async {
    isLoadingShown = true;

    await Future.delayed(
      const Duration(seconds: 0),
      () {
        showGeneralDialog(
          context: context,
          barrierColor: IGrooveTheme.colors.transparent!,
          transitionDuration: const Duration(milliseconds: 0),
          barrierDismissible: false,
          pageBuilder: (BuildContext context, animation, secondartAnimation) {
            return Container(
                height: MediaQuery.of(context).size.height + 30,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top),
                      height: IGrooveTheme.headerHeight,
                      color: isTransparentHeader
                          ? IGrooveTheme.colors.transparent
                          : IGrooveTheme.colors.white,
                      // color: IGrooveTheme.colors.transparent,
                    ),
                    Expanded(
                      child: Container(
                        color: IGrooveTheme.colors.white,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const SizedBox(height: 10),
                            const IGrooveProgressIndicator(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ));
          },
        );
      },
    );
  }

  static Future<bool?> showConfirmation(
    BuildContext context, {
    String? title,
    String? message,
    String? confirmText,
    String? cancelText,
    bool? showTrashCan,
  }) async {
    bool? confirmed = await showGeneralDialog(
      context: context,
      barrierColor: IGrooveTheme.colors.black!.withOpacity(0.3),
      barrierDismissible: false,
      barrierLabel: 'chooseDate',
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext context, animation1, animation2) {
        return AttentionDialog(
          showTrashCan: showTrashCan ?? true,
          showComfirm: true,
          title: title ?? "Are you really want to leave the process?",
          message: message ?? "All your changes will get lost!",
          confirmText: confirmText ?? "Discard changes and leave",
          cancelText: cancelText ?? "Continue",
        );
      },
    );

    return confirmed;
  }

  static hideDialog(BuildContext context) {
    isLoadingShown = false;
    Navigator.of(context).pop();
  }
}
