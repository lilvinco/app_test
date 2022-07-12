import 'package:flutter/material.dart';
import 'package:igroove_fan_box_one/base/base.dart';
import 'package:igroove_fan_box_one/ui/shared/typography.dart';

class IGrooveButtonPrimary extends StatelessWidget {
  const IGrooveButtonPrimary({
    required this.labelText,
    required this.onPressed,
    this.textColor,
    this.backgroundColor,
    this.isLoading = false,
  });

  final String? labelText;
  final Function()? onPressed;
  final Color? textColor;
  final Color? backgroundColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return MaterialButton(
      elevation: 0,
      height: 52,
      disabledColor: IGrooveTheme.colors.primary!.withOpacity(0.4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      onPressed: !isLoading ? onPressed : () {},
      color: backgroundColor ?? IGrooveTheme.colors.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isLoading)
            SizedBox(
              height: 15,
              width: 15,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color?>(
                  IGrooveTheme.colors.white,
                ),
              ),
            ),
          if (isLoading) const SizedBox(width: 10),
          Text(
            labelText!,
            style: theme.primaryTextTheme.headline3!.copyWith(
              color: textColor ?? IGrooveTheme.colors.white,
              fontSize: 16,
              height: 16 / 16,
              letterSpacing: -0.19,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class IGrooveButtonSecondary extends StatelessWidget {
  const IGrooveButtonSecondary({
    required this.labelText,
    required this.onPressed,
    this.textColor,
    this.icon,
    this.backgroundColor,
    this.isLoading = false,
  });

  final String labelText;
  final Function() onPressed;
  final Color? textColor;
  final Color? backgroundColor;
  final bool isLoading;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return MaterialButton(
      elevation: 0,
      height: 52,
      disabledColor: IGrooveTheme.colors.primary!.withOpacity(0.4),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: textColor ?? IGrooveTheme.colors.primary!),
        borderRadius: BorderRadius.circular(8),
      ),
      onPressed: !isLoading ? onPressed : () {},
      color: backgroundColor ?? IGrooveTheme.colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isLoading)
            SizedBox(
              height: 15,
              width: 15,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color?>(
                  IGrooveTheme.colors.white,
                ),
              ),
            ),
          if (isLoading) const SizedBox(width: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (icon != null) icon!,
              Text(
                labelText,
                style: theme.primaryTextTheme.headline3!.copyWith(
                  color: textColor ?? IGrooveTheme.colors.primary,
                  fontSize: 16,
                  height: 16 / 16,
                  letterSpacing: -0.19,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class IGrooveButtonOutline extends StatelessWidget {
  const IGrooveButtonOutline({
    Key? key,
    required this.labelText,
    required this.onPressed,
    this.textColor,
    this.alignment = MainAxisAlignment.center,
    this.leadingIcon,
  }) : super(key: key);

  final String labelText;
  final Function() onPressed;
  final Color? textColor;
  final MainAxisAlignment alignment;

  final Widget? leadingIcon;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return OutlinedButton(
      style: ButtonStyle(
        splashFactory: NoSplash.splashFactory,
        textStyle: MaterialStateProperty.all(
          TextStyle(
            color: theme.iconTheme.color,
            height: 19 / 16,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            side: BorderSide(color: IGrooveTheme.colors.primary!, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      // padding: EdgeInsets.zero,
      // height: 35,
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: alignment,
        children: <Widget>[
          if (leadingIcon != null)
            Row(
              children: [
                Container(
                  child: leadingIcon,
                ),
                const SizedBox(width: 15),
              ],
            ),
          Container(
            child: Text(
              labelText,
              style: TextStyle(
                color: IGrooveTheme.colors.primary,
                fontSize: 16,
                height: 19 / 16,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class FanBoxOutlineButton extends StatelessWidget {
  const FanBoxOutlineButton({
    Key? key,
    required this.labelText,
    required this.onPressed,
    this.color,
  }) : super(key: key);

  final String labelText;
  final Color? color;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 54,
        width: double.infinity,
        decoration: BoxDecoration(
            color: color ?? IGrooveTheme.colors.transparent,
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            border: Border.all(
                color: color ?? IGrooveTheme.colors.primary!, width: 2)),
        child: Center(
          child: Text(
            labelText,
            style: TextStyle(
                color: IGrooveTheme.colors.primary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 19 / 16,
                letterSpacing: 0),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class IGrooveGreyButton extends StatelessWidget {
  const IGrooveGreyButton({
    Key? key,
    required this.labelText,
    required this.onPressed,
  }) : super(key: key);

  final String labelText;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: IGrooveTheme.colors.whiteColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Text(
          labelText,
          style: IGrooveFonts.kBodyMedium16,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
