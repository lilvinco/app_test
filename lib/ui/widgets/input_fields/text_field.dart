import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:igroove_fan_box_one/ui/shared/themes.dart';

import 'base.dart';

class IGrooveTextField extends StatefulWidget {
  IGrooveTextField({
    Key? key,
    required this.label,
    this.onSaved,
    this.focusNode,
    this.validator,
    this.descriptionText,
    this.hintText,
    this.suffixIcon,
    this.controller,
    this.inputFormatters,
    this.onEditingComplete,
    this.keyboardType,
    this.showSpaceBetweenPrefix = true,
    this.onFieldSubmitted,
    this.onFieldChanged,
    this.initialValue,
    this.enabled = true,
    this.prefixText,
    this.maxLines = 1,
    this.minLines = 1,
    this.obscureText = false,
    this.autofocus = false,
    this.underlined = false,
    this.disableScroll = false,
    this.readOnly = false,
    this.padding,
    this.errorText,
    this.trailing,
    this.thickBorder = false,
  }) : super(key: key);

  final String? initialValue;
  final bool enabled;
  final String? label;
  final bool showSpaceBetweenPrefix;
  final String? descriptionText;
  final String? hintText;
  final String? errorText;
  final int? maxLines;
  final int? minLines;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<String>? onFieldChanged;
  final FormFieldSetter<String>? onSaved;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool autofocus;
  final String? prefixText;
  final Widget? trailing;
  final bool readOnly;
  final bool underlined;
  final EdgeInsets? padding;
  final bool disableScroll;
  final bool thickBorder;

  @override
  _IGrooveTextFieldState createState() => _IGrooveTextFieldState();
}

class _IGrooveTextFieldState extends State<IGrooveTextField> {
  GlobalKey? globalKey;
  FocusNode? focusNode;
  final FocusNode _textFocusNode = FocusNode();

  @override
  void initState() {
    globalKey = GlobalKey();

    focusNode = widget.focusNode ?? FocusNode();

    super.initState();
    isEmpty = widget.controller?.text.isEmpty ?? true;
    if (widget.controller?.text != null) {
      widget.controller!.addListener(() {
        if (isEmpty != widget.controller!.text.isEmpty) {
          if (mounted) {
            setState(() => isEmpty = widget.controller!.text.isEmpty);
          }
        }
      });
    }

    focusNode!.addListener(() {
      if (mounted) {
        setState(() {
          hasFocus = focusNode!.hasFocus;
        });
      }
    });
  }

  bool? isEmpty;
  bool hasFocus = false;
  bool tapped = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: globalKey,
      padding: widget.padding ?? EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
            border: hasFocus || widget.thickBorder
                ? Border.all(
                    color: IGrooveTheme.colors.white!.withOpacity(0.75),
                    width: 2)
                : Border.all(
                    color: IGrooveTheme.colors.white!.withOpacity(0.25),
                    width: 1),
            borderRadius: const BorderRadius.all(
              Radius.circular(8.0),
            ),
            color: widget.thickBorder
                ? IGrooveTheme.colors.black2!.withOpacity(0.75)
                : IGrooveTheme.colors.transparent),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 9, 15, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   children: [
              //     Text(
              //       widget.label!,
              //       style: TextStyle(
              //           fontSize: 11,
              //           height: 13 / 11,
              //           fontWeight: FontWeight.w500,
              //           color: IGrooveTheme.colors.white!.withOpacity(0.75)),
              //     ),
              //     const SizedBox(width: 5),
              //     if (widget.descriptionText != null)
              //       FieldHelper(
              //         title: widget.label,
              //         description: widget.descriptionText,
              //       ),
              //   ],
              // ),
              // const SizedBox(height: 4),
              Focus(
                focusNode: focusNode,
                onFocusChange: _onFocusChange,
                child: TextFormField(
                  onTap: () {
                    _textFocusNode.requestFocus();
                  },
                  initialValue: widget.initialValue,
                  readOnly: widget.readOnly,
                  maxLines: widget.maxLines,
                  minLines: widget.minLines,
                  enabled: widget.enabled,
                  focusNode: _textFocusNode,
                  keyboardType: widget.keyboardType,
                  obscureText: widget.obscureText,
                  autocorrect: false,
                  autovalidateMode: AutovalidateMode.disabled,
                  decoration: fanBoxInputDecoration.copyWith(
                    labelText: widget.label,
                    labelStyle: TextStyle(
                        fontSize: 16,
                        height: 16 / 16,
                        fontWeight: FontWeight.w400,
                        color: IGrooveTheme.colors.white!.withOpacity(0.75)),
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    prefixIconConstraints: const BoxConstraints(maxWidth: 190),
                    suffixIcon: widget.trailing ?? widget.suffixIcon,
                    suffixIconConstraints: const BoxConstraints(maxWidth: 21),
                    // hintText: widget.hintText,
                    errorText: widget.errorText,
                  ),
                  style: TextStyle(color: IGrooveTheme.colors.white!),
                  cursorColor: IGrooveTheme.colors.white,
                  validator: widget.validator,
                  controller: widget.controller,
                  inputFormatters: widget.inputFormatters,
                  onFieldSubmitted: widget.onFieldSubmitted,
                  onChanged: widget.onFieldChanged,
                  onSaved: widget.onSaved,
                  autofocus: widget.autofocus,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onFocusChange(bool focused) async {
    if (focused != true) return;
    if (!widget.disableScroll) {
      if (focusNode!.hasFocus) {
        await Future.delayed(const Duration(milliseconds: 250));
      }

      if (focusNode!.hasFocus) {
        await Scrollable.ensureVisible(
          globalKey!.currentContext!,
          alignment: 0.1,
          duration: const Duration(milliseconds: 500),
          alignmentPolicy: ScrollPositionAlignmentPolicy.explicit,
        );
      }
    }

    if (focusNode!.hasFocus) {
      await Future.delayed(const Duration(milliseconds: 250));
    }

    if (focusNode!.hasFocus) _textFocusNode.requestFocus();
  }
}
