import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:igroove_fan_box_one/constants/assets.dart';
import 'package:igroove_fan_box_one/ui/shared/themes.dart';

enum CheckboxShape { square, circle }

class IGrooveCheckboxField extends StatelessWidget {
  final bool? value;
  final Function? onChanged;
  final FormFieldSetter<bool>? onSaved;
  final FormFieldValidator<bool>? validator;
  final Widget? title;
  final double size;

  final Color? checkColor;
  final Color? borderColor;
  final Color? activeBackgroundColor;
  final Color? inactiveBackgroundColor;
  final CheckboxShape shape;
  final CrossAxisAlignment crossAxisAlignment;

  IGrooveCheckboxField({
    this.value,
    this.onChanged,
    this.title,
    this.onSaved,
    this.validator,
    this.checkColor,
    this.borderColor,
    this.size = 25.0,
    this.inactiveBackgroundColor,
    this.activeBackgroundColor,
    this.shape = CheckboxShape.circle,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<bool>(
      initialValue: value,
      validator: validator,
      onSaved: onSaved,
      builder: (FormFieldState state) {
        // if (value != state.value) {
        //   if (state.value != null) {
        //     state.didChange(value);
        //   }
        // }
        return GestureDetector(
          onTap: () {
            bool value = !(state.value ?? false);
            state.didChange(value);

            if (onChanged != null) onChanged!(value);
          },
          child: Container(
            color: IGrooveTheme.colors.transparent,
            child: Row(
              crossAxisAlignment: crossAxisAlignment,
              children: <Widget>[
                AbsorbPointer(
                  child: Visibility(
                    visible: shape != CheckboxShape.circle,
                    child: SquareCheckBox(
                      value: value,
                      borderColor: borderColor,
                      activeBackgroundColor: activeBackgroundColor,
                      inactiveBackgroundColor: inactiveBackgroundColor,
                      checkColor: checkColor,
                      size: size,
                      onChanged: (value) {
                        state.didChange(value);

                        if (onChanged != null) onChanged!(value);
                      },
                    ),
                    replacement: _CircularCheckBox(
                      value: state.value,
                      borderColor: borderColor,
                      activeBackgroundColor: activeBackgroundColor,
                      inactiveBackgroundColor: inactiveBackgroundColor,
                      checkColor: checkColor,
                      size: size,
                      onChanged: (value) {
                        state.didChange(value);

                        if (onChanged != null) onChanged!(value);
                      },
                    ),
                  ),
                ),
                if (title != null)
                  Expanded(
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 2),
                              title!,
                              Visibility(
                                visible: state.errorText != null,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const SizedBox(height: 5),
                                    Text(
                                      state.errorText ?? '',
                                      style: TextStyle(
                                        color: IGrooveTheme.colors.red,
                                        fontSize: 13,
                                      ),
                                      maxLines: 3,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CircularCheckBox extends StatelessWidget {
  _CircularCheckBox({
    required this.value,
    required this.onChanged,
    this.checkColor,
    this.borderColor,
    this.size,
    this.activeBackgroundColor,
    this.inactiveBackgroundColor,
  });

  final bool? value;
  final double? size;
  final Function(bool) onChanged;

  final Color? checkColor;
  final Color? borderColor;
  final Color? activeBackgroundColor;
  final Color? inactiveBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value!),
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: borderColor ?? IGrooveTheme.colors.primary!,
            width: 2,
          ),
          color: value!
              ? (activeBackgroundColor ?? IGrooveTheme.colors.primary)
              : (inactiveBackgroundColor ?? IGrooveTheme.colors.white),
        ),
        child: Center(
          child: value!
              ? Image.asset(
                  IGrooveAssets.iconCheck,
                  height: size,
                  width: size,
                  color: checkColor ?? IGrooveTheme.colors.white,
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}

class SquareCheckBox extends StatelessWidget {
  SquareCheckBox({
    required this.value,
    required this.onChanged,
    this.checkColor,
    this.borderColor,
    this.size,
    this.activeBackgroundColor,
    this.inactiveBackgroundColor,
    this.disabled = false,
  });

  final bool? value;
  final Function(bool) onChanged;
  final double? size;

  final Color? checkColor;
  final Color? borderColor;
  final Color? activeBackgroundColor;
  final Color? inactiveBackgroundColor;

  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !disabled ? () => onChanged(!value!) : null,
      child: Container(
        height: size,
        width: size,
        // decoration: BoxDecoration(
        //   shape: BoxShape.rectangle,
        //   borderRadius: const BorderRadius.all(Radius.circular(5)),
        //   border: Border.all(
        //     color: borderColor ?? IGrooveTheme.colors.primary,
        //     width: 2,
        //   ),
        // color: value
        //     ? (activeBackgroundColor ?? IGrooveTheme.colors.primary)
        //     : (inactiveBackgroundColor ?? IGrooveTheme.colors.white),
        // ),
        child: Center(
          child: !value!
              ? SvgPicture.asset(
                  IGrooveAssets.svgCheckboxUnselected2,
                  height: 20,
                  width: 20,
                  color: borderColor,
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child: SvgPicture.asset(
                    IGrooveAssets.svgCheckboxSelected,
                    height: 20,
                    width: 20,
                    colorBlendMode: BlendMode.color,
                    color: IGrooveTheme.colors.primary,
                  ),
                ),
        ),
      ),
    );
  }
}
