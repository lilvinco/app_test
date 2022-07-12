import 'package:flutter/material.dart';
import 'package:igroove_fan_box_one/ui/shared/themes.dart';

class SubTitleHeader extends StatelessWidget {
  SubTitleHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              height: 34,
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: IGrooveTheme.colors.whiteColor!))),
              //color: IGrooveTheme.colors.whiteColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: IGrooveTheme.colors.black!.withOpacity(0.8),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      letterSpacing: -0.16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
