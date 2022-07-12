// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:igroove_fan_box_one/base/base.dart';
import 'package:igroove_fan_box_one/constants/assets.dart';
import 'package:intl/intl.dart';

import 'base.dart';

class IGrooveDateField extends StatefulWidget {
  IGrooveDateField({
    required this.label,
    required this.hintText,
    this.descriptionText,
    this.initialValue,
    this.onSaved,
    this.onChanged,
    this.validator,
    this.focusNode,
    this.switchHintColor = false,
    this.futureDate = false,
    this.showWeekDay = false,
    this.onEditingComplete,
    required this.firstDate,
    required this.lastDate,
    this.dateFormat = 'EEE d. MMM yyyy',
    this.underlined = false,
    Key? key,
  }) : super(key: key);

  final String label;
  final String? descriptionText;
  final String hintText;
  final bool futureDate;
  final bool switchHintColor;

  final FormFieldSetter<DateTime>? onSaved;
  final FormFieldValidator<DateTime>? validator;
  final ValueChanged<DateTime>? onChanged;

  final DateTime? initialValue;
  final DateTime firstDate;
  final DateTime lastDate;

  final FocusNode? focusNode;
  final Function(DateTime)? onEditingComplete;

  final String dateFormat;
  final bool showWeekDay;
  final bool underlined;

  @override
  _IGrooveDateFieldState createState() => _IGrooveDateFieldState();
}

class _IGrooveDateFieldState extends State<IGrooveDateField> {
  TextEditingController controller = TextEditingController();
  FocusNode? focusNode;
  GlobalKey? globalKey;

  @override
  void initState() {
    globalKey = GlobalKey();
    focusNode = widget.focusNode ?? FocusNode();

    if (widget.initialValue != null) {
      controller.text =
          DateFormat(widget.dateFormat).format(widget.initialValue!);
    } else {
      controller.text = "";
      controller.clear();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: globalKey,
      padding: const EdgeInsets.symmetric(horizontal: 0),
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
          FormField<DateTime>(
            validator: widget.validator,
            initialValue: widget.initialValue,
            onSaved: widget.onSaved,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            builder: (FormFieldState state) {
              if (controller.text.isEmpty && widget.initialValue != null) {
                controller = TextEditingController()
                  ..text = DateFormat(widget.dateFormat)
                      .format(widget.initialValue!);

                // ignore: invalid_use_of_protected_member
                state.setValue(widget.initialValue);
              }

              return Focus(
                focusNode: focusNode,
                onFocusChange: (bool focused) {
                  if (focused == true) {
                    selectDate(context, state, ensureVisible: true);
                  }
                },
                child: GestureDetector(
                  onTap: () => selectDate(context, state),
                  child: TextFormField(
                    controller: controller,
                    maxLines: 1,
                    keyboardType: TextInputType.datetime,
                    style: kInnerInputDecoration.hintStyle!.copyWith(
                      color: IGrooveTheme.colors.black,
                    ),
                    decoration: kInnerInputDecoration.copyWith(
                      suffixIconConstraints: const BoxConstraints(maxWidth: 30),
                      suffixIcon: ImageIcon(
                        AssetImage(IGrooveAssets.iconChevronDown),
                        size: 14,
                        color: Colors.black,
                      ),
                      enabled: false,
                      hintText: widget.hintText,
                      errorText: state.errorText,
                      disabledBorder: kInnerInputDecoration.enabledBorder,
                      hintStyle: TextStyle(
                        height: 1,
                        color: widget.switchHintColor
                            ? IGrooveTheme.colors.black!.withOpacity(0.3)
                            : IGrooveTheme.colors.black,
                        letterSpacing: -0.19,
                      ),
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

  Future selectDate(BuildContext context, FormFieldState state,
      {bool ensureVisible = false}) async {
    {
      FocusScope.of(context).unfocus();

      if (ensureVisible) {
        await Scrollable.ensureVisible(globalKey!.currentContext!,
            alignment: 0.1, duration: const Duration(milliseconds: 500));
      }

      await Future.delayed(const Duration(milliseconds: 250));

      await showDatePicker(state);
    }
  }

  Future<void> showDatePicker(FormFieldState state) async {
    DateTime? initialDateTime = widget.initialValue;
    if (initialDateTime == null) {
      if (widget.futureDate) {
        int dayOfWeek = 5;
        DateTime date = DateTime.now().add(const Duration(days: 14));
        print(date.weekday - dayOfWeek);
        initialDateTime =
            date.subtract(Duration(days: date.weekday - dayOfWeek));
      } else {
        initialDateTime = DateTime.now();
      }
    }
  }
}
