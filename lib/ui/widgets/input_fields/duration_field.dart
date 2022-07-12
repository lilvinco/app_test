import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:igroove_fan_box_one/base/base.dart';
import 'package:igroove_fan_box_one/localization/localization.dart';

import 'base.dart';

class IGrooveDurationField extends StatefulWidget {
  IGrooveDurationField({
    required this.label,
    required this.hintText,
    this.descriptionText,
    this.initialValue,
    this.onSaved,
    this.onChanged,
    this.validator,
    this.focusNode,
    this.enabled = true,
    this.onEditingComplete,
    this.underlined = true,
  });

  final String label;
  final String? descriptionText;
  final String hintText;
  final bool enabled;
  final bool underlined;

  final FormFieldSetter<Duration>? onSaved;
  final FormFieldValidator<Duration>? validator;
  final ValueChanged<Duration>? onChanged;

  final Duration? initialValue;

  final FocusNode? focusNode;
  final Function()? onEditingComplete;

  @override
  _IGrooveDurationFieldState createState() => _IGrooveDurationFieldState();
}

class _IGrooveDurationFieldState extends State<IGrooveDurationField> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    if (widget.initialValue != null) {
      controller.text = widget.initialValue.toString().substring(2, 7);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 0.0),
            child: Row(
              children: [
                Text(
                  widget.label,
                  style: kInnerInputDecoration.labelStyle,
                ),
                const SizedBox(width: 5),
                if (widget.descriptionText != null)
                  FieldHelper(
                    title: widget.label,
                    description: widget.descriptionText,
                  ),
              ],
            ),
          ),
          FormField<Duration>(
            validator: widget.validator,
            initialValue: widget.initialValue,
            onSaved: widget.onSaved,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            builder: (FormFieldState state) {
              return InkWell(
                onTap: widget.enabled ? () => selectDate(context, state) : null,
                child: IgnorePointer(
                  child: TextFormField(
                    focusNode: widget.focusNode,
                    controller: controller,
                    enabled: widget.enabled,
                    maxLines: 1,
                    keyboardType: TextInputType.datetime,
                    style: kInnerInputDecoration.hintStyle!.copyWith(
                      color: IGrooveTheme.colors.black,
                    ),
                    decoration: kInnerInputDecoration.copyWith(
                      enabled: widget.enabled,
                      hintText: widget.hintText,
                      errorText: state.errorText,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future selectDate(BuildContext context, FormFieldState state) async {
    {
      FocusScope.of(context).unfocus();

      if (Platform.isIOS) {
        await showCupertinoPicker(state);
      } else {
        await showCupertinoPicker(state);
      }
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  Future<void> showCupertinoPicker(FormFieldState state) async {
    await showCupertinoModalPopup<Widget>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: IGrooveTheme.colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CupertinoButton(
                    child: Text(AppLocalizations.of(context)!.generalDone!),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 30),
                height: MediaQuery.of(context).size.height * 0.25,
                child: CupertinoTimerPicker(
                  mode: CupertinoTimerPickerMode.ms,
                  initialTimerDuration: state.value ?? Duration.zero,
                  onTimerDurationChanged: (Duration duration) {
                    controller.text = _formatDuration(duration);

                    state.didChange(duration);

                    if (widget.onChanged != null) {
                      widget.onChanged!(duration);
                    }

                    if (widget.onEditingComplete != null) {
                      widget.onEditingComplete!();
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

// Future<void> showDefaultPicker(FormFieldState state) async {
//   final DateTime pickedDate = await TimerPicker(
//     context: context,
//     initialTime: widget.initialValue,
//     builder: (BuildContext context, Widget child) {
//       return Theme(
//         data: ThemeData.light().copyWith(
//           colorScheme: const ColorScheme(
//             primary: Color(0xff0D18DE),
//             primaryVariant: Colors.black,
//             secondary: Colors.white,
//             secondaryVariant: Colors.white,
//             surface: Colors.white,
//             background: Colors.white,
//             error: Colors.red,
//             onPrimary: Colors.white,
//             onSecondary: Colors.black,
//             onSurface: Colors.black,
//             onBackground: Colors.black,
//             onError: Colors.white,
//             brightness: Brightness.light,
//           ),
//           primaryColor: const Color(0xff0D18DE),
//         ),
//         child: child ?? const SizedBox.shrink(),
//       );
//     },
//   );
//
//   if (pickedDate != null) {
//     controller.text = DateFormat(widget.dateFormat).format(pickedDate);
//     state.didChange(pickedDate);
//
//     if (widget.onChanged != null) {
//       widget.onChanged(pickedDate);
//     }
//
//     if (widget.onEditingComplete != null) {
//       widget.onEditingComplete();
//     }
//   }
// }
}
