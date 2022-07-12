import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseWidget<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget? child) builder;
  final T model;
  final Widget? child;
  final Function(T)? onModelReady;
  final Function(T)? onModelUpdate;

  BaseWidget({
    Key? key,
    required this.builder,
    required this.model,
    this.child,
    this.onModelReady,
    this.onModelUpdate,
  }) : super(key: key);

  @override
  _BaseWidgetState<T> createState() => _BaseWidgetState<T>();
}

class _BaseWidgetState<T extends ChangeNotifier> extends State<BaseWidget<T>> {
  late T model;

  @override
  void initState() {
    model = widget.model;

    widget.onModelReady?.call(model);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T?>(
      create: (BuildContext context) => model,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant BaseWidget<T> oldWidget) {
    oldWidget.onModelUpdate?.call(model);
    super.didUpdateWidget(oldWidget);
  }
}
