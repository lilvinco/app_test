import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:igroove_fan_box_one/constants/assets.dart';
import 'package:igroove_fan_box_one/localization/localization.dart';

import '../../shared/themes.dart';
import 'base.dart';

class IGrooveYearField extends StatefulWidget {
  const IGrooveYearField({
    Key? key,
    this.initialValue,
    required this.label,
    this.descriptionText,
    required this.hintText,
    this.suffixIcon,
    this.validator,
    this.readOnly = false,
    this.onChanged,
    this.focusNode,
    this.onEditingComplete,
    this.padding,
  }) : super(key: key);

  final String? initialValue;
  final String label;
  final String? descriptionText;
  final String hintText;
  final bool readOnly;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String?>? onChanged;
  final FocusNode? focusNode;
  final Function(String?)? onEditingComplete;
  final EdgeInsets? padding;

  @override
  _IGrooveYearFieldState createState() => _IGrooveYearFieldState();
}

class _IGrooveYearFieldState extends State<IGrooveYearField> {
  TextEditingController controller = TextEditingController();
  FocusNode? focusNode;
  GlobalKey? globalKey;

  List<String?>? years;

  @override
  void initState() {
    years = List<String?>.generate(
      55,
      (int i) => DateTime(1970 + i).year.toString(),
    );

    focusNode = widget.focusNode ?? FocusNode();
    globalKey ??= GlobalKey();

    controller.text = widget.initialValue ?? DateTime.now().year.toString();
    super.initState();
  }

  Future select(BuildContext context, FormFieldState<String> state,
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

  Future<void> showCupertinoPicker(FormFieldState<String> state) async {
    await showCupertinoModalPopup<Widget>(
      context: context,
      builder: (BuildContext context) {
        int selectedIndex;

        selectedIndex = years!.indexOf(state.value);

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
                    final String selected = years![value]!;
                    controller.text = selected;

                    final String val = selected;

                    state.didChange(val);
                    if (widget.onChanged != null) widget.onChanged!(val);
                  },
                  itemExtent: 32.0,
                  children: years != null
                      ? years!
                          .map(
                            (String? val) => Text(
                              val!,
                              style: TextStyle(
                                color: IGrooveTheme.colors.grey,
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

  Future<void> showDefaultPicker(FormFieldState<String> state) async {
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
                      children: years!
                          .map(
                            (String? value) => ListTile(
                              leading: state.value == value
                                  ? Icon(
                                      Icons.radio_button_checked,
                                      color: IGrooveTheme.colors.primary,
                                    )
                                  : const Icon(
                                      Icons.radio_button_unchecked,
                                    ),
                              onTap: () {
                                controller.text = value!;

                                state.didChange(value);

                                innerState(() {});

                                if (widget.onChanged != null) {
                                  widget.onChanged!(value);
                                }
                              },
                              title: Text(
                                value!,
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
          FormField<String>(
            enabled: !widget.readOnly,
            validator: widget.validator,
            initialValue: widget.initialValue ?? DateTime.now().year.toString(),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            builder: (FormFieldState<String> state) {
              if (widget.initialValue != null) {
                controller.text = widget.initialValue!;
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
