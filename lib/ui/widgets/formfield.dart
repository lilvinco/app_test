import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:igroove_fan_box_one/core/services/user_service.dart';
import 'package:igroove_fan_box_one/ui/shared/themes.dart';

import 'input_fields/base.dart';

class CustomFormField extends StatefulWidget {
  /// Function called when the TextEditingController is changed.
  final Function(String)? onChange;
  final Function? onEdit;
  final Function? onTap;
  final String? title;
  final double textFieldMargin;
  final String? text;
  final String? errorText;
  final double height;
  final double? suffixSize;
  final String? prefixText;
  final Function(String?)? validator;
  final bool obscureText;
  final bool isHavePreffixText;
  final bool isNumberType;
  final bool enabled;
  final bool readOnly;
  final String hintText;

  CustomFormField({
    this.onChange,
    this.title,
    this.text,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.onEdit,
    this.textFieldMargin = 10,
    this.isHavePreffixText = false,
    this.prefixText = '',
    this.validator,
    this.height = 71,
    this.suffixSize,
    this.isNumberType = false,
    this.errorText,
    this.hintText = '',
    this.onTap,
  });

  @override
  State<StatefulWidget> createState() {
    return _CustomFormFieldState();
  }
}

class _CustomFormFieldState extends State<CustomFormField> {
  TextEditingController? _fieldController;

  ThemeData? theme;
  bool isEditing = false;
  final FocusNode _fieldNode = FocusNode();

  @override
  void didUpdateWidget(CustomFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();

    _fieldController = TextEditingController(text: widget.text);
    _fieldController!.addListener(() {
      // This callback will be fired when user types in search input.
      if (mounted) {
        // If onChange callback is specified, then send the updated controller
        if (widget.onChange != null) {
          widget.onChange!(_fieldController!.text);
        }
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: widget.enabled
          ? null
          : () {
              if (!UserService.userDataModel!.isDemoUser) {
                if (widget.onEdit != null) widget.onEdit!();
              }
            },
      child: Container(
        alignment: Alignment.topCenter,
        height: widget.height,
        padding: EdgeInsets.only(
          left: 15,
          right: widget.textFieldMargin,
        ),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                widget.validator == null || !widget.obscureText
                    ? Flexible(
                        child: Text(
                          widget.title!,
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    : const SizedBox(),
                TextFormField(
                  onTap: widget.onTap as void Function()?,
                  validator: widget.validator as String? Function(String?)?,

                  inputFormatters: <TextInputFormatter>[
                    if (widget.isNumberType)
                      FilteringTextInputFormatter.allow(
                          RegExp('^\$|^(0|([1-9][0-9]{0,}))(\\.[0-9]{0,})?\$')),
                  ],
                  // Only numbers can be entered
                  readOnly: widget.readOnly,
                  keyboardType: widget.isHavePreffixText || widget.isNumberType
                      ? Platform.isIOS
                          ? const TextInputType.numberWithOptions(
                              signed: true, decimal: true)
                          : TextInputType.number
                      : TextInputType.text,
                  textInputAction:
                      widget.isHavePreffixText || widget.isNumberType
                          ? TextInputAction.done
                          : TextInputAction.done,
                  obscureText: widget.obscureText,
                  focusNode: _fieldNode,
                  style: TextStyle(
                      color: IGrooveTheme.colors.black,
                      fontSize: 16,
                      fontFamily: "Graphik",
                      fontWeight: FontWeight.w400),
                  controller: _fieldController,
                  enabled: widget.enabled,
                  decoration: kInnerInputDecoration.copyWith(
                    alignLabelWithHint: true,
                    // hintText: widget.obscureText ? title : "",
                    labelText: widget.validator == null || !widget.obscureText
                        ? null
                        : widget.title,
                    errorText: widget.errorText,
                    hintText: widget.hintText,
                    prefixText: widget.isHavePreffixText
                        ? widget.prefixText! + " "
                        : '',
                    errorMaxLines: 2,
                  ),
                ),
              ],
            ),
            widget.enabled
                ? (_fieldController!.text.isNotEmpty && _fieldNode.hasFocus)
                    ? Align(
                        alignment: const Alignment(0.95, -0.4),
                        child: GestureDetector(
                          onTap: () {
                            if (!widget.readOnly) {
                              setState(() {
                                _fieldController!.text = "";
                              });
                            }
                          },
                          child: const Icon(
                            Icons.cancel,
                            color: Color(0xffB4B6C0),
                            size: 20,
                          ),
                        ),
                      )
                    : const SizedBox()
                : Align(
                    alignment: const Alignment(1.0, 0),
                    // child: Positioned(
                    // right: 2.5,

                    child: Container(
                      padding: const EdgeInsets.only(right: 2.5),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: IGrooveTheme.colors.black!.withOpacity(0.8),
                        size: 18,
                      ),
                    ),
                  ),
            // ),
          ],
        ),
      ),
    );
  }

// final FocusNode _nodeText1 = FocusNode();
// final FocusNode _nodeText2 = FocusNode();
// final FocusNode _nodeText3 = FocusNode();
// final FocusNode _nodeText4 = FocusNode();
// final FocusNode _nodeText5 = FocusNode();
// final FocusNode _nodeText6 = FocusNode();
// final FocusNode _nodeText7 = FocusNode();

  /// Creates the [KeyboardActionsConfig] to hook up the fields
  /// and their focus nodes to our [FormKeyboardActions].
// KeyboardActionsConfig _buildConfig(BuildContext context) {
//   return KeyboardActionsConfig(
//     keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
//     keyboardBarColor:,
//     nextFocus: true,
//     actions: [
//       KeyboardAction(
//         focusNode: _nodeText1,
//       ),
//       KeyboardAction(
//         focusNode: _nodeText2,
//         closeWidget: Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Icon(Icons.close),
//         ),
//       ),
//       KeyboardAction(
//         focusNode: _nodeText3,
//         onTapAction: () {
//           showDialog(
//               context: context,
//               builder: (context) {
//                 return AlertDialog(
//                   content: Text("Custom Action"),
//                   actions: <Widget>[
//                     FlatButton(
//                       child: Text("OK"),
//                       onPressed: () => Navigator.of(context).pop(),
//                     )
//                   ],
//                 );
//               });
//         },
//       ),
//       KeyboardAction(
//         focusNode: _nodeText4,
//         displayCloseWidget: false,
//       ),
//       KeyboardAction(
//         focusNode: _nodeText5,
//         closeWidget: Padding(
//           padding: EdgeInsets.all(5.0),
//           child: Text("CLOSE"),
//         ),
//       ),
//       KeyboardAction(
//         focusNode: _nodeText6,
//         footerBuilder: (_) => PreferredSize(
//             child: SizedBox(
//                 height: 40,
//                 child: Center(
//                   child: Text('Custom Footer'),
//                 )),
//             preferredSize: Size.fromHeight(40)),
//       ),
//       KeyboardAction(
//         focusNode: _nodeText7,
//         // footerBuilder: (_) => ColorPickerKeyboard.instance,
//       ),
//     ],
//   );
// }
}
