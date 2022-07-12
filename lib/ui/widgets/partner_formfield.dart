import 'package:flutter/material.dart';
import 'package:igroove_fan_box_one/ui/shared/themes.dart';

class PartnerFormField extends StatefulWidget {
  /// Function called when the TextEditingController is changed.
  final Function(String)? onChange;
  final Function? onEdit;
  final Widget? title;
  final double textFieldMargin;
  final String? text;
  final String? errorText;
  final double height;
  final bool bottomLine;
  final bool obscureText;
  final bool isInBox;

  final Function(String)? validator;

  final bool enabled;
  final String hintText;

  PartnerFormField({
    this.onChange,
    this.title,
    this.text,
    Key? key,
    this.enabled = true,
    this.onEdit,
    this.textFieldMargin = 10,
    this.validator,
    this.height = 84,
    this.errorText,
    this.hintText = '',
    this.bottomLine = true,
    this.obscureText = false,
    this.isInBox = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PartnerFormFieldState();
  }
}

class _PartnerFormFieldState extends State<PartnerFormField> {
  TextEditingController? _fieldController;

  ThemeData? theme;
  bool isEditing = false;
  final FocusNode _fieldNode = FocusNode();

  @override
  void didUpdateWidget(PartnerFormField oldWidget) {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (widget.text != "") {
        _fieldController!.text = widget.text!;
      }
    });

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
          // _fieldController.selection =
          //     TextSelection.collapsed(offset: _fieldController.text.length);
          //setState(() {});
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
              if (widget.onEdit != null) widget.onEdit!();
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
                //SizedBox(height: 20),
                widget.validator == null ? widget.title! : const SizedBox(),
                widget.isInBox
                    ? const SizedBox(height: 17)
                    : const SizedBox(height: 8),
                TextFormField(
                  validator: widget.validator as String? Function(String?)?,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  focusNode: _fieldNode,
                  style: TextStyle(
                      color: IGrooveTheme.colors.black,
                      fontSize: 16,
                      height: widget.isInBox ? 16 / 16 : 21 / 16,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w400),
                  controller: _fieldController,
                  enabled: widget.enabled,
                  obscureText: widget.obscureText,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 17),

                    //alignLabelWithHint: true,
                    //labelText: widget.validator == null ? null : widget.title,
                    errorText: widget.errorText,
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
                        color: IGrooveTheme.colors.black!.withOpacity(0.3),
                        fontSize: 16,
                        height: widget.isInBox ? 16 / 16 : 21 / 16,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w400),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                ),
                if (widget.bottomLine)
                  Container(
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
            ),
            widget.enabled
                ? (_fieldController!.text.isNotEmpty && _fieldNode.hasFocus)
                    ? Align(
                        alignment: const Alignment(0.95, -0.4),
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            setState(() {
                              _fieldController!.text = "";
                            });
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
                    child: Container(
                      padding: const EdgeInsets.only(right: 2.5),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: IGrooveTheme.colors.grey,
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
}
