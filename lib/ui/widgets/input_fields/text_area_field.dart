import 'package:flutter/material.dart';
import 'package:igroove_fan_box_one/ui/shared/themes.dart';

import 'base.dart';

class IGrooveTextAreaField extends StatefulWidget {
  final String? initialValue;
  final String? label;
  final String? hintText;
  final String? descriptionText;
  final int amountRows;
  final Widget? suffixIcon;
  final FormFieldSetter<String>? onSaved;
  final FormFieldSetter<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final bool enabled;
  final bool underlined;

  final FocusNode? focusNode;

  IGrooveTextAreaField({
    this.initialValue,
    this.label,
    this.hintText,
    this.descriptionText,
    this.suffixIcon,
    this.onSaved,
    this.onChanged,
    this.validator,
    this.amountRows = 8,
    this.focusNode,
    this.enabled = true,
    this.underlined = true,
  });

  @override
  _IGrooveTextAreaFieldState createState() => _IGrooveTextAreaFieldState();
}

class _IGrooveTextAreaFieldState extends State<IGrooveTextAreaField> {
  TextEditingController controller = TextEditingController();
  FocusNode? focusNode;

  @override
  void initState() {
    controller.text = widget.initialValue!;
    focusNode = widget.focusNode ?? FocusNode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: FormField<String>(
        validator: widget.validator,
        initialValue: widget.initialValue,
        onSaved: widget.onSaved,
        builder: (FormFieldState state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: [
                  Flexible(
                    child: Text(
                      widget.label!,
                      maxLines: 3,
                      style: kInnerInputDecoration.labelStyle!
                          .copyWith(height: 18 / 14),
                    ),
                  ),
                  const SizedBox(width: 5),
                  if (widget.descriptionText != null)
                    FieldHelper(
                      title: widget.label,
                      description: widget.descriptionText,
                    ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 300),
                  child: TextField(
                    textInputAction: TextInputAction.done,
                    maxLines: null,
                    enabled: widget.enabled,
                    controller: controller,
                    onChanged: (value) {
                      state.didChange(value);

                      if (widget.onChanged != null) widget.onChanged!(value);
                    },
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      fontSize: 16,
                      color: IGrooveTheme.colors.black,
                      letterSpacing: -0.19,
                      height: 28 / 16,
                    ),
                    obscureText: false,
                    decoration: kInnerInputDecoration.copyWith(
                      errorText: state.errorText,
                      suffixIcon: widget.suffixIcon,
                      hintText: widget.hintText,
                    ),
                    cursorColor: IGrooveTheme.colors.primary,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
