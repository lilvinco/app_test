import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:igroove_fan_box_one/ui/shared/themes.dart';

import 'base.dart';

class IGrooveTextToDoDescriptionField extends StatefulWidget {
  IGrooveTextToDoDescriptionField({
    Key? key,
    this.onSaved,
    this.focusNode,
    this.validator,
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
    this.obscureText = false,
    this.autofocus = false,
    this.disableScroll = false,
    this.readOnly = false,
    this.padding,
    this.errorText,
    this.trailing,
  }) : super(key: key);

  final String? initialValue;
  final bool enabled;
  final bool showSpaceBetweenPrefix;
  final String? hintText;
  final String? errorText;
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
  final EdgeInsets? padding;
  final bool disableScroll;

  @override
  _IGrooveTextToDoDescriptionFielddState createState() =>
      _IGrooveTextToDoDescriptionFielddState();
}

class _IGrooveTextToDoDescriptionFielddState
    extends State<IGrooveTextToDoDescriptionField> {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Focus(
            focusNode: focusNode,
            onFocusChange: _onFocusChange,
            child: TextFormField(
              onTap: () {
                _textFocusNode.requestFocus();
              },
              initialValue: widget.initialValue,
              readOnly: widget.readOnly,
              enabled: widget.enabled,
              focusNode: _textFocusNode,
              keyboardType: widget.keyboardType,
              obscureText: widget.obscureText,
              autocorrect: false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: kInnerInputDecoration.copyWith(
                contentPadding: const EdgeInsets.only(top: 0, bottom: 0),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: widget.hintText,
                hintStyle: TextStyle(
                    fontSize: 15,
                    height: 22 / 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.1,
                    color: IGrooveTheme.colors.black!.withOpacity(0.5)),
                errorText: widget.errorText,
              ),
              maxLines: 8,
              minLines: 1,
              cursorColor: IGrooveTheme.colors.primary,
              style: kInnerInputDecoration.hintStyle!.copyWith(
                fontSize: 15,
                height: 22 / 15,
                fontWeight: FontWeight.w400,
                letterSpacing: -0.1,
                color: IGrooveTheme.colors.black,
              ),
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
