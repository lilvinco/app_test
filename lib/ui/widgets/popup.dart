import 'package:flutter/material.dart';
import 'package:igroove_fan_box_one/ui/shared/themes.dart';

class ShapedWidget extends StatefulWidget {
  final double leftSpacing;
  final double topSpacing;
  final bool onlyTop;
  final String shapedLoc;
  final List<String> listItems;
  final int? defaultIndex;
  ShapedWidget(
      {this.onlyTop = false,
      required this.leftSpacing,
      required this.topSpacing,
      required this.shapedLoc,
      required this.listItems,
      this.defaultIndex});

  @override
  _ShapedWidgetState createState() => _ShapedWidgetState();
}

class _ShapedWidgetState extends State<ShapedWidget> {
  final double padding = 4.0;
  int? checkedIndex;
  // list for widgets
  List<Widget> itemsList = [];

  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    checkedIndex = widget.defaultIndex;
    // generating list of widgets
    // itemsList = List.generate(widget.listItems.length, (index) {
    //   return checkBoxListItem(widget.listItems[index], itemIndex: index);
    // });
  }

  @override
  Widget build(BuildContext context) {
    // get screen height
    double screenHeight = MediaQuery.of(context).size.height;
    // get popup height
    int popupHeight = 57 * widget.listItems.length;
    // get remaining height
    double remainingSpace = screenHeight - widget.topSpacing;
    theme = Theme.of(context);
    // check if popup height is more than remaining
    // Space then, changing popup height
    if (popupHeight > remainingSpace) {
      popupHeight = remainingSpace.toInt() - 10;
    }
    // creating popup
    return Stack(children: <Widget>[
      Positioned(
        left: MediaQuery.of(context).size.width * 0.05,
        right: MediaQuery.of(context).size.width * 0.05,
        top: widget.topSpacing,
        child: Material(
          clipBehavior: Clip.antiAlias,
          elevation: 0,
          shape: _ShapedWidgetBorder(
              location: widget.shapedLoc,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              padding: padding),
          child: Container(
            height: double.parse(popupHeight.toString()),
            padding:
                EdgeInsets.all(padding).copyWith(bottom: padding * 2, right: 0),
            child: Container(
              constraints: const BoxConstraints(minHeight: 0.0),
              child: ListView(
                padding: const EdgeInsets.all(0),
                children: List.generate(widget.listItems.length, (int index) {
                  return checkBoxListItem(widget.listItems[index],
                      itemIndex: index);
                }),
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  returnDataBack() {
    Navigator.of(context).pop(checkedIndex);
  }

  Widget checkBoxListItem(String title, {int? itemIndex}) {
    return Theme(
      data: theme.copyWith(
          highlightColor: IGrooveTheme.colors.transparent,
          splashColor: IGrooveTheme.colors.transparent,
          hoverColor: IGrooveTheme.colors.transparent,
          focusColor: IGrooveTheme.colors.transparent),
      child: Container(
          height: 56,
          child: RawMaterialButton(
            onPressed: () {
              setState(() {
                checkedIndex = itemIndex;
              });
              Future.delayed(const Duration(milliseconds: 300), () {
                returnDataBack();
              });
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 11),
                  child: itemIndex == checkedIndex
                      ? Icon(
                          Icons.check,
                          color: IGrooveTheme.colors.primary,
                          size: 24,
                        )
                      : const SizedBox(
                          width: 24,
                          height: 24,
                        ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: BorderDirectional(
                        bottom: BorderSide(
                          color: IGrooveTheme.colors.whiteColor!,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(top: 17),
                          child: Text(
                            title,
                            style: theme.primaryTextTheme.headline2!.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: itemIndex == checkedIndex
                                  ? IGrooveTheme.colors.primary
                                  : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}

class _ShapedWidgetBorder extends RoundedRectangleBorder {
  final String? location;
  _ShapedWidgetBorder({
    required this.padding,
    this.location,
    side = BorderSide.none,
    borderRadius = BorderRadius.zero,
  }) : super(
          side: side,
          borderRadius: borderRadius,
        );
  final double padding;

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    switch (location) {
      case "center":
        return Path()
          ..moveTo(rect.width - rect.width / 2 + rect.width * 0.05, rect.top)
          ..lineTo(rect.width - rect.width / 2 + rect.width * 0.05 - 12.0,
              rect.top - 14.0)
          ..lineTo(
              rect.width - rect.width / 2 + rect.width * 0.05 - 24.0, rect.top)
          ..addRRect(borderRadius.resolve(textDirection).toRRect(Rect.fromLTWH(
              rect.left, rect.top, rect.width, rect.height - padding)));

      case "right":
        return Path()
          ..moveTo(rect.width - rect.width / 2 + rect.width * 0.25, rect.top)
          ..lineTo(rect.width - rect.width / 2 + rect.width * 0.25 - 12.0,
              rect.top - 14.0)
          ..lineTo(
              rect.width - rect.width / 2 + rect.width * 0.25 - 24.0, rect.top)
          ..addRRect(borderRadius.resolve(textDirection).toRRect(Rect.fromLTWH(
              rect.left, rect.top, rect.width, rect.height - padding)));
      case "none":
        return Path()
          ..moveTo(rect.width - rect.width / 2 + rect.width * 0.25, rect.top)
          ..addRRect(borderRadius.resolve(textDirection).toRRect(Rect.fromLTWH(
              rect.left, rect.top, rect.width, rect.height - padding)));
      default:
        return Path()
          ..moveTo(rect.width - rect.width / 2 + rect.width * 0.05, rect.top)
          ..lineTo(rect.width - rect.width / 2 + rect.width * 0.05 - 12.0,
              rect.top - 14.0)
          ..lineTo(
              rect.width - rect.width / 2 + rect.width * 0.05 - 24.0, rect.top)
          ..addRRect(borderRadius.resolve(textDirection).toRRect(Rect.fromLTWH(
              rect.left, rect.top, rect.width, rect.height - padding)));
    }
  }
}
