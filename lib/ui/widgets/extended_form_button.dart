import 'package:flutter/material.dart';
import 'package:igroove_fan_box_one/constants/assets.dart';
import 'package:igroove_fan_box_one/ui/shared/themes.dart';
import 'package:igroove_fan_box_one/ui/shared/typography.dart';

class ExtendedFormButton extends StatelessWidget {
  const ExtendedFormButton({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 10,
          width: double.infinity,
          decoration: BoxDecoration(
            color: IGrooveTheme.colors.whiteColor!.withOpacity(0.75),
            border: Border.symmetric(
              horizontal: BorderSide(
                width: 1,
                color: IGrooveTheme.colors.whiteColor!,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: onTap as void Function()?,
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.symmetric(
              vertical: 18,
              horizontal: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: IGrooveFonts.kBodyMedium16,
                ),
                ImageIcon(
                  AssetImage(IGrooveAssets.iconChevronRight),
                  size: 14,
                  color: Colors.black,
                )
              ],
            ),
          ),
        ),
        Container(
          height: 10,
          width: double.infinity,
          decoration: BoxDecoration(
            color: IGrooveTheme.colors.whiteColor!.withOpacity(0.75),
            border: Border.symmetric(
              horizontal: BorderSide(
                width: 1,
                color: IGrooveTheme.colors.whiteColor!,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
