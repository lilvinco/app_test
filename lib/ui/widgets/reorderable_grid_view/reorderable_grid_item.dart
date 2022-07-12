import 'package:flutter/material.dart';
import 'package:igroove_fan_box_one/ui/shared/themes.dart';

// ignore: must_be_immutable
class ReorderableGridItem extends StatefulWidget {
  final Widget? child;

  /// Describes what part of device width will take.
  final double widthFlex;

  final bool allowDrag;

  int? orderNumber;
  setOrderNumber(int newOrderNumber) {
    orderNumber ??= newOrderNumber;
  }

  final Map<String, dynamic>? customData;

  ReorderableGridItem({
    this.child,
    this.widthFlex = 0.5,
    Key? key,
    this.orderNumber,
    this.allowDrag = true,
    this.customData,
  }) : super(key: key);

  ReorderableGridItem copyWith({
    Widget? child,
    GlobalKey? key,
    double? widthFlex,
    bool? allowDrag,
    int? orderNumber,
    dynamic customData,
  }) {
    return ReorderableGridItem(
      child: child ?? this.child,
      // key: key ?? this.key,
      orderNumber: orderNumber ?? this.orderNumber,
      widthFlex: widthFlex ?? this.widthFlex,
      allowDrag: allowDrag ?? this.allowDrag,
      customData: customData ?? this.customData,
    );
  }

  @override
  _ReorderableGridItemState createState() => _ReorderableGridItemState();
}

class _ReorderableGridItemState extends State<ReorderableGridItem> {
  late double _screenWidth;
  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    return Container(
      key: GlobalKey(),
      width: _screenWidth * widget.widthFlex,
      // height: (_screenWidth * widget.widthFlex) * widget.aspectRatio,
      child: Material(
        color: IGrooveTheme.colors.transparent,
        child: widget.child,
      ),
    );
  }
}
