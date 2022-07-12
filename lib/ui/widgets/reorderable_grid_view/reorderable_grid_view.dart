import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:igroove_fan_box_one/management/app_model.dart';
import 'package:igroove_fan_box_one/ui/widgets/reorderable_grid_view/reorderable_grid_item.dart';

late StreamController<Object> _streamController;
late StreamController<Offset> _streamControllerForOverlayPosition;

// ignore: must_be_immutable
class ReorderableGridView extends StatefulWidget {
  List<ReorderableGridItem>? children;

  List<int>? orderedIndexes;

  ScrollController? scrollController;

  final bool allowScroll;

  final ValueNotifier<double>? contentHeight;

  final Function(List<ReorderableGridItem?>)? onOrderChange;

  ReorderableGridView({
    GlobalKey? key,
    this.children,
    this.onOrderChange,
    this.orderedIndexes,
    this.scrollController,
    this.allowScroll = true,
    this.contentHeight,
  }) : super(key: key);

  // : assert(children.length == (orderedIndexes?.length ?? children.length));

  @override
  _ReorderableGridViewState createState() => _ReorderableGridViewState();
}

class _ReorderableGridViewState extends State<ReorderableGridView>
    with TickerProviderStateMixin {
  List<DragItem> dragItems = [];

  Offset? dragableEntryWidgetPosition;
  late OverlayEntry dragableEntry;

  late Offset dragItemStartLocalOffset;

  Offset nextItemStartOffset = const Offset(0, 0);

  late Offset currentEmptySpacePosition;

  double maxScrollExtend = 0;
  double _screenWidth = 0;
  double _screenHeight = 0;

  double _layoutTopMargin = 0;

  late BoxConstraints _boxConstraints;

  final GlobalKey _layoutKey = GlobalKey();

  late AppModel model;

  @override
  void initState() {
    _streamController = StreamController.broadcast();
    _streamControllerForOverlayPosition = StreamController<Offset>.broadcast();

    dragItems = widget.children!
        .map((ReorderableGridItem e) => DragItem(
              child: e,
              leftOffset: 0,
              topOffset: 0,
            ))
        .toList();

    WidgetsBinding.instance!
        .addPostFrameCallback((_) => afterFirstLayout(context));

    model = AppModel();
    super.initState();
  }

  afterFirstLayout(BuildContext context) {
    // _initChildrenData();
    //
    // Future.delayed(Duration(milliseconds: 100)).then((value) {
    _initChildrenData();
    widget.contentHeight?.value = maxScrollExtend;

    // });
  }

  @override
  void didUpdateWidget(covariant ReorderableGridView oldWidget) {
    nextItemStartOffset = const Offset(0, 0);

    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    Future.delayed(const Duration(milliseconds: 50), () {
      RenderBox? renderBox =
          _layoutKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        _layoutTopMargin = renderBox.localToGlobal(Offset.zero).dy;
      }
    });
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        _boxConstraints = constraints;
        return Container(
          height: constraints.maxHeight,
          key: _layoutKey,
          width: _screenWidth,
          child: SingleChildScrollView(
            controller: widget.scrollController,
            dragStartBehavior: DragStartBehavior.start,
            padding: const EdgeInsets.only(bottom: 20, top: 10),
            physics: widget.allowScroll
                ? const BouncingScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            child: Container(
              height: maxScrollExtend,
              width: _screenWidth,
              child: Stack(
                alignment: Alignment.topCenter,
                fit: StackFit.expand,
                key: UniqueKey(),
                children: dragItems.map((DragItem e) => e).toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  _onDragUpdate(DragItem dragItem, {LongPressMoveUpdateDetails? details}) {
    if (dragItem.child!.allowDrag) {
      // dragableEntry?.remove();

      if ((details!.globalPosition - dragItemStartLocalOffset).dy >
          _screenHeight - 180) {
        widget.scrollController!.position.moveTo(
          widget.scrollController!.offset + 10,
        );
      } else if ((details.globalPosition - dragItemStartLocalOffset).dy < 50) {
        widget.scrollController!.position.moveTo(
          widget.scrollController!.offset - 10,
        );
      }

      List<DragItem> replacingItems = _getReplacingItems(
          cursorLongPressUpdateDetails: details, draggedItem: dragItem);

      // DragItem _dragItem = dragItem;

      // _dragItem.child = _dragItem.child.copyWith(key: _globalKey);

      _streamControllerForOverlayPosition
          .add(details.globalPosition - dragItemStartLocalOffset);

      // _addOverlayEntry(
      //     dragItem: _dragItem,
      //     position: );

      // dragItem.updateChild(child: dragItem.child.copyWith(key: GlobalKey()));

      if (replacingItems.length == 1) {
        if (replacingItems.any((DragItem element) =>
            element.child!.widthFlex > dragItem.child!.widthFlex)) {
          _doReplaceForAllItemsInsideTheSameRowWithLastReplacedItem(
            replacingItems: replacingItems,
            draggedItem: dragItem,
          );
        } else {
          if (dragItem.child!.widthFlex == 0.5 &&
              replacingItems.first.child!.widthFlex == 0.5) {
            _doReplaceForTwoHalfWidthItems(
              replacingItem: replacingItems.first,
            );
          } else {
            _doReplaceForMaxWidthDraggedItem(
              replacingItem: replacingItems.first,
              draggedItem: dragItem,
            );
          }
        }
      } else if (replacingItems.length >= 2 && dragItem.child!.widthFlex == 1) {
        _doReplaceForMaxWidthDraggedItemAndMultipleReplacings(
          replacingItems: replacingItems,
          draggedItem: dragItem,
        );
      }
    }
  }

  _doReplaceForMaxWidthDraggedItem(
      {DragItem? replacingItem, DragItem? draggedItem}) {
    double? replacingItemDx = replacingItem?.leftOffset;
    double? replacingItemDy = replacingItem?.topOffset;

    for (DragItem element in dragItems) {
      if (replacingItem != null) {
        if (replacingItem.id == element.id) {
          // element.leftOffset = currentEmptySpacePosition.dx;

          if (replacingItem.topOffset! < draggedItem!.topOffset! &&
              draggedItem.height! > replacingItem.height!) {
            element.topOffset = currentEmptySpacePosition.dy +
                draggedItem.height! -
                replacingItem.height!;
          } else if (replacingItemDy! < draggedItem.topOffset! &&
              draggedItem.height! < replacingItem.height!) {
            element.topOffset = currentEmptySpacePosition.dy -
                (replacingItem.height! - draggedItem.height!);
          } else if (replacingItemDy < draggedItem.topOffset! &&
              draggedItem.height! > replacingItem.height!) {
            element.topOffset = currentEmptySpacePosition.dy +
                (replacingItem.height! - draggedItem.height!);
          } else {
            element.topOffset = currentEmptySpacePosition.dy;
          }

          element.leftOffset = currentEmptySpacePosition.dx;

          // replacingItemDx = element?.leftOffset;
          // replacingItemDy = element?.topOffset;

          //print(draggedItem.topOffset);
          //print(replacingItemDy);

          _streamController.add(true);

          currentEmptySpacePosition =
              Offset(replacingItemDx!, replacingItemDy!);

          if (replacingItemDy > draggedItem.topOffset! &&
              draggedItem.height! < replacingItem.height!) {
            //print("-----------------___E-------------");
            currentEmptySpacePosition = Offset(replacingItemDx,
                replacingItemDy + replacingItem.height! - draggedItem.height!);
          } else if (replacingItemDy < draggedItem.topOffset! &&
              draggedItem.height! < replacingItem.height!) {
            //print("-----------------___D-------------");

            currentEmptySpacePosition =
                Offset(replacingItemDx, replacingItemDy);
          } else if (replacingItemDy > draggedItem.topOffset! &&
              draggedItem.height! > replacingItem.height!) {
            //print("-----------------___W-------------");

            currentEmptySpacePosition = Offset(
                replacingItemDx,
                replacingItemDy -
                    (draggedItem.height! - replacingItem.height!));
          }

          draggedItem.topOffset = currentEmptySpacePosition.dy;
        }
      }
    }
  }

  void _doReplaceForTwoHalfWidthItems({DragItem? replacingItem}) {
    double? replacingItemDx = replacingItem?.leftOffset;
    double? replacingItemDy = replacingItem?.topOffset;

    for (DragItem element in dragItems) {
      if (replacingItem != null) {
        if (replacingItem.id == element.id) {
          // element.leftOffset = currentEmptySpacePosition.dx;
          element.topOffset = currentEmptySpacePosition.dy;
          element.leftOffset = currentEmptySpacePosition.dx;

          _streamController.add(true);

          currentEmptySpacePosition =
              Offset(replacingItemDx!, replacingItemDy!);
        }
      }
    }
  }

  void _doReplaceForMaxWidthDraggedItemAndMultipleReplacings(
      {required List<DragItem> replacingItems, required DragItem draggedItem}) {
    double replacingItemDy = replacingItems.last.topOffset ?? 0.0;

    for (DragItem element in replacingItems) {
      // element.leftOffset = currentEmptySpacePosition.dx;

      if (draggedItem.height! > replacingItems.last.height! &&
          replacingItemDy < draggedItem.topOffset!) {
        element.topOffset = currentEmptySpacePosition.dy +
            draggedItem.height! -
            replacingItems.last.height!;
        //print("--------------------------------");
      } else {
        element.topOffset = currentEmptySpacePosition.dy;
      }

      _streamController.add(true);

      // print("replace item dy : $replacingItemDy");
    }

    currentEmptySpacePosition = Offset(0, replacingItemDy);

    if (draggedItem.height! > replacingItems.last.height! &&
        replacingItemDy > draggedItem.topOffset!) {
      currentEmptySpacePosition = Offset(
          0,
          replacingItemDy -
              (draggedItem.height! - replacingItems.last.height!));
    } else {
      currentEmptySpacePosition = Offset(0, replacingItemDy);
    }
  }

  void _doReplaceForAllItemsInsideTheSameRowWithLastReplacedItem(
      {required List<DragItem> replacingItems, required DragItem draggedItem}) {
    double? replacingItemDy = replacingItems.last.topOffset;
    double? draggedItemDy = draggedItem.topOffset;
    double replacingItemDx = currentEmptySpacePosition.dx;

    List<DragItem> itemsInsideTheSameRow = dragItems.where((DragItem element) {
      return element.topOffset == currentEmptySpacePosition.dy;
    }).toList();

    for (DragItem element in replacingItems) {
      if (draggedItem.height! < replacingItems.first.height! &&
          replacingItemDy! < draggedItem.topOffset!) {
        element.topOffset = currentEmptySpacePosition.dy -
            (replacingItems.first.height! - draggedItem.height!);
        // print("--------------------------------");
      } else {
        element.topOffset = currentEmptySpacePosition.dy;
      }

      _streamController.add(true);

      // print("replace item dy : $replacingItemDy");
    }

    if (draggedItem.height! < replacingItems.first.height! &&
        replacingItemDy! > draggedItemDy!) {
      currentEmptySpacePosition = Offset(
          replacingItemDx,
          replacingItemDy +
              (replacingItems.first.height! - draggedItem.height!));
    } else {
      currentEmptySpacePosition = Offset(0, replacingItemDy!);
    }

    for (DragItem element in itemsInsideTheSameRow) {
      element.topOffset = currentEmptySpacePosition.dy;

      _streamController.add(true);
    }

    if (draggedItem.height! < replacingItems.first.height! &&
        replacingItemDy > draggedItemDy!) {
      currentEmptySpacePosition = Offset(
          replacingItemDx,
          replacingItemDy +
              (replacingItems.first.height! - draggedItem.height!));
    } else {
      currentEmptySpacePosition = Offset(replacingItemDx, replacingItemDy);
    }
  }

  List<DragItem> _getReplacingItems(
      {LongPressMoveUpdateDetails? cursorLongPressUpdateDetails,
      DragItem? draggedItem}) {
    return dragItems.where((DragItem item) {
      bool checkDx = draggedItem!.child!.widthFlex == 1
          ? true
          : (cursorLongPressUpdateDetails!.globalPosition).dx >
                  item.leftOffset! &&
              (cursorLongPressUpdateDetails.globalPosition).dx <
                  item.leftOffset! + item.width!;

      return (cursorLongPressUpdateDetails!.globalPosition -
                          dragItemStartLocalOffset)
                      .dy -
                  (_screenHeight -
                      _layoutTopMargin -
                      _boxConstraints.maxHeight) +
                  widget.scrollController!.offset >
              item.topOffset! &&
          (cursorLongPressUpdateDetails.globalPosition -
                          dragItemStartLocalOffset)
                      .dy -
                  (_screenHeight -
                      _layoutTopMargin -
                      _boxConstraints.maxHeight) +
                  widget.scrollController!.offset <
              item.topOffset! + item.height! / 2 &&
          checkDx &&
          item.id != draggedItem.id &&
          item.child!.allowDrag;
    }).toList();
  }

  void _onDragStart(DragItem dragItem, {LongPressStartDetails? details}) {
    model.appinfo.setCurrentDrag(true);

    if (dragItem.child!.allowDrag) {
      dragItemStartLocalOffset = details!.localPosition;

      if (dragItemStartLocalOffset.dy <= _layoutTopMargin) {
        _layoutTopMargin = dragItemStartLocalOffset.dy;
      }

      currentEmptySpacePosition =
          Offset(dragItem.leftOffset!, dragItem.topOffset!);

      DragItem _dragItem = dragItem;

      _dragItem.child = _dragItem.child!.copyWith(key: _globalKey);
      _addOverlayEntry(
        dragItem: _dragItem,
        position: details.globalPosition - details.localPosition,
      );
    }
  }

  final GlobalKey _globalKey = GlobalKey();

  void _onDragEnd(DragItem dragItem, {LongPressEndDetails? details}) {
    model.appinfo.setCurrentDrag(false);
    if (dragItem.child!.allowDrag) {
      dragItem.topOffset = currentEmptySpacePosition.dy;
      dragItem.leftOffset = currentEmptySpacePosition.dx;

      dragableEntry.remove();

      setState(() {});

      dragItems.sort((DragItem a, DragItem b) =>
          ((a.topOffset! + a.leftOffset!) - (b.topOffset! + b.leftOffset!))
              .toInt());

      widget.onOrderChange!(dragItems.map((DragItem e) => e.child).toList());
    }
  }

  void _addOverlayEntry({DragItem? dragItem, Offset? position}) {
    dragableEntryWidgetPosition = position;

    dragableEntry = OverlayEntry(
      builder: (BuildContext context) {
        return StreamBuilder<Offset>(
            stream: _streamControllerForOverlayPosition.stream,
            initialData: position,
            builder: (BuildContext context, AsyncSnapshot<Offset> snapshot) {
              return Positioned(
                left: snapshot.data!.dx,
                top: snapshot.data!.dy,
                child: Transform.scale(
                  scale: 1.08,
                  child: dragItem!.child,
                ),
              );
            });
      },
    );

    Overlay.of(context)!.insert(dragableEntry);
  }

  void _initChildrenData() {
    dragItems = [];
    List<ReorderableGridItem> dragTemporaryItems = [];

    for (int i = 0; i < widget.children!.length; i++) {
      widget.children![i].setOrderNumber(i + 1);
    }

    if (widget.orderedIndexes != null) {
      for (int i = 0; i < widget.orderedIndexes!.length; i++) {
        dragTemporaryItems.add(widget.children!.firstWhere(
            (ReorderableGridItem element) =>
                element.orderNumber == widget.orderedIndexes![i]));
      }
    } else {
      for (int i = 0; i < widget.children!.length; i++) {
        dragTemporaryItems.add(widget.children![i]);
      }
    }

    for (int childIndex = 0;
        childIndex < dragTemporaryItems.length;
        childIndex++) {
      DragItem dragItem;

      ReorderableGridItem currentChild = dragTemporaryItems[childIndex];

      GlobalKey globalKey =
          currentChild.key as GlobalKey<State<StatefulWidget>>;
      RenderBox? _renderBoxCurrentItem =
          globalKey.currentContext?.findRenderObject() as RenderBox?;
      //print("The size of current item: ${_renderBoxCurrentItem.size.height}");

      double currentItemWidth = _renderBoxCurrentItem?.size.width ?? 0;
      double currentItemHeight = _renderBoxCurrentItem?.size.height ?? 0;

      dragItem = DragItem(
        child: currentChild,
        width: currentItemWidth,
        height: currentItemHeight,
        leftOffset: nextItemStartOffset.dx,
        topOffset: nextItemStartOffset.dy,
        onDragEnd: _onDragEnd,
        onDragStart: _onDragStart,
        id: childIndex.toString(),
        onDragUpdate: _onDragUpdate,
      );

      nextItemStartOffset += Offset(currentItemWidth, 0);

      if (nextItemStartOffset.dx + currentItemWidth > _screenWidth) {
        nextItemStartOffset = Offset(
          0,
          nextItemStartOffset.dy + currentItemHeight,
        );
      }
      //maxScrollExtend = nextItemStartOffset.dy + currentItemHeight;
      maxScrollExtend = nextItemStartOffset.dy;
      dragItems.add(dragItem);
    }

    setState(() {});
  }
}

// ignore: must_be_immutable
class DragItem extends StatefulWidget {
  String? id;
  ReorderableGridItem? child;
  double? leftOffset;
  double? topOffset;
  double? width;
  double? height;

  Function(DragItem, {LongPressStartDetails details})? onDragStart;
  Function(DragItem, {LongPressMoveUpdateDetails details})? onDragUpdate;
  Function(DragItem, {LongPressEndDetails? details})? onDragEnd;

  DragItem({
    this.child,
    this.leftOffset,
    this.topOffset,
    this.id,
    this.height,
    this.width,
    this.onDragEnd,
    this.onDragStart,
    this.onDragUpdate,
  });

  DragItem updateChild({
    Widget? child,
  }) {
    return DragItem(
      child: child as ReorderableGridItem? ?? this.child,
    );
  }

  @override
  _DragItemState createState() => _DragItemState();
}

class _DragItemState extends State<DragItem> {
  bool isDragging = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: _streamController.stream,
        builder: (BuildContext context, AsyncSnapshot<Object> snapshot) {
          return AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            left: widget.leftOffset,
            top: widget.topOffset,
            child: Opacity(
              opacity: isDragging ? 0 : 1,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onLongPressStart: (LongPressStartDetails details) {
                  ReorderableGridItem element = widget.child!;
                  if (element.allowDrag == true) {
                    setState(() {
                      isDragging = true;
                    });
                    widget.onDragStart!(widget, details: details);
                  }
                },
                onLongPressMoveUpdate: (LongPressMoveUpdateDetails details) {
                  ReorderableGridItem element = widget.child!;
                  if (element.allowDrag == true) {
                    setState(() {
                      isDragging = true;
                    });
                    widget.onDragUpdate!(widget, details: details);
                  }
                },
                onLongPressEnd: (LongPressEndDetails details) {
                  ReorderableGridItem element = widget.child!;
                  if (element.allowDrag == true) {
                    setState(() {
                      isDragging = true;
                    });
                    widget.onDragEnd!(widget, details: details);
                  }
                },
                child: widget.child,
              ),
            ),
          );
        });
  }
}

// class CustomSimulation extends Simulation {
//   final double initPosition;
//   final double velocity;

//   CustomSimulation({this.initPosition, this.velocity});

//   @override
//   double x(double time) {
//     var max = math.max(math.min(initPosition, 0.0), initPosition + time);

//     // print(max.toString());

//     return max;
//   }

//   @override
//   double dx(double time) {
//     // print(velocity.toString());
//     return 0;
//   }

//   @override
//   bool isDone(double time) {
//     return false;
//   }
// }

// class CustomScrollPhysics extends ScrollPhysics {
//   @override
//   ScrollPhysics applyTo(ScrollPhysics ancestor) {
//     return CustomScrollPhysics();
//   }

//   @override
//   Simulation createBallisticSimulation(
//       ScrollMetrics position, double velocity) {
//     return CustomSimulation(
//       initPosition: position.pixels,
//       velocity: velocity,
//     );
//   }
// }
