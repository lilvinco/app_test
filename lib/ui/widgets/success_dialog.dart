import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:igroove_fan_box_one/constants/assets.dart';
import 'package:igroove_fan_box_one/localization/localization.dart';
import 'package:igroove_fan_box_one/ui/shared/themes.dart';

class SuccessDialog extends StatefulWidget {
  final String? title;
  final String? message;
  final String? confirmText;
  final int? clickBack;
  final bool? celebration;
  final Function()? onClose;

  const SuccessDialog({
    Key? key,
    this.title,
    this.message,
    this.confirmText,
    this.clickBack,
    this.celebration,
    this.onClose,
  }) : super(key: key);

  @override
  _SuccessDialogState createState() => _SuccessDialogState();
}

class _SuccessDialogState extends State<SuccessDialog> {
  late ConfettiController _controllerCenter;

  @override
  void initState() {
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));

    if (widget.celebration != null && widget.celebration == true) {
      _controllerCenter.play();
      // 500 ok
      Future.delayed(const Duration(milliseconds: 200)).then((value) {});
    }
    super.initState();
  }

  @override
  void dispose() {
    _controllerCenter.dispose();

    super.dispose();
  }

  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const int numberOfPoints = 5;
    final double halfWidth = size.width / 2;
    final double externalRadius = halfWidth;
    final double internalRadius = halfWidth / 2.5;
    final double degreesPerStep = degToRad(360 / numberOfPoints);
    final double halfDegreesPerStep = degreesPerStep / 2;
    final Path path = Path();
    final double fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

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
              color: IGrooveTheme.colors.black!.withOpacity(0.1),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        IGrooveAssets.svgSuccessNewIcon,
                        height: 50,
                        width: 50,
                        //color: IGrooveTheme.colors.primary,
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: widget.message != null ? 0 : 40),
                        child: Text(
                          widget.title!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 21,
                              height: 24 / 21,
                              letterSpacing: -0.35,
                              fontWeight: FontWeight.w600,
                              color: IGrooveTheme.colors.white,
                              decoration: TextDecoration.none,
                              fontFamily: 'Graphik'),
                        ),
                      ),
                      widget.message != null
                          ? Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(31, 15, 31, 40),
                              child: Text(
                                widget.message!,
                                style: TextStyle(
                                  fontSize: 16,
                                  height: 21 / 16,
                                  fontWeight: FontWeight.w400,
                                  color: IGrooveTheme.colors.white,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'Graphik',
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : const SizedBox(),
                      GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            if (widget.clickBack != null) {
                              for (int i = 0; i < widget.clickBack!; i++) {
                                Navigator.pop(context, () {});
                              }
                            }

                            if (widget.onClose != null) {
                              widget.onClose!();
                            }

                            setState(() {});
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
                                  fontFamily: 'Graphik',
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                  Center(
                    child: ConfettiWidget(
                      confettiController: _controllerCenter,
                      blastDirectionality: BlastDirectionality.explosive,
                      shouldLoop: true,
                      colors: [
                        IGrooveTheme.colors.green!,
                        IGrooveTheme.colors.blue!,
                        IGrooveTheme.colors.pink!,
                        IGrooveTheme.colors.orange!,
                        IGrooveTheme.colors.primary!
                      ], // manually specify the colors to be used
                      createParticlePath:
                          drawStar, // define a custom shape/path.
                    ),
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
