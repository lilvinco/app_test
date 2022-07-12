import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:igroove_fan_box_one/api/auth.dart';
import 'package:igroove_fan_box_one/base/base.dart';
import 'package:igroove_fan_box_one/config.dart';
import 'package:igroove_fan_box_one/constants/assets.dart';
import 'package:igroove_fan_box_one/helpers/utils.dart';

class IGrooveAppBarWidget {
  static Widget fanBoxAppBar({
    bool showNotifications = false,
    String? leftTitle = '',
    Widget? leading,
    Widget? trailing,
    Function? onLeftTap,
    Function? onRightTap,
  }) {
    bool clicked = false;
    return PreferredSize(
      preferredSize: Size.fromHeight(IGrooveTheme.headerHeight),
      child: Material(
          color: IGrooveTheme.colors.headerColor,
          child: AppBar(
            elevation: 0,
            backgroundColor: IGrooveTheme.colors.fanBoxBlack,
            automaticallyImplyLeading: false,
            centerTitle: false,
            titleSpacing: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                leftTitle != ""
                    ? Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: GestureDetector(
                          onTap: () async {
                            if (onLeftTap != null) {
                              onLeftTap();
                            } else {
                              Navigator.of(AppKeys
                                      .navigatorKey.currentState!.context)
                                  .pop();
                            }
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                IGrooveAssets.svgArrowBackGoldIcon,
                                width: 9,
                                height: 18,
                                color: IGrooveTheme.colors.primary,
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 15),
                                child: Text(leftTitle!,
                                    style: TextStyle(
                                        color: IGrooveTheme.colors.primary,
                                        fontSize: 16,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w500,
                                        height: 19 / 16)),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox(),
                Padding(
                  padding:
                      EdgeInsets.only(right: (trailing != null ? 0 : 25.0)),
                  child: trailing ??
                      GestureDetector(
                        onTap: () async {
                          if (onRightTap != null) {
                            onRightTap();
                          } else {
                            if (!clicked) {
                              clicked = true;
                              await Auth.check();
                              await Navigator.of(AppKeys
                                      .navigatorKey.currentState!.context)
                                  .pushNamed(AppRoutes.profile);
                              clicked = false;
                            }
                          }
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Row(
                          children: [],
                        ),
                      ),
                ),
              ],
            ),
          )),
    );
  }

  static Widget custom({
    String title = '',
    Widget? leading,
    Widget? trailing,
  }) {
    return PreferredSize(
      preferredSize: Size.fromHeight(IGrooveTheme.headerHeight),
      child: Material(
        color: IGrooveTheme.colors.headerColor,
        child: AppBar(
          centerTitle: true,
          backgroundColor: IGrooveTheme.colors.headerColor,
          elevation: 0,
          title: Text(
            Configs.APP_WHITELABEL ? title.toUpperCase() : title,
            style: TextStyle(
              color: IGrooveTheme.colors.whiteColor,
              fontSize:
                  Configs.APP_WHITELABEL ? null : IGrooveTheme.headerFontSize,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.3,
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(right: 2.0),
            child: leading,
          ),
          actions: [
            Container(
              constraints: const BoxConstraints(minWidth: 56),
              child: trailing,
            )
          ],
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      ),
    );
  }

  static Widget backCustom({
    String title = '',
    Widget? leading,
    Widget? trailing,
  }) {
    return PreferredSize(
      preferredSize: Size.fromHeight(IGrooveTheme.headerHeight),
      child: Material(
        color: IGrooveTheme.colors.headerColor,
        child: AppBar(
          centerTitle: false,
          backgroundColor: IGrooveTheme.colors.headerColor,
          elevation: 0,
          title: Text(
            Configs.APP_WHITELABEL ? title.toUpperCase() : title,
            style: TextStyle(
              color: IGrooveTheme.colors.whiteColor,
              fontSize:
                  Configs.APP_WHITELABEL ? null : IGrooveTheme.headerFontSize,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.3,
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(right: 2.0),
            child: leading,
          ),
          actions: [
            Container(
              constraints: const BoxConstraints(minWidth: 56),
              child: trailing,
            )
          ],
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      ),
    );
  }

  static Widget onlyWidget({
    Widget? title,
    Widget? leading,
    Widget? trailing,
  }) {
    return PreferredSize(
      preferredSize: Size.fromHeight(IGrooveTheme.headerHeight),
      child: Material(
        color: IGrooveTheme.colors.headerColor,
        child: AppBar(
          foregroundColor: IGrooveTheme.colors.primary,
          backgroundColor: IGrooveTheme.colors.primary,
          automaticallyImplyLeading: false,
          centerTitle: false,
          // backgroundColor: IGrooveTheme.colors.headerColor,
          // elevation: 0,
          title: title, systemOverlayStyle: SystemUiOverlayStyle.light,
          // leading: const SizedBox(width: 0),

          // actions: [
          //   Container(
          //     constraints: const BoxConstraints(minWidth: 56),
          //     child: trailing,
          //   )
          // ],
        ),
      ),
    );
  }

  static Widget withRightText({
    String? title = '',
    String? rightText,
    Widget? leadingIcon,
    Widget stackedWidget = const SizedBox(),
    Function? onTap,
    Function? onActionTap,
  }) {
    return PreferredSize(
      preferredSize: Size.fromHeight(IGrooveTheme.headerHeight),
      child: Material(
        color: IGrooveTheme.colors.headerColor,
        child: Padding(
          padding: IGrooveTheme.headerPadding,
          child: Stack(
            children: [
              AppBar(
                centerTitle: true,
                backgroundColor: IGrooveTheme.colors.headerColor,
                elevation: 0,
                leadingWidth: IGrooveTheme.headerIconWidth +
                    IGrooveTheme.headerIconPadding.left +
                    IGrooveTheme.headerIconPadding.right,
                title: Text(
                  Configs.APP_WHITELABEL ? title!.toUpperCase() : title!,
                  style: TextStyle(
                    color: IGrooveTheme.colors.whiteColor,
                    fontSize: Configs.APP_WHITELABEL
                        ? null
                        : IGrooveTheme.headerFontSize,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.3,
                  ),
                ),
                leading: GestureDetector(
                  onTap: onTap as void Function()?,
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    padding: IGrooveTheme.headerIconPadding,
                    child: Container(
                      width: IGrooveTheme.headerIconWidth,
                      child: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          IGrooveTheme.colors.white!,
                          BlendMode.srcATop,
                        ),
                        child: leadingIcon,
                      ),
                    ),
                  ),
                ),
                actions: [
                  if (rightText != null)
                    GestureDetector(
                      onTap: onActionTap as void Function()?,
                      behavior: HitTestBehavior.translucent,
                      child: Padding(
                        padding: IGrooveTheme.headerIconPadding,
                        child: Center(
                          child: Text(
                            rightText,
                            style: TextStyle(
                              height: 16 / 16,
                              color: IGrooveTheme.colors.white,
                              fontSize: IGrooveTheme.headerFontSize,
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.3,
                            ),
                          ),
                        ),
                      ),
                    )
                ],
                systemOverlayStyle: SystemUiOverlayStyle.light,
              ),
              stackedWidget,
            ],
          ),
        ),
      ),
    );
  }

  static Widget withRightIcon({
    String? title = '',
    Widget? leading,
    Widget? leadingIcon,
    Widget? actionIcon,
    Function? onTap,
    Function? onActionTap,
    Widget stackedWidget = const SizedBox(),
    BuildContext? context,
    Color? bgColor,
  }) {
    bgColor ??= IGrooveTheme.colors.headerColor;

    return PreferredSize(
      preferredSize: Size.fromHeight(IGrooveTheme.headerHeight),
      child: Material(
        elevation: 0,
        color: bgColor,
        child: Padding(
          padding:
              leading != null ? EdgeInsets.zero : IGrooveTheme.headerPadding,
          child: Stack(
            children: [
              AppBar(
                toolbarHeight: IGrooveTheme.headerHeight,
                centerTitle: true,
                backgroundColor: bgColor,
                leadingWidth: leading == null
                    ? IGrooveTheme.headerIconWidth +
                        IGrooveTheme.headerIconPadding.left +
                        IGrooveTheme.headerIconPadding.right
                    : null,
                elevation: 0,
                title: Text(
                  Configs.APP_WHITELABEL ? title!.toUpperCase() : title!,
                  style: TextStyle(
                    color: IGrooveTheme.colors.whiteColor,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.3,
                  ),
                ),
                leading: Padding(
                  padding: const EdgeInsets.only(right: 2.0),
                  child: leading ??
                      GestureDetector(
                        onTap: onTap as void Function()?,
                        behavior: HitTestBehavior.translucent,
                        child: Container(
                          padding: IGrooveTheme.headerIconPadding,
                          child: Container(
                            width: IGrooveTheme.headerIconWidth,
                            child: ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                IGrooveTheme.colors.white!,
                                BlendMode.srcATop,
                              ),
                              child: leadingIcon,
                            ),
                          ),
                        ),
                      ),
                ),
                actions: [
                  Padding(
                    padding: leading != null
                        ? EdgeInsets.only(
                            right: IGrooveTheme.headerIconPadding.left +
                                IGrooveTheme.headerIconPadding.right)
                        : EdgeInsets.zero,
                    child: GestureDetector(
                      onTap: onActionTap as void Function()?,
                      behavior: HitTestBehavior.translucent,
                      child: Container(
                        padding: IGrooveTheme.headerIconPadding,
                        height: IGrooveTheme.headerIconHeight,
                        child: Container(
                          width: IGrooveTheme.headerIconWidth,
                          child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              IGrooveTheme.colors.whiteColor!,
                              BlendMode.srcATop,
                            ),
                            child: actionIcon,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
                systemOverlayStyle: SystemUiOverlayStyle.light,
              ),
              stackedWidget,
            ],
          ),
        ),
      ),
    );
  }

  static Widget withRightIconAndWidgetTitle({
    Widget? title,
    Widget? leadingIcon,
    Widget? actionIcon,
    Function? onTap,
    Function? onActionTap,
    Widget stackedWidget = const SizedBox(),
  }) {
    return PreferredSize(
      preferredSize: Size.fromHeight(IGrooveTheme.headerHeight),
      child: Material(
        color: IGrooveTheme.colors.headerColor,
        child: Stack(
          children: [
            AppBar(
              centerTitle: true,
              backgroundColor: IGrooveTheme.colors.headerColor,
              elevation: 0,
              title: title,
              leading: GestureDetector(
                onTap: onTap as void Function()?,
                behavior: HitTestBehavior.translucent,
                child: Container(
                  width: IGrooveTheme.headerIconWidth,
                  child: leadingIcon,
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: onActionTap as void Function()?,
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    padding: IGrooveTheme.headerIconPadding,
                    height: IGrooveTheme.headerIconHeight,
                    child: Container(
                      width: IGrooveTheme.headerIconWidth,
                      child: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          IGrooveTheme.colors.white!,
                          BlendMode.srcATop,
                        ),
                        child: actionIcon,
                      ),
                    ),
                  ),
                ),
              ],
              systemOverlayStyle: SystemUiOverlayStyle.light,
            ),
            stackedWidget,
          ],
        ),
      ),
    );
  }

  static Widget withRightIconAndWidgetTitleAndHeigher({
    Widget? title,
    Widget? leadingIcon,
    Widget? actionIcon,
    Function? onTap,
    Function? onActionTap,
    Widget stackedWidget = const SizedBox(),
  }) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(64),
      child: Material(
        color: IGrooveTheme.colors.headerColor,
        child: Stack(
          children: [
            AppBar(
              centerTitle: true,
              backgroundColor: IGrooveTheme.colors.headerColor,
              elevation: 0,
              title: title,
              leading: Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: leadingIcon,
              ),
              actions: [
                const SizedBox(width: 56),
              ],
              systemOverlayStyle: SystemUiOverlayStyle.light,
            ),
            stackedWidget,
          ],
        ),
      ),
    );
  }

  static Widget withNotificationIcon({Color? backgroundColor}) {
    Color? bgColor = IGrooveTheme.colors.headerColor;
    if (backgroundColor != null) bgColor = backgroundColor;
    return AppBar(
      toolbarHeight: IGrooveTheme.headerHeight,
      backgroundColor: bgColor,
      leading: const Padding(
        padding: EdgeInsets.only(right: 2.0),
        child: NotificationIconButton(),
      ),
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }
}

class NotificationIconButton extends StatefulWidget {
  const NotificationIconButton({Key? key, this.onPop}) : super(key: key);

  final Function()? onPop;

  @override
  State<NotificationIconButton> createState() => _NotificationIconButtonState();
}

class _NotificationIconButtonState extends State<NotificationIconButton> {
  int count = 0;

  getCount() async {
    count = await Utils.getNotificationCount();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getCount();
    Utils.streamControllerNotifictionCount.stream.listen((listenCount) {
      count = listenCount;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (Configs.APP_WHITELABEL == true) {
      return const SizedBox();
    }

    return GestureDetector(
      onTap: () async {
        await Navigator.of(context).pushNamed(AppRoutes.allNotifications);
        if (widget.onPop != null) widget.onPop!();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            IGrooveAssets.svgNotification,
            height: IGrooveTheme.headerIconHeight,
            width: IGrooveTheme.headerIconWidth,
          ),
          Positioned(
              left: 15,
              top: 3,
              child: count > 0
                  ? Container(
                      height: 20,
                      width: 20,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xffF23C3C),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text(
                        count > 99 ? '99+' : "$count",
                        style: Theme.of(context)
                            .primaryTextTheme
                            .headline1!
                            .copyWith(
                              color: IGrooveTheme.colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: count > 99 ? 7 : 11,
                            ),
                      ),
                    )
                  : const SizedBox()),
        ],
      ),
    );
  }
}
