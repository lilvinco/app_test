import 'package:flutter/material.dart';
import 'package:igroove_fan_box_one/constants/assets.dart';
import 'package:igroove_fan_box_one/localization/localization.dart';
import 'package:simple_autocomplete_formfield/simple_autocomplete_formfield.dart';

import '../../shared/themes.dart';
import 'base.dart';

class IGrooveInlineTagsField<T> extends StatefulWidget {
  const IGrooveInlineTagsField({
    Key? key,
    this.validator,
    this.errorMessage,
    this.label,
    this.descriptionText,
    this.hintText = "",
    this.value,
    this.showAddButton = true,
    this.onRemove,
    this.disableTag = false,
    this.onSubmitted,
    this.suggestionEmptyText,
    this.displayWidget,
    this.disableScroll = false,
    this.showArrowWhenEmpty = false,
    this.enabled = true,
    this.disableMoreSelections = false,
    this.focusNode,
    this.validateInput,
    required this.onSuggestionSelected,
    required this.display,
    required this.suggestions,
    required this.comparator,
    this.margin = const EdgeInsets.only(bottom: 0),
  }) : super(key: key);

  final String? label;
  final String? suggestionEmptyText;
  final String? descriptionText;
  final bool showAddButton;
  final bool disableTag;
  final String? errorMessage;
  final bool enabled;
  final bool disableScroll;
  final bool showArrowWhenEmpty;
  final bool disableMoreSelections;

  final void Function(String)? onSubmitted;
  final Function(T)? onRemove;
  final FormFieldValidator<List<T>>? validator;
  final List<T>? value;
  final String? hintText;

  final Function(String)? validateInput;
  final String? Function(T) display;
  final Widget Function(T)? displayWidget;
  final List<T>? suggestions;
  final Function(T) onSuggestionSelected;
  final bool Function(String, T) comparator;

  final EdgeInsets margin;
  final FocusNode? focusNode;

  @override
  _IGrooveInlineTagsFieldState<T> createState() =>
      _IGrooveInlineTagsFieldState<T>();
}

class _IGrooveInlineTagsFieldState<T>
    extends State<IGrooveInlineTagsField<T?>> {
  TextEditingController? _controller;
  GlobalKey? globalKey;

  FocusNode? focusNode;
  final FocusNode _textFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  String? errorText;
  bool shouldValidate = true;
  @override
  initState() {
    globalKey = GlobalKey();
    focusNode = widget.focusNode ?? FocusNode();
    _controller = TextEditingController();
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
          FormField<List<T?>>(
            validator: (val) {
              if (_controller!.text.isEmpty) {
                setState(() => errorText = null);
              } else {
                return widget.validateInput!(_controller!.text);
              }
              if (shouldValidate) {
                try {
                  return widget.validator!(val);
                } catch (e, stacktrace) {
                  print(e.toString());
                  print(stacktrace.toString());
                  return null;
                }
              }
              return null;
            },
            initialValue: widget.value,
            builder: (FormFieldState<List<T?>> state) {
              String query = _controller!.text;
              List<T?> suggestions = (widget.suggestions ?? []).where((e) {
                String suggestion = widget.display(e)!;
                return suggestion.toLowerCase().contains(query.toLowerCase());
              }).toList();

              bool _noSuggestions = suggestions.isEmpty;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.value != null && widget.value!.isNotEmpty)
                    const SizedBox(height: 10),
                  if (widget.value != null && widget.value!.isNotEmpty)
                    widget.disableTag
                        ? widget.value!.isNotEmpty
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                    widget.displayWidget!(widget.value!.first),
                                    GestureDetector(
                                        onTap: () {
                                          widget.onRemove!(widget.value!.first);
                                        },
                                        child: Container(
                                          height: 14,
                                          width: 14,
                                          child: ImageIcon(
                                            AssetImage(IGrooveAssets.iconClose),
                                            color: Colors.black,
                                            size: 14,
                                          ),
                                        ))
                                  ])
                            : "" as Widget
                        : Wrap(
                            spacing: 5,
                            runSpacing: 5,
                            children: widget.value!
                                .map(
                                  (e) => TagInput(
                                    text: widget.display(e) ?? "",
                                    enabled: widget.enabled,
                                    onRemove: () {
                                      widget.onRemove!(e);
                                    },
                                  ),
                                )
                                .toList(),
                          ),
                  if (!widget.enabled)
                    Container(
                      height: 15,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: IGrooveTheme.colors.white3!,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  if (widget.value != null && widget.value!.isNotEmpty)
                    const SizedBox(height: 5),
                  if (widget.enabled && !widget.disableMoreSelections)
                    Focus(
                      focusNode: focusNode,
                      onFocusChange: _onFocusChange,
                      child: SimpleAutocompleteFormField<T>(
                        maxSuggestions: 500,
                        focusNode: _textFocusNode,
                        controller: _controller,
                        onSearch: (val) {
                          return Future.value(suggestions);
                        },
                        resetIcon: null,
                        itemBuilder: (context, val) {
                          return Row(
                            //mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15.0,
                                  horizontal: 20,
                                ),
                                child: widget.displayWidget != null
                                    ? widget.displayWidget!(val)
                                    : Text(
                                        widget.display(val)!,
                                        style: const TextStyle(
                                          fontSize: 17,
                                          height: 1,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                              ),
                            ],
                          );
                        },
                        suggestionsBuilder: (context, list) {
                          if (list.isEmpty) {
                            if (widget.suggestionEmptyText != null &&
                                widget.suggestionEmptyText != "") {
                              return Padding(
                                padding: const EdgeInsets.only(top: 9.0),
                                child: Container(
                                  //height: 130,
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
                                  child: SingleChildScrollView(
                                    controller: _scrollController,
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Text(
                                              widget.suggestionEmptyText!,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  letterSpacing: 0,
                                                  height: 18 / 14,
                                                  color:
                                                      IGrooveTheme.colors.black,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ]),
                                  ),
                                ),
                              );
                            }

                            return const SizedBox();
                          }

                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              print("Clicked Item");
                              var position = _scrollController.position;

                              _scrollController.animateTo(position.pixels,
                                  duration: const Duration(seconds: 0),
                                  curve: Curves.easeInCirc);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 9.0),
                              child: Container(
                                height: 200,
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
                                child: SingleChildScrollView(
                                  controller: _scrollController,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: list,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        decoration: kInnerInputDecoration.copyWith(
                          suffixIconConstraints:
                              const BoxConstraints(maxWidth: 80),
                          suffixIcon: _noSuggestions &&
                                  _controller!.text.isNotEmpty &&
                                  widget.showAddButton
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
                                    shouldValidate = false;

                                    state.validate();
                                    shouldValidate = true;

                                    focusNode!.unfocus();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        top: 15, bottom: 15),
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      AppLocalizations.of(context)!.generalAdd!,
                                      style: TextStyle(
                                        color: IGrooveTheme.colors.primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        height: 1,
                                      ),
                                    ),
                                  ),
                                )
                              : widget.showArrowWhenEmpty
                                  ? ImageIcon(
                                      AssetImage(IGrooveAssets.iconChevronDown),
                                      size: 14,
                                      color: Colors.black,
                                    )
                                  : null,
                          errorText: (widget.errorMessage != null &&
                                  widget.errorMessage!.isNotEmpty)
                              ? widget.errorMessage
                              : (errorText != null && errorText!.isNotEmpty)
                                  ? errorText
                                  : (state.errorText != null &&
                                          state.errorText!.isNotEmpty)
                                      ? state.errorText
                                      : null,
                          hintText: widget.hintText,
                        ),
                        onChanged: (val) {
                          if (val == null) return;

                          widget.onSuggestionSelected(val);

                          _controller!.text = '';

                          setState(() => errorText = null);
                          state.validate();

                          focusNode!.unfocus();
                        },
                      ),
                    ),
                  if (widget.enabled && widget.disableMoreSelections)
                    Container(
                      height: 15,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: IGrooveTheme.colors.white3!,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          )
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
