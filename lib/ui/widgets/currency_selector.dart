import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:igroove_fan_box_one/constants/assets.dart';
import 'package:igroove_fan_box_one/ui/shared/themes.dart';

class CurrencySelectorDialog extends StatefulWidget {
  final String? title;
  final String? message;
  final String? confirmText;
  final String? cancelText;
  final bool? showComfirm;
  final bool showTrashCan;

  const CurrencySelectorDialog(
      {Key? key,
      this.title,
      this.message,
      this.confirmText,
      this.showTrashCan = true,
      this.cancelText,
      this.showComfirm})
      : super(key: key);

  @override
  _CurrencySelectorDialogState createState() => _CurrencySelectorDialogState();
}

class _CurrencySelectorDialogState extends State<CurrencySelectorDialog> {
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
            const SizedBox(height: 30),
            buildButton(
                value: true,
                text: widget.confirmText!,
                desciption: "The user experience will be adjusted to Euro",
                icon: "€"),
            const SizedBox(height: 15),
            buildButton(
                value: false,
                text: widget.cancelText!,
                desciption: "The user experience will be adjusted to USD",
                icon: "\$"),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  Widget buildButton(
      {required bool value,
      required String text,
      required String desciption,
      required String icon}) {
    return LoginDemoCard(
        title: text,
        description: desciption,
        onTap: () {
          Navigator.of(context).pop(value);
          // Navigator.of(context).pushReplacementNamed(
          //   AppRoutes.editReleaseProcess,
          //   arguments: ReleaseProcessParameters(isSingle: true),
          // );
        },
        leading: Container(
          width: 50,
          child: Text(icon,
              style: const TextStyle(
                fontSize: 40,
              )),
        ));
    // Container(
    //   width: MediaQuery.of(context).size.width * 0.89,
    //   height: 46,
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(50),
    //     color: IGrooveTheme.colors.white,
    //   ),
    //   child: CupertinoButton(
    //     color: IGrooveTheme.colors.whiteColor,
    //     padding: const EdgeInsets.all(0),
    //     pressedOpacity: IGrooveTheme.opacityHigh,
    //     borderRadius: BorderRadius.circular(8),
    //     child: Text(
    //       text,
    //       style: Theme.of(context).primaryTextTheme.headline2!.copyWith(
    //             color: IGrooveTheme.colors.black,
    //             // height: 1.4375,
    //             letterSpacing: -0.3,
    //             fontWeight: FontWeight.w500,
    //             fontSize: 16,
    //           ),
    //       textAlign: TextAlign.center,
    //     ),
    //     onPressed: () {
    //       Navigator.of(context).pop(value);
    //     },
    //   ),
    // );
  }
}

class LoginDemoCard extends StatelessWidget {
  const LoginDemoCard({
    Key? key,
    required this.title,
    required this.description,
    this.leading,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final String description;
  final Widget? leading;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
              decoration: BoxDecoration(
                border: Border.all(
                  color: IGrooveTheme.colors.black!.withOpacity(0.25),
                  width: 1,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (leading != null) leading!,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.2,
                            color: Colors.black.withOpacity(0.6),
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
