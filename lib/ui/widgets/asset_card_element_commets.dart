// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:igroove_fan_box_one/constants/assets.dart';
import 'package:igroove_fan_box_one/core/services/audio_handler.dart';
import 'package:igroove_fan_box_one/core/services/media_player_service.dart';
import 'package:igroove_fan_box_one/core/services/user_service.dart';
import 'package:igroove_fan_box_one/localization/localization.dart';
import 'package:igroove_fan_box_one/base/base.dart';
import 'package:igroove_fan_box_one/management/helper.dart';
import 'package:igroove_fan_box_one/model/assets_model.dart';
import 'package:igroove_fan_box_one/ui/widgets/full_media_player_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';

import '../../model/releases_model.dart';

class ItemModel {
  String title;
  IconData icon;
  int id;
  ItemModel(this.title, this.icon, this.id);
}

// ignore: must_be_immutable
class AssetCardElementComment extends StatefulWidget {
  final int index;
  final int type;
  AssetModel asset;
  final bool isBooklet;
  final bool isVideo;
  final String titleBefore;
  final Function? onArchiveCallback;

  AssetCardElementComment({
    Key? key,
    required this.index,
    required this.asset,
    required this.type,
    required this.titleBefore,
    this.onArchiveCallback,
    this.isBooklet = false,
    this.isVideo = false,
  }) : super(key: key);

  @override
  _AssetCardElementCommentState createState() =>
      _AssetCardElementCommentState();
}

class _AssetCardElementCommentState extends State<AssetCardElementComment> {
  AssetModel? element;
  List<AssetModel>? assetList;
  MyAudioHandler audioHandler = MyAudioHandler();
  late List<ItemModel> menuItems;
  // final CustomPopupMenuController _controller = CustomPopupMenuController();
  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    element = widget.asset;
    menuItems = [
      if (UserService.userData!.payload!.user!.isArtist!)
        ItemModel(
            AppLocalizations().generalArchive!, Icons.auto_delete_outlined, 1),
      if (UserService.userData!.payload!.user!.isArtist!)
        ItemModel(AppLocalizations().generalEdit!, Icons.edit_outlined, 4),
      if (UserService.userData!.payload!.user!.isArtist!)
        element!.datePinned!
            ? ItemModel(AppLocalizations().generalUnpin!, Icons.push_pin, 6)
            : ItemModel(
                AppLocalizations().generalPin!, Icons.push_pin_outlined, 5),
      // ItemModel(
      //     AppLocalizations().generalReportContent!, Icons.flag_outlined, 2),
      // ItemModel(
      //     AppLocalizations().generalReportUser!, Icons.people_alt_outlined, 3),
    ];
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: Key('asset_card_element_${widget.index}'),
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
        decoration: BoxDecoration(
            color: IGrooveTheme.colors.grey3,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 25),
              child: Row(
                key: UniqueKey(),
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () async {
                      if (isPhoneVerificationOpen()) {
                        return;
                      }
                      setState(() {
                        if (!widget.asset.authUserLiked!) {
                          widget.asset.statistics!.likes =
                              widget.asset.statistics!.likes! + 1;
                        } else {
                          widget.asset.statistics!.likes =
                              widget.asset.statistics!.likes! - 1;
                        }

                        widget.asset.authUserLiked =
                            !widget.asset.authUserLiked!;
                      });
                      await setAssetLike(assetID: element!.id!);
                      widget.asset =
                          await getUpdatedAsset(assetID: element!.id!);
                      _init();
                    },
                    child: Row(
                      key: UniqueKey(),
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          element!.authUserLiked!
                              ? IGrooveAssets.svglikeFilledIcon
                              : IGrooveAssets.svgthumbUpTransparentIcon,
                          height: 15,
                          width: 15,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          singular(
                              raw: element!.statistics!.likes!,
                              formatted: element!.statistics!.likes!.toString(),
                              plural:
                                  AppLocalizations.of(context)!.generalLikes!,
                              singular:
                                  AppLocalizations.of(context)!.generalLike!),
                          style: TextStyle(
                            color: IGrooveTheme.colors.white,
                            fontSize: 13,
                            height: 13 / 13,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () async {
                      clickAction();
                    },
                    child: Row(
                      key: UniqueKey(),
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          IGrooveAssets.svgfChatIcon,
                          height: 15,
                          width: 15,
                        ),
                        Padding(
                          key: UniqueKey(),
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            singular(
                              raw: element!.statistics!.comments!,
                              formatted:
                                  element!.statistics!.commentsFormatted!,
                              singular:
                                  AppLocalizations.of(context)!.generalComment!,
                              plural: AppLocalizations.of(context)!
                                  .generalComments!,
                            ),
                            style: TextStyle(
                                color: IGrooveTheme.colors.white,
                                fontSize: 13,
                                height: 13 / 13,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  clickAction() async {
    if (element!.type == 1) {
      if (MyAudioHandler.mediaPlayerData.albumtracks!.isEmpty ||
          MyAudioHandler.mediaPlayerData.albumtracks?.first.filename !=
              element!.filename) {
        MyAudioHandler.updateMediaPlayerData(
          newMediaPlayerData: MediaPlayerData(
            activateStreaming: true,
            albumtracks: [element!],
            trackPosition: 0,
            albumList: [
              Releases(
                coverUrl: element!.uploader!.profilePictureUrl!,
                artist: element!.uploader!.userName,
              )
            ],
            albumPosition: 0,
          ),
        );
      }
      MyAudioHandler.setYPositionOfWidget(100);
      MyAudioHandler.setShowSmallPlayer(false);

      await Navigator.pushNamed(AppKeys.navigatorKey.currentState!.context,
          AppRoutes.fullMediaPlayerWidget);
      MyAudioHandler.setShowSmallPlayer(true);
      // MyAudioHandler.audioPlayerReset();
      // MyAudioHandler.setShowSmallPlayer(false);
    } else if (element!.type! == 2) {
      await Navigator.pushNamed(
        AppKeys.navigatorKey.currentState!.context,
        AppRoutes.fullMediaPlayerWidget,
        arguments: FullMediaPlayerWidgetParameters(
          assetPosition: widget.index,
          video: element!,
        ),
      );
    } else {}
    widget.asset = await getUpdatedAsset(assetID: element!.id!);
    _init();
  }
}
