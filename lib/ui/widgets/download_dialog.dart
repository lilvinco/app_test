import 'dart:async';

import 'package:flutter/material.dart';
import 'package:igroove_fan_box_one/constants/assets.dart';
import 'package:igroove_fan_box_one/localization/localization.dart';
import 'package:igroove_fan_box_one/ui/shared/themes.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:rxdart/rxdart.dart';
// import 'package:percent_indicator/percent_indicator.dart';

class DownloadDialog extends StatefulWidget {
  final Subject<String?> percentSender;
  final bool isDimissible;
  final int total;
  final int current;
  final String? title;

  const DownloadDialog(
    this.percentSender, {
    Key? key,
    this.isDimissible = false,
    this.current = 1,
    this.total = 1,
    this.title,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DownloadDialogState();
  }
}

class _DownloadDialogState extends State<DownloadDialog>
    with TickerProviderStateMixin {
  int progressBarValue = 0;
  AnimationController? controller;
  Animation<double>? animation;
  late StreamSubscription streamSubscription;

  @override
  void initState() {
    _initSubjectForPercent();
    super.initState();
  }

  _initSubjectForPercent() {
    streamSubscription = widget.percentSender.stream.listen((String? percent) {
      if (mounted) {
        setState(() {
          progressBarValue = double.parse(percent!).toInt();
        });

        if (progressBarValue == 100 && !streamSubscription.isPaused) {
          streamSubscription.pause();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: IGrooveTheme.colors.transparent,
        child: Stack(
          children: [
            Container(
              height: 100,
              color: IGrooveTheme.colors.black2,
              width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (widget.title != null)
                    Row(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Text(
                            widget.title!,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16, color: IGrooveTheme.colors.white),
                          ),
                        ),
                      ],
                    ),
                  Row(
                    children: <Widget>[
                      Text(
                        widget.current.toString() +
                            "/" +
                            widget.total.toString(),
                        style: TextStyle(
                            fontSize: 13, color: IGrooveTheme.colors.white),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        progressBarValue == 0
                            ? AppLocalizations().generalDownloadWillBePrepared!
                            : progressBarValue.toString() + "%",
                        style: TextStyle(
                            fontSize: 18, color: IGrooveTheme.colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  LinearPercentIndicator(
                    backgroundColor: IGrooveTheme.colors.black2,
                    progressColor: IGrooveTheme.colors.white,
                    percent: (progressBarValue / 100) >= 0 &&
                            (progressBarValue / 100) <= 1
                        ? (progressBarValue / 100)
                        : 0,
                    padding: const EdgeInsets.only(left: 3),
                  ),
                ],
              ),
            ),
            if (widget.isDimissible == true)
              Positioned(
                right: 0,
                top: 0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 1),
                      child: Container(
                        height: 34,
                        width: 34,
                        child: Center(
                          child: ImageIcon(
                            AssetImage(IGrooveAssets.iconClose),
                            color: Colors.black,
                            size: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
