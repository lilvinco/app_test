library fields;

import 'package:flutter/material.dart';
import 'package:igroove_fan_box_one/constants/assets.dart';
import 'package:igroove_fan_box_one/localization/localization.dart';
import 'package:igroove_fan_box_one/ui/shared/themes.dart';

export 'package:igroove_fan_box_one/ui/widgets/input_fields/checkbox_field.dart';
export 'package:igroove_fan_box_one/ui/widgets/input_fields/date_field.dart';
export 'package:igroove_fan_box_one/ui/widgets/input_fields/select_field.dart';
export 'package:igroove_fan_box_one/ui/widgets/input_fields/swiper_field.dart';
export 'package:igroove_fan_box_one/ui/widgets/input_fields/tags_field.dart';
export 'package:igroove_fan_box_one/ui/widgets/input_fields/text_field.dart';
export 'package:igroove_fan_box_one/ui/widgets/input_fields/text_space.dart';

InputDecoration kInnerInputDecoration = InputDecoration(
  labelStyle: TextStyle(
    color: Colors.black.withOpacity(0.8),
    fontSize: 14,
    fontWeight: FontWeight.w500,
  ),
  hintStyle: TextStyle(
    fontSize: 16,
    color: IGrooveTheme.colors.black!.withOpacity(0.3),
    letterSpacing: -0.19,
    //height: 1,
  ),
  errorMaxLines: 3,
  errorStyle: TextStyle(
    fontSize: 13,
    color: IGrooveTheme.colors.red,
  ),
  isDense: true,
  border: UnderlineInputBorder(
      borderSide: BorderSide(color: IGrooveTheme.colors.white3!)),
  enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: IGrooveTheme.colors.white3!)),
  focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: IGrooveTheme.colors.primary!, width: 2)),
  focusedErrorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: IGrooveTheme.colors.primary!, width: 2)),
  errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: IGrooveTheme.colors.white3!)),
  disabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: IGrooveTheme.colors.white3!)),
  contentPadding: const EdgeInsets.only(top: 15, bottom: 15),
);

InputDecoration fanBoxInputDecoration = InputDecoration(
  labelStyle: TextStyle(
    color: IGrooveTheme.colors.white!,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  ),
  hintStyle: TextStyle(
    fontSize: 16,
    color: IGrooveTheme.colors.white!.withOpacity(0.75),
    letterSpacing: 0,
    //height: 1,
  ),
  errorMaxLines: 3,
  errorStyle: TextStyle(
    fontSize: 13,
    color: IGrooveTheme.colors.red,
  ),
  isDense: true,
  border: InputBorder.none,
  enabledBorder: InputBorder.none,
  focusedBorder: InputBorder.none,
  focusedErrorBorder: InputBorder.none,
  errorBorder: InputBorder.none,
  disabledBorder: InputBorder.none,
  contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
);

class FieldHelper extends StatelessWidget {
  const FieldHelper({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  final String? title;
  final String? description;

  open(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 13.0),
          // title: const Text(
          //   "", //title ?? AppLocalizations.of(context).none,
          //   textAlign: TextAlign.center,
          //   style: const TextStyle(fontSize: 21.0,
          //fontWeight: FontWeight.bold),
          // ),
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                Container(
                  width: double.maxFinite,
                  child: SingleChildScrollView(
                    child: ListBody(
                      children: [
                        Text(
                          description ??
                              AppLocalizations.of(context)!.generalNoData!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            height: 21 / 16,
                            letterSpacing: -0.3,
                            color: IGrooveTheme.colors.lightGrey,
                            fontFamily: 'Graphik',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                SizedBox(
                  height: 40.0,
                  width: double.maxFinite,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.transparent),
                      primary: IGrooveTheme.colors.whiteColor,
                      padding: const EdgeInsets.all(0),
                      backgroundColor: IGrooveTheme.colors.whiteColor,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.generalClose!,
                          style: TextStyle(
                              fontSize: 15.0,
                              color: IGrooveTheme.colors.lightGrey),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => open(context),
      child: Container(
        height: 18,
        width: 18,
        child: Image.asset(
          IGrooveAssets.questionMarkGreyDark,
          color: kInnerInputDecoration.labelStyle!.color,
        ),
      ),
    );
  }
}
