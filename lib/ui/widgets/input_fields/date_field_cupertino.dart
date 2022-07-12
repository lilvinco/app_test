// import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:igroove_fan_box_one/base/base.dart';
import 'package:igroove_fan_box_one/constants/assets.dart';
import 'package:intl/intl.dart';

import 'base.dart';

class IGrooveDateFieldCupertino extends StatefulWidget {
  IGrooveDateFieldCupertino({
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
    this.dateFormat = 'dd.MM.yyyy',
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
  _IGrooveDateFieldCupertinoState createState() =>
      _IGrooveDateFieldCupertinoState();
}

class _IGrooveDateFieldCupertinoState extends State<IGrooveDateFieldCupertino> {
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

  FormFieldState? state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: globalKey,
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: GestureDetector(
        onTap: () {
          print("Clicked  inside");
          //selectDate(context, state!);
        },
        behavior: HitTestBehavior.translucent,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: IGrooveTheme.colors.white!.withOpacity(0.25), width: 1),
            borderRadius: const BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 9, 15, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row(
                //   children: [
                //     Text(
                //       widget.label,
                //       style: kInnerInputDecoration.labelStyle,
                //     ),
                //     const SizedBox(width: 5),
                //     if (widget.descriptionText != null)
                //       FieldHelper(
                //         title: widget.label,
                //         description: widget.descriptionText,
                //       ),
                //   ],
                // ),
                FormField<DateTime>(
                  validator: widget.validator,
                  initialValue: widget.initialValue,
                  onSaved: widget.onSaved,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  builder: (FormFieldState state) {
                    if (controller.text.isEmpty &&
                        widget.initialValue != null) {
                      controller = TextEditingController()
                        ..text = DateFormat(widget.dateFormat)
                            .format(widget.initialValue!);

                      // ignore: invalid_use_of_protected_member
                      state.setValue(widget.initialValue);
                    }
                    //selectDate(context, state);

                    return GestureDetector(
                      onTap: () {
                        selectDate(context, state);
                      },
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: controller,
                          maxLines: 1,
                          keyboardType: TextInputType.datetime,
                          style: TextStyle(color: IGrooveTheme.colors.white!),
                          cursorColor: IGrooveTheme.colors.white,
                          decoration: fanBoxInputDecoration.copyWith(
                            labelText: widget.label,
                            labelStyle: TextStyle(
                                fontSize: 16,
                                height: 16 / 16,
                                fontWeight: FontWeight.w400,
                                color: IGrooveTheme.colors.white!
                                    .withOpacity(0.75)),
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                            prefixIconConstraints:
                                const BoxConstraints(maxWidth: 190),
                            suffixIconConstraints:
                                const BoxConstraints(maxWidth: 30),
                            suffixIcon: ImageIcon(
                              AssetImage(IGrooveAssets.iconChevronDown),
                              size: 14,
                              color: Colors.white,
                            ),
                            // hintText: widget.hintText,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future selectDate(BuildContext context, FormFieldState state,
      {bool ensureVisible = false}) async {
    {
      // FocusScope.of(context).unfocus();

      // if (ensureVisible) {
      //   await Scrollable.ensureVisible(globalKey!.currentContext!,
      //       alignment: 0.1, duration: const Duration(milliseconds: 500));
      // }

      // await Future.delayed(const Duration(milliseconds: 250));

      await showDatePicker(state);
    }
  }

  Future<void> showDatePicker(FormFieldState state) async {
    DateTime? initialDateTime = widget.initialValue ?? DateTime.now();

    await showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height * 0.25,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (date) {
                controller.text = DateFormat(widget.dateFormat).format(date);
                state.didChange(date);

                if (widget.validator != null) widget.validator!(date);
                if (widget.onChanged != null) widget.onChanged!(date);
                if (widget.onEditingComplete != null) {
                  widget.onEditingComplete!(date);
                }
                // if (value != null && value != selectedDate)
                //   setState(() {
                //     selectedDate = value;
                //   });
              },
              initialDateTime: initialDateTime,
              minimumYear: 1930,
              maximumYear: 2022,
            ),
          );
        });

    // await Navigator.of(context)
    //     .pushNamed(AppRoutes.selectPeriod,
    //         arguments: SelectPeriodParameters(
    //             rangeActivated: false, selectedDatetime: initialDateTime))
    //     .then((Object? value) {
    //   DateTime date = value as DateTime;

    //   controller.text = DateFormat(widget.dateFormat).format(date);

    //   state.didChange(date);

    //   if (widget.onChanged != null) widget.onChanged!(date);
    //   if (widget.onEditingComplete != null) {
    //     widget.onEditingComplete!(date);
    //   }
    // });
  }
}
