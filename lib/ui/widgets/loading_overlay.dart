import 'package:flutter/material.dart';
import 'package:igroove_fan_box_one/config.dart';
import 'package:igroove_fan_box_one/constants/assets.dart';

class IGrooveProgressIndicator extends StatelessWidget {
  const IGrooveProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      child: Image(
          image: AssetImage(Configs.APP_WHITELABEL
              ? IGrooveAssets.loadingAnimationLabelApp
              : IGrooveAssets.loadingAnimation)),
    );
  }
}

class LoadingOverlay extends StatefulWidget {
  final bool isLoading;
  final double opacity;
  final Color color;
  final Widget progressIndicator;
  final Widget child;

  LoadingOverlay({
    required this.isLoading,
    required this.child,
    this.opacity = 1,
    this.progressIndicator = const IGrooveProgressIndicator(),
    this.color = Colors.white,
  });

  @override
  _LoadingOverlayState createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends State<LoadingOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool? _overlayVisible;

  @override
  void initState() {
    super.initState();
    _overlayVisible = false;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _animation.addStatusListener((AnimationStatus status) {
      status == AnimationStatus.forward
          ? setState(() => _overlayVisible = true)
          : null;
      status == AnimationStatus.dismissed
          ? setState(() => _overlayVisible = false)
          : null;
    });
    if (widget.isLoading) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(LoadingOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.isLoading && widget.isLoading) {
      _controller.forward();
    }

    if (oldWidget.isLoading && !widget.isLoading) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = <Widget>[];
    widgets.add(widget.child);

    if (_overlayVisible == true) {
      final FadeTransition modal = FadeTransition(
        opacity: _animation,
        child: Stack(
          children: <Widget>[
            Opacity(
              child: ModalBarrier(
                dismissible: false,
                color: widget.color,
              ),
              opacity: widget.opacity,
            ),
            Center(child: widget.progressIndicator),
          ],
        ),
      );
      widgets.add(modal);
    }

    return Stack(children: widgets);
  }
}
