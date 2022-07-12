import 'package:flutter/material.dart';
import 'package:igroove_fan_box_one/localization/localization.dart';
import 'package:igroove_fan_box_one/ui/shared/themes.dart';

class SwiperField extends StatelessWidget {
  SwiperField({
    this.value = false,
    this.enabled = true,
    this.noText = false,
    this.roundedDesign = false,
    required this.onChanged,
  });

  final bool? value;
  final Function(bool) onChanged;
  final bool enabled;
  final bool noText;
  final bool roundedDesign;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          width: roundedDesign ? 60 : 80,
          height: 34,
          decoration: BoxDecoration(
            color: !value!
                ? IGrooveTheme.colors.white10
                : IGrooveTheme.colors.green5,
            borderRadius: BorderRadius.circular(roundedDesign ? 34 : 8),
          ),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: enabled ? () => onChanged(!value!) : null,
            child: Stack(
              children: [
                AnimatedAlign(
                  alignment:
                      !value! ? Alignment.centerLeft : Alignment.centerRight,
                  duration: const Duration(milliseconds: 150),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(roundedDesign ? 26 : 4),
                          color: IGrooveTheme.colors.white,
                          border: Border.all(
                            color: IGrooveTheme.colors.white3!,
                            width: 1,
                          ),
                        ),
                        width: 26,
                        height: 26),
                  ),
                ),
                if (!noText)
                  value!
                      ? Row(
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context)!.generalYes!,
                                  style: TextStyle(
                                    color: IGrooveTheme.colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            const SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context)!.generalNo!,
                                  style: TextStyle(
                                      color: IGrooveTheme.colors.black!
                                          .withOpacity(0.5),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        ),
              ],
            ),
          ),
        );
      },
    );
  }
}
