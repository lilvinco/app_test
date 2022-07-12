import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:igroove_fan_box_one/localization/localization.dart';

import '../../shared/themes.dart';
import 'base.dart';

class IGrooveTagsField<T> extends StatefulWidget {
  const IGrooveTagsField({
    Key? key,
    this.leading,
    this.validator,
    this.label,
    this.descriptionText,
    this.hintText = "",
    this.value,
    this.onRemove,
    this.showEmptyTag = false,
    this.onSubmitted,
    this.enabled = true,
    this.focusNode,
    this.validateInput,
    required this.search,
    required this.onSuggestionSelected,
    required this.display,
    this.margin = const EdgeInsets.only(bottom: 0),
    this.underlined = false,
  }) : super(key: key);

  final String? label;
  final String? descriptionText;
  final bool showEmptyTag;
  final bool enabled;
  final Widget? leading;
  final Future<List<T>> Function(String) search;
  final Function(T) onSuggestionSelected;
  final void Function(String)? onSubmitted;
  final Function(T)? onRemove;
  final String Function(T) display;
  final FormFieldValidator<List<T>>? validator;
  final List<T>? value;
  final String hintText;

  final Function(String)? validateInput;

  final EdgeInsets margin;
  final FocusNode? focusNode;
  final bool underlined;

  @override
  _IGrooveTagsFieldState<T> createState() => _IGrooveTagsFieldState<T>();
}

class _IGrooveTagsFieldState<T> extends State<IGrooveTagsField<T>> {
  TextEditingController? _controller;
  SuggestionsBoxController? _suggestionsBoxController;
  GlobalKey? globalKey;

  FocusNode? focusNode;
  final FocusNode _textFocusNode = FocusNode();

  String? errorText = '';

  bool _isEmpty = false;

  @override
  initState() {
    globalKey = GlobalKey();
    focusNode = widget.focusNode ?? FocusNode();

    _controller = TextEditingController();
    _suggestionsBoxController = SuggestionsBoxController();

    //_suggestionsBoxController.toggle();

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
          Focus(
            focusNode: focusNode,
            onFocusChange: (bool focused) async {
              if (focused == true) {
                await Scrollable.ensureVisible(globalKey!.currentContext!,
                    alignment: 0.1,
                    duration: const Duration(milliseconds: 500));

                await Future.delayed(const Duration(milliseconds: 250));

                _textFocusNode.requestFocus();
              }
            },
            child: FormField<List<T>>(
              validator: widget.validator,
              initialValue: widget.value,
              builder: (FormFieldState<List<T>> state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if ((widget.value != null && widget.value!.isNotEmpty) ||
                        (widget.showEmptyTag &&
                            (widget.value == null || widget.value!.isEmpty)))
                      const SizedBox(height: 10),
                    if (widget.value != null && widget.value!.isNotEmpty)
                      Wrap(
                        spacing: 5,
                        runSpacing: 5,
                        children: widget.value!
                            .map(
                              (e) => TagInput(
                                text: widget.display(e),
                                enabled: widget.enabled,
                                onRemove: () {
                                  widget.onRemove!(e);
                                },
                              ),
                            )
                            .toList(),
                      ),
                    if (widget.showEmptyTag &&
                        (widget.value == null || widget.value!.isEmpty))
                      Wrap(
                        spacing: 5,
                        runSpacing: 5,
                        children: [
                          TagInput(
                            text: 'Not Selected',
                            enabled: widget.enabled,
                          )
                        ],
                      ),
                    if (!widget.enabled)
                      Container(
                        height: 15,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: IGrooveTheme.colors.white3!,
                                    width: 1))),
                      ),
                    if (widget.value != null && widget.value!.isNotEmpty)
                      const SizedBox(height: 5),
                    if (widget.enabled)
                      TypeAheadField<T>(
                        suggestionsBoxVerticalOffset: 9,
                        autoFlipDirection: false,
                        hideOnEmpty: true,
                        hideOnError: true,
                        hideOnLoading: true,
                        hideSuggestionsOnKeyboardHide: true,
                        textFieldConfiguration: TextFieldConfiguration(
                          onTap: () => _textFocusNode.requestFocus(),
                          focusNode: _textFocusNode,
                          controller: _controller,
                          autofocus: false,
                          enabled: widget.enabled,
                          autocorrect: false,
                          style: kInnerInputDecoration.hintStyle!.copyWith(
                            color: IGrooveTheme.colors.black,
                          ),
                          decoration: kInnerInputDecoration.copyWith(
                            suffixIconConstraints:
                                const BoxConstraints(maxWidth: 80),
                            suffixIcon: _isEmpty && _controller!.text.isNotEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      String searchText = _controller!.text;

                                      if (widget.validateInput != null) {
                                        setState(() => errorText =
                                            widget.validateInput!(searchText));

                                        if (errorText != null) {
                                          return;
                                        }
                                      }

                                      if (widget.onSubmitted != null) {
                                        widget.onSubmitted!(searchText);
                                      }
                                      _controller!.text = '';
                                      _suggestionsBoxController!.close();
                                      state.validate();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          top: 15, bottom: 15),
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .generalAdd!,
                                        style: TextStyle(
                                          color: IGrooveTheme.colors.primary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          height: 1,
                                        ),
                                      ),
                                    ),
                                  )
                                : null,
                            errorText: (state.errorText != null &&
                                    state.errorText!.isNotEmpty)
                                ? (errorText != null && errorText!.isNotEmpty)
                                    ? errorText
                                    : state.errorText
                                : null,
                            hintText: widget.hintText,
                          ),
                        ),
                        suggestionsBoxDecoration: SuggestionsBoxDecoration(
                          hasScrollbar: true,
                          elevation: 3,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side:
                                BorderSide(color: IGrooveTheme.colors.white3!),
                          ),
                          constraints: BoxConstraints(
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.225,
                          ),
                        ),
                        suggestionsCallback: (String pattern) async {
                          List<T> predictions = await widget.search(pattern);

                          List<T> result = predictions;

                          setState(() => _isEmpty = result.isEmpty);

                          return result;
                        },
                        onSuggestionSelected: (T suggestion) {
                          _controller!.text = '';

                          setState(() => errorText = null);

                          widget.onSuggestionSelected(suggestion);
                        },
                        getImmediateSuggestions: false,
                        suggestionsBoxController: _suggestionsBoxController,
                        itemBuilder: (BuildContext context, T suggestion) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 20),
                            child: Text(
                              widget.display(suggestion),
                              style: const TextStyle(
                                fontSize: 17,
                                height: 1,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class TagInput extends StatelessWidget {
  const TagInput({this.text, this.enabled = true, this.onRemove});

  final String? text;
  final bool enabled;
  final Function? onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: IGrooveTheme.colors.whiteColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 8,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              text!,
              style: const TextStyle(
                fontSize: 14,
                letterSpacing: -0.16,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (enabled) const SizedBox(width: 2),
          if (enabled && onRemove != null)
            InkWell(
              onTap: onRemove as void Function()?,
              child: Icon(
                Icons.close,
                color: IGrooveTheme.colors.black,
                size: 16,
              ),
            ),
        ],
      ),
    );
  }
}
