import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:igroove_fan_box_one/constants/assets.dart';
import 'package:igroove_fan_box_one/localization/localization.dart';

import '../../shared/themes.dart';
import 'base.dart';

class IGrooveSelectField<T> extends StatefulWidget {
  const IGrooveSelectField({
    Key? key,
    this.initialValue,
    this.options,
    required this.label,
    this.descriptionText,
    required this.hintText,
    this.suffixIcon,
    this.validator,
    this.readOnly = false,
    this.onChanged,
    this.itemHeight = 32.0,
    this.displayOutside,
    required this.displayValue,
    this.isSelected,
    this.focusNode,
    this.onEditingComplete,
    this.padding,
    this.underlined = false,
  }) : super(key: key);

  final T? initialValue;
  final String label;
  final String? descriptionText;
  final String hintText;
  final bool readOnly;
  final double itemHeight;

  final Widget? suffixIcon;
  final FormFieldValidator<T>? validator;
  final List<T>? options;
  final ValueChanged<T>? onChanged;
  final FocusNode? focusNode;
  final Function(T)? onEditingComplete;
  final Function(T)? isSelected;
  final EdgeInsets? padding;
  final bool underlined;

  final String? Function(T) displayValue;
  final String Function(T)? displayOutside;

  @override
  _IGrooveSelectFieldState<T> createState() => _IGrooveSelectFieldState<T>();
}

class _IGrooveSelectFieldState<T> extends State<IGrooveSelectField<T?>> {
  TextEditingController controller = TextEditingController();
  FocusNode? focusNode;
  GlobalKey? globalKey;

  @override
  void initState() {
    focusNode = widget.focusNode ?? FocusNode();
    globalKey ??= GlobalKey();

    if (widget.initialValue != null) {
      if (widget.displayOutside != null) {
        controller.text = widget.displayOutside!(widget.initialValue);
      } else {
        controller.text = widget.displayValue(widget.initialValue)!;
      }
    }
    super.initState();
  }

  Future select(BuildContext context, FormFieldState<T> state,
      {bool ensureVisible = false}) async {
    {
      FocusScope.of(context).unfocus();

      if (ensureVisible) {
        await Scrollable.ensureVisible(globalKey!.currentContext!,
            alignment: 0.1, duration: const Duration(milliseconds: 500));
      }

      await Future.delayed(const Duration(milliseconds: 250));

      await showCupertinoPicker(state);
    }
  }

  Future<void> showCupertinoPicker(FormFieldState<T> state) async {
    await showCupertinoModalPopup<Widget>(
      context: context,
      builder: (BuildContext context) {
        int selectedIndex;
        if (widget.isSelected != null) {
          selectedIndex =
              widget.options!.indexWhere((e) => widget.isSelected!(e));
        } else {
          selectedIndex = widget.options?.indexOf(state.value) ?? 0;
        }

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
                    onPressed: () {
                      Navigator.of(context).pop();
                      if (widget.onEditingComplete != null) {
                        widget.onEditingComplete!(state.value);
                      }
                    },
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 30),
                height: MediaQuery.of(context).size.height * 0.25,
                child: CupertinoPicker(
                  scrollController: FixedExtentScrollController(
                    initialItem: selectedIndex,
                  ),
                  onSelectedItemChanged: (int value) {
                    final T? selected = widget.options![value];
                    if (widget.displayOutside != null) {
                      controller.text = widget.displayOutside!(selected);
                    } else {
                      controller.text = widget.displayValue(selected)!;
                    }

                    final T? val = selected;

                    state.didChange(val);
                    if (widget.onEditingComplete != null) {
                      widget.onEditingComplete!(state.value);
                    }
                    if (widget.onChanged != null) widget.onChanged!(val);
                  },
                  itemExtent: widget.itemHeight,
                  children: widget.options != null
                      ? widget.options!
                          .map(
                            (T? val) => Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  widget.displayValue(val)!,
                                  maxLines: 3,
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  style: TextStyle(
                                    color: IGrooveTheme.colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList()
                      : [],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> showDefaultPicker(FormFieldState<T> state) async {
    await showModalBottomSheet<Widget>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (BuildContext context, innerState) {
          return Container(
            color: IGrooveTheme.colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: Text(AppLocalizations.of(context)!.generalDone!),
                      onPressed: () {
                        Navigator.of(context).pop();
                        if (widget.onEditingComplete != null) {
                          widget.onEditingComplete!(state.value);
                        }
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: widget.options!
                          .map(
                            (value) => ListTile(
                              leading: state.value == value
                                  ? Icon(
                                      Icons.radio_button_checked,
                                      color: IGrooveTheme.colors.primary,
                                    )
                                  : const Icon(
                                      Icons.radio_button_unchecked,
                                    ),
                              onTap: () {
                                if (widget.displayOutside != null) {
                                  controller.text =
                                      widget.displayOutside!(value);
                                } else {
                                  controller.text = widget.displayValue(value)!;
                                }

                                state.didChange(value);

                                innerState(() {});

                                if (widget.onChanged != null) {
                                  widget.onChanged!(value);
                                }
                              },
                              title: Text(
                                widget.displayValue(value)!,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: globalKey,
      padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
          FormField<T>(
            enabled: !widget.readOnly,
            validator: widget.validator,
            initialValue: widget.initialValue,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            builder: (FormFieldState<T> state) {
              if (widget.initialValue != null) {
                if (widget.displayOutside != null) {
                  controller.text = widget.displayOutside!(widget.initialValue);
                } else {
                  controller.text = widget.displayValue(widget.initialValue)!;
                }
              } else {
                controller.text = '';
              }

              return Focus(
                focusNode: focusNode,
                onFocusChange: (bool focused) {
                  if (focused == true) {
                    select(context, state, ensureVisible: true);
                  }
                },
                child: InkWell(
                  onTap: () async {
                    if (!widget.readOnly) await select(context, state);
                  },
                  child: TextField(
                    enabled: false,
                    controller: controller,
                    style: kInnerInputDecoration.hintStyle!.copyWith(
                      color: IGrooveTheme.colors.black,
                    ),
                    minLines: 1,
                    maxLines: 3,
                    decoration: kInnerInputDecoration.copyWith(
                      suffixIconConstraints: const BoxConstraints(maxWidth: 30),
                      suffixIcon: Visibility(
                        visible: widget.readOnly != true,
                        child: widget.suffixIcon ??
                            ImageIcon(
                              AssetImage(IGrooveAssets.iconChevronDown),
                              size: 14,
                              color: Colors.black,
                            ),
                      ),
                      disabledBorder: kInnerInputDecoration.enabledBorder,
                      hintText: widget.hintText,
                      errorText: state.errorText,
                      hintStyle: kInnerInputDecoration.hintStyle!.copyWith(),
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
}
