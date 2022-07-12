import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:igroove_fan_box_one/constants/assets.dart';
import 'package:igroove_fan_box_one/localization/localization.dart';
import 'package:igroove_fan_box_one/ui/shared/themes.dart';

class ErrorAlertParams {
  final String? title;
  final String? message;

  ErrorAlertParams({
    this.title,
    this.message,
  });
}

class ErrorAlert extends StatelessWidget {
  const ErrorAlert({
    Key? key,
    this.parameters,
  }) : super(key: key);

  final ErrorAlertParams? parameters;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        width: double.maxFinite,
        padding: const EdgeInsets.all(21),
        decoration: BoxDecoration(
          color: IGrooveTheme.colors.black3,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: IGrooveTheme.colors.black!,
              offset: const Offset(0.0, 5),
              blurRadius: 50.0,
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 0),
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        IGrooveAssets.svgWarningNewIcon,
                        height: 50,
                        width: 50,
                        //color: IGrooveTheme.colors.primary,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        parameters!.title!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 21,
                            height: 24 / 21,
                            letterSpacing: -0.35,
                            fontWeight: FontWeight.w600,
                            color: IGrooveTheme.colors.white,
                            decoration: TextDecoration.none,
                            fontFamily: "Graphik"),
                      ),
                      parameters!.message != null
                          ? Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(31, 15, 31, 40),
                              child: LimitedBox(
                                maxHeight: 250,
                                // height: 250,
                                child: SingleChildScrollView(
                                  child: Text(
                                    parameters!.message!,
                                    style: TextStyle(
                                        fontSize: 16,
                                        height: 21 / 16,
                                        fontWeight: FontWeight.w400,
                                        color: IGrooveTheme.colors.white,
                                        decoration: TextDecoration.none,
                                        fontFamily: "Graphik"),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                      GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.89,
                            height: 46,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)!.generalClose!,
                                style: TextStyle(
                                    color: IGrooveTheme.colors.primary,
                                    height: 19 / 16,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    decoration: TextDecoration.none,
                                    fontFamily: "Graphik"),
                              ),
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
