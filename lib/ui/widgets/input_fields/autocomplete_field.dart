import 'package:flutter/material.dart';
import 'package:simple_autocomplete_formfield/simple_autocomplete_formfield.dart';

import '../../shared/themes.dart';
import 'base.dart';

class IGrooveAutocompleteField<T> extends StatefulWidget {
  const IGrooveAutocompleteField({
    Key? key,
    this.controller,
    this.validator,
    this.label,
    this.descriptionText,
    this.hintText = "",
    this.value,
    this.enabled = true,
    this.focusNode,
    this.leading,
    this.errorText = "",
    required this.onSuggestionSelected,
    required this.display,
    required this.suggestions,
    required this.comparator,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? label;
  final String? descriptionText;
  final bool enabled;
  final FormFieldValidator<T>? validator;
  final T? value;
  final String? errorText;
  final String hintText;
  final Widget Function(T) display;
  final List<T> suggestions;
  final Function(T) onSuggestionSelected;
  final bool Function(String, T) comparator;
  final FocusNode? focusNode;
  final Widget? leading;

  @override
  _IGrooveAutocompleteFieldState<T> createState() =>
      _IGrooveAutocompleteFieldState<T>();
}

class _IGrooveAutocompleteFieldState<T>
    extends State<IGrooveAutocompleteField<T?>> {
  TextEditingController? _controller;

  GlobalKey? globalKey;
  FocusNode? focusNode;

  @override
  initState() {
    globalKey = GlobalKey();
    focusNode = widget.focusNode ?? FocusNode();

    _controller = widget.controller ?? TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: globalKey,
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                widget.label!,
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
          SimpleAutocompleteFormField<T>(
            enabled: widget.enabled,
            validator: widget.validator,
            initialValue: widget.value,
            controller: _controller,
            // focusNode: focusNode,
            decoration: kInnerInputDecoration.copyWith(
              suffixIconConstraints: const BoxConstraints(maxWidth: 80),
              hintText: widget.hintText,
              errorText: widget.errorText,
              prefixIconConstraints: const BoxConstraints(maxWidth: 28),
              prefixIcon: widget.leading,
            ),
            suggestionsBuilder: (BuildContext context, List<Widget> list) {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: IGrooveTheme.colors.white3!,
                    width: 1,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 10),
                      blurRadius: 30,
                      spreadRadius: 0,
                      color: Colors.black.withOpacity(0.15),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: list,
                ),
              );
            },
            onSearch: (String pattern) async {
              List<T?> result = widget.suggestions;
              return result;
            },
            onChanged: (T? val) {
              if (val == null) return;

              _controller!.text = '';

              widget.onSuggestionSelected(val);
            },
            itemBuilder: (BuildContext context, T? suggestion) {
              return Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: widget.display(suggestion),
              );
            },
          ),
        ],
      ),
    );
  }
}
