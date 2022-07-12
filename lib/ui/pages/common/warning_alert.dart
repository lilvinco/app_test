import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:igroove_fan_box_one/constants/assets.dart';
import 'package:igroove_fan_box_one/localization/localization.dart';
import 'package:igroove_fan_box_one/ui/shared/themes.dart';
import 'package:igroove_fan_box_one/ui/shared/typography.dart';

class WarningAlertParams {
  final String? title;
  final String? message;
  final Widget? icon;

  WarningAlertParams({this.title, this.message, this.icon});
}

class WarningAlert extends StatelessWidget {
  const WarningAlert({
    Key? key,
    this.parameters,
  }) : super(key: key);

  final WarningAlertParams? parameters;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.3,
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 15 / 375,
          ),
          child: Column(
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
              const SizedBox(height: 12),
              parameters!.icon ??
                  SvgPicture.asset(
                    IGrooveAssets.svgAttentionIcon,
                    height: 60,
                    width: 60,
                  ),
              const SizedBox(height: 17),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: Text(
                  parameters!.title!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 21,
                    color: IGrooveTheme.colors.lightGrey,
                    height: 21 / 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: Text(
                  parameters!.message!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: IGrooveTheme.colors.lightGrey,
                    height: 1.4,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: double.infinity,
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
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
