import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:igroove_fan_box_one/constants/assets.dart';
import 'package:igroove_fan_box_one/localization/localization.dart';
import 'package:igroove_fan_box_one/ui/shared/themes.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    Key? key,
    this.text,
  }) : super(key: key);

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
            IGrooveAssets.svgRocket,
            height: 100,
            width: 100,
          ),
          const SizedBox(height: 15),
          Container(
            width: 275,
            child: Text(
              text ?? AppLocalizations.of(context)!.generalNoData!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                height: 1.29,
                fontWeight: FontWeight.w400,
                color: IGrooveTheme.colors.black!.withOpacity(0.75),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
