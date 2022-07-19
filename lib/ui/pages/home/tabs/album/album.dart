import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:igroove_fan_box_one/api/auth.dart';
import 'package:igroove_fan_box_one/base/base.dart';
import 'package:igroove_fan_box_one/constants/assets.dart';
import 'package:igroove_fan_box_one/core/services/audio_handler.dart';
import 'package:igroove_fan_box_one/core/services/media_player_service.dart';
import 'package:igroove_fan_box_one/core/services/user_service.dart';
import 'package:igroove_fan_box_one/injection_container.dart';
import 'package:igroove_fan_box_one/localization/localization.dart';
import 'package:igroove_fan_box_one/main.dart';
import 'package:igroove_fan_box_one/management/helper.dart';
import 'package:igroove_fan_box_one/model/assets_model.dart';
import 'package:igroove_fan_box_one/model/releases_model.dart';
import 'package:igroove_fan_box_one/page_notifier.dart';
import 'package:igroove_fan_box_one/ui/pages/common/error_alert.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:igroove_fan_box_one/ui/pages/home/tabs/fanbox/fanbox.dart';
import 'package:provider/provider.dart';

class FanBoxPageParameters {
  final DigitalFanBoxes fanBox;

  FanBoxPageParameters({required this.fanBox});
}

class AlbumPage extends StatefulWidget {
  final FanBoxPageParameters parameters;
  const AlbumPage({Key? key, required this.parameters}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AlbumPageState();
  }
}

class _AlbumPageState extends State<AlbumPage> with TickerProviderStateMixin {
  List<Releases> releasesList = [];
  MyAudioHandler mediaService = MyAudioHandler();
  bool? isLoading = false;
  late DigitalFanBoxes fanBox;
  final playerStateManager = sl<PlayerStateManager>();

  @override
  void initState() {
    fanBox = widget.parameters.fanBox;
    super.initState();
    getAlbumInfo();
  }

  getAlbumInfo() async {
    setState(() {
      isLoading = true;
    });

    await Auth.check();

    UserService userService =
        Provider.of(AppKeys.navigatorKey.currentState!.context, listen: false);

    try {
      ReleaseModel response =
          await userService.getReleases(fanBoxId: fanBox.id!);

      if (response.status == 1) {
        if (response.releases == null) {
          return;
        }

        releasesList = response.releases!;
      } else {
        await Navigator.pushNamed(
            AppKeys.navigatorKey.currentState!.context, AppRoutes.errorAlert,
            arguments: ErrorAlertParams(
                title: AppLocalizations.of(context)!.generalDialogSorry!,
                message:
                    AppLocalizations.of(context)!.generalDialogSorryText!));
      }
    } on DioError catch (e) {
      print(e.toString());

      await Navigator.pushNamed(
          AppKeys.navigatorKey.currentState!.context, AppRoutes.errorAlert,
          arguments: ErrorAlertParams(
              title: AppLocalizations.of(context)!.generalDialogSorry!,
              message: e.toString()));
    } catch (e, stacktrace) {
      print(e.toString());
      print(stacktrace.toString());
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return pageContent();
  }

  Widget pageContent() {
    if (isLoading!) {
      return Padding(
        padding: const EdgeInsets.only(top: 100),
        child: loadingWidget(),
      );
    }

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListView.builder(
              padding: const EdgeInsets.only(top: 0),
              itemCount: releasesList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return buildReleases(releaseIndex: index);
              },
            ),
            const SizedBox(
              height: 100,
            )
          ],
        ));
  }

  Widget buildReleases({required int releaseIndex}) {
    return Column(
      children: [
        releaseItemSeperator(release: releasesList[releaseIndex]),
        buildList(releaseIndex: releaseIndex),
      ],
    );
  }

  Widget releaseItemSeperator({required Releases release}) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: Container(
                  height: 67,
                  width: 67,
                  foregroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: release.coverUrl ?? '',
                    placeholder: (BuildContext context, String url) => Center(
                        child: CircularProgressIndicator(
                      backgroundColor: IGrooveTheme.colors.white4,
                      valueColor: AlwaysStoppedAnimation<Color?>(
                          IGrooveTheme.colors.grey12),
                    )),
                    errorWidget: (BuildContext context, String url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Container(
                  height: 67,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        release.title!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: IGrooveTheme.colors.white,
                            fontSize: 16,
                            height: 16 / 16,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        release.artist!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: IGrooveTheme.colors.white,
                            fontSize: 13,
                            height: 16 / 13,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        buildListItemSeperator(),
      ],
    );
  }

  Widget buildList({required int releaseIndex}) {
    return Column(
      children: [
        ListView.builder(
          padding: const EdgeInsets.all(0),
          itemCount: releasesList[releaseIndex].tracks!.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return buildListItem(
                releaseIndex: releaseIndex, trackPosition: index);
          },
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget buildListItem(
      {required int releaseIndex, required int trackPosition}) {
    AssetModel track = releasesList[releaseIndex].tracks![trackPosition];
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        playerStateManager.stop();
        //await MyAudioHandler.audioPlayer.stop();
        PlayerStateManager.updateMediaPlayerData(
          newMediaPlayerData: MediaPlayerData(
              activateStreaming: true,
              albumtracks: releasesList[releaseIndex].tracks!,
              trackPosition: trackPosition,
              albumList: releasesList,
              albumPosition: releaseIndex),
        );
        PlayerStateManager.setShowSmallPlayer(true);
        playerStateManager.pausePlayPlayer();
      },
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 18, 0, 21),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 27,
                            child: Text(
                              track.order.toString(),
                              style: TextStyle(
                                  color: IGrooveTheme.colors.white!
                                      .withOpacity(0.6),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 125,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Text(
                                    track.title!,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: IGrooveTheme.colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Flexible(
                                  child: Text(
                                    track.artist!,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: IGrooveTheme.colors.white!
                                            .withOpacity(0.6),
                                        fontSize: 13,
                                        height: 16 / 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () async {
                              if (mounted) {
                                if (PlayerStateManager.showSmallPlayer ==
                                    false) {
                                  playerStateManager.stop();
                                  //await MyAudioHandler.audioPlayer.stop();
                                  PlayerStateManager.updateMediaPlayerData(
                                    newMediaPlayerData: MediaPlayerData(
                                        activateStreaming: true,
                                        albumtracks:
                                            releasesList[releaseIndex].tracks!,
                                        trackPosition: trackPosition,
                                        albumList: releasesList,
                                        albumPosition: releaseIndex),
                                  );
                                }
                                setState(() {
                                  PlayerStateManager.setShowSmallPlayer(false);
                                });

                                await Navigator.pushNamed(
                                    AppKeys.navigatorKey.currentState!.context,
                                    AppRoutes.fullMediaPlayerWidget);

                                setState(() {
                                  PlayerStateManager.setShowSmallPlayer(true);
                                });
                              }
                            },
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  IGrooveAssets.svgfChatIcon,
                                  width: 15,
                                  height: 15,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  track.statistics!.commentsFormatted!,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: IGrooveTheme.colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
          buildListItemSeperator(),
        ],
      ),
    );
  }

  Widget buildListItemSeperator() {
    return Container(
      width:
          MediaQuery.of(AppKeys.navigatorKey.currentState!.context).size.width,
      height: 1,
      color: IGrooveTheme.colors.white!.withOpacity(0.1),
    );
  }
}
