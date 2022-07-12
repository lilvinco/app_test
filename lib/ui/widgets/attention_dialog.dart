import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:igroove_fan_box_one/constants/assets.dart';
import 'package:igroove_fan_box_one/core/services/user_service.dart';
import 'package:igroove_fan_box_one/ui/shared/themes.dart';

class AttentionDialog extends StatefulWidget {
  final String? title;
  final String? message;
  final String? confirmText;
  final String? cancelText;
  final bool? showComfirm;
  final bool showTrashCan;

  const AttentionDialog(
      {Key? key,
      this.title,
      this.message,
      this.confirmText,
      this.showTrashCan = true,
      this.cancelText,
      this.showComfirm})
      : super(key: key);

  @override
  _AttentionDialogState createState() => _AttentionDialogState();
}

class _AttentionDialogState extends State<AttentionDialog> {
  @override
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        width: double.maxFinite,
        padding: const EdgeInsets.all(20),
        // decoration: BoxDecoration(
        //   color: IGrooveTheme.colors.white,
        //   borderRadius: BorderRadius.circular(10),
        // ),
        decoration: BoxDecoration(
          color: IGrooveTheme.colors.black3,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: IGrooveTheme.colors.black!,
              offset: const Offset(0.0, 5),
              blurRadius: 50.0,
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (widget.showTrashCan)
              Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 40),
                child: SvgPicture.asset(
                  IGrooveAssets.svgTrashRed,
                  height: 60,
                  width: 60,
                ),
              ),
            if (!widget.showTrashCan) const SizedBox(height: 20),
            Text(
              widget.title!,
              style: Theme.of(context).primaryTextTheme.headline4!.copyWith(
                    fontSize: 21,
                    height: 24 / 21,
                    fontWeight: FontWeight.w600,
                    color: IGrooveTheme.colors.primary,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 31),
              child: Text(
                widget.message!,
                style: Theme.of(context).primaryTextTheme.headline4!.copyWith(
                    fontSize: 16,
                    height: 21 / 16,
                    fontWeight: FontWeight.w400,
                    color: IGrooveTheme.colors.primary),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 40),
            buildButton(value: false, text: widget.cancelText!),
            const SizedBox(height: 15),
            widget.showComfirm == true || !UserService.userDataModel!.isDemoUser
                ? buildButton(value: true, text: widget.confirmText!)
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget buildButton({required bool value, required String text}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.89,
      height: 46,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: value ? IGrooveTheme.colors.red6 : IGrooveTheme.colors.white,
      ),
      child: CupertinoButton(
        color: value ? IGrooveTheme.colors.red : IGrooveTheme.colors.whiteColor,
        padding: const EdgeInsets.all(0),
        pressedOpacity: IGrooveTheme.opacityHigh,
        borderRadius: BorderRadius.circular(8),
        child: Text(
          text,
          style: Theme.of(context).primaryTextTheme.headline2!.copyWith(
                color: value
                    ? IGrooveTheme.colors.white
                    : IGrooveTheme.colors.black,
                // height: 1.4375,
                letterSpacing: -0.3,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
          textAlign: TextAlign.center,
        ),
        onPressed: () {
          Navigator.of(context).pop(value);
        },
      ),
    );
  }
}

class AttentionDialogOutlined extends StatefulWidget {
  final String? title;
  final String? message;
  final String? confirmText;
  final String? cancelText;
  final bool? showComfirm;
  final bool showTrashCan;

  const AttentionDialogOutlined(
      {Key? key,
      this.title,
      this.message,
      this.confirmText,
      this.showTrashCan = true,
      this.cancelText,
      this.showComfirm})
      : super(key: key);

  @override
  _AttentionDialogOutlinedState createState() =>
      _AttentionDialogOutlinedState();
}

class _AttentionDialogOutlinedState extends State<AttentionDialogOutlined> {
  @override
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        width: double.maxFinite,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: IGrooveTheme.colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (widget.showTrashCan)
              Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 40),
                child: SvgPicture.asset(
                  IGrooveAssets.svgTrashRed,
                  height: 60,
                  width: 60,
                ),
              ),
            if (!widget.showTrashCan) const SizedBox(height: 20),
            Text(
              widget.title!,
              style: Theme.of(context).primaryTextTheme.headline4!.copyWith(
                    fontSize: 21,
                    height: 24 / 21,
                    fontWeight: FontWeight.w600,
                    color: IGrooveTheme.colors.black,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 31),
              child: Text(
                widget.message!,
                style: Theme.of(context).primaryTextTheme.headline4!.copyWith(
                    fontSize: 16,
                    height: 21 / 16,
                    fontWeight: FontWeight.w400,
                    color: IGrooveTheme.colors.lightGrey),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 40),
            buildButton(value: false, text: widget.cancelText!),
            const SizedBox(height: 15),
            widget.showComfirm == true || !UserService.userDataModel!.isDemoUser
                ? buildButtonDelete(value: true, text: widget.confirmText!)
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget buildButton({bool? value, required String text}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.of(context).pop(value);
      },
      child: Container(
        height: 46,
        width: MediaQuery.of(context).size.width * 0.89,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: IGrooveTheme.colors.whiteColor,
            border:
                Border.all(color: IGrooveTheme.colors.whiteColor!, width: 2)),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              decoration: TextDecoration.none,
              color: IGrooveTheme.colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildButtonDelete({bool? value, required String text}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.of(context).pop(value);
      },
      child: Container(
        height: 46,
        width: MediaQuery.of(context).size.width * 0.89,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: IGrooveTheme.colors.white,
            border: Border.all(color: IGrooveTheme.colors.red!, width: 2)),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              decoration: TextDecoration.none,
              color: IGrooveTheme.colors.red,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
