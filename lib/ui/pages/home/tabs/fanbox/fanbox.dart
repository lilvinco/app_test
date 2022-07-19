import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:igroove_fan_box_one/api/auth.dart';
import 'package:igroove_fan_box_one/base/base.dart';
import 'package:igroove_fan_box_one/constants/assets.dart';
import 'package:igroove_fan_box_one/core/services/audio_handler.dart';
import 'package:igroove_fan_box_one/core/services/media_player_service.dart';
import 'package:igroove_fan_box_one/core/services/user_service.dart';
import 'package:igroove_fan_box_one/igroove.dart';
import 'package:igroove_fan_box_one/injection_container.dart';
import 'package:igroove_fan_box_one/localization/localization.dart';
import 'package:igroove_fan_box_one/main.dart';
import 'package:igroove_fan_box_one/management/helper.dart';
import 'package:igroove_fan_box_one/model/releases_model.dart';
import 'package:igroove_fan_box_one/page_notifier.dart';
import 'package:igroove_fan_box_one/ui/pages/common/error_alert.dart';
import 'package:igroove_fan_box_one/ui/pages/home/tabs/album/album.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:igroove_fan_box_one/ui/widgets/app_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FanBoxParameters {
  final DigitalFanBoxes fanBox;

  FanBoxParameters({required this.fanBox});
}

class FanBoxPage extends StatefulWidget {
  final FanBoxParameters parameters;

  FanBoxPage({Key? key, required this.parameters}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FanBoxPageState();
  }
}

class _FanBoxPageState extends State<FanBoxPage> {
  bool isLoading = false;
  late DigitalFanBoxes fanBox;
  List<Releases> releasesList = [];
  final playerStateManager = sl<PlayerStateManager>();

  @override
  void initState() {
    fanBox = widget.parameters.fanBox;
    getAlbum();

    PlayerStateManager.streamControllerPlayerStateUpdate.stream
        .listen((newPlayerState) {
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  getAlbum() async {
    setState(() {
      isLoading = true;
    });

    await Auth.check();

    try {
      UserService userService = Provider.of(
          AppKeys.navigatorKey.currentState!.context,
          listen: false);
      ReleaseModel response =
          await userService.getReleases(fanBoxId: fanBox.id!);

      if (response.status == 1) {
        if (response.releases == null) {
          return;
        }

        releasesList = response.releases!;
        //TODO: call loadPlaylist from page notifier\
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

  checkDownloadNeeded() async {
    setState(() => isLoading = true);
    for (Releases release in releasesList) {
      if (release.tracks != null) {
        int totalTrack = release.tracks!.length;
        for (var track in release.tracks!) {
          int currentTrackIndex = release.tracks!.indexOf(track) + 1;
          bool fileDoesExist =
              await isFileExistAndAvailable(filename: track.filename!);
          print("File does exist (${fileDoesExist.toString()})"
              " => ${track.filename}");

          if (!fileDoesExist) {
            await downloadFile(
                filename: track.filename!,
                url: track.downloadUrl!,
                total: totalTrack,
                current: currentTrackIndex,
                title: release.title! + " - " + track.title!);
          }
        }
      }
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: IGrooveAppBarWidget.fanBoxAppBar(
            leftTitle: "Music",
            onLeftTap: () {
              PlayerStateManager.setYPositionOfWidget(100);
              Navigator.pop(context);
            }) as PreferredSize,
        backgroundColor: IGrooveTheme.colors.fanBoxBlack,
        body: fanBoxOverview());
  }

  Map<String, dynamic> filters = {
    'sort': AppLocalizations().fanboxTabMusic!,
    'label': 'All',
  };

  List<Map<String, String>> tabs = [
    {'name': AppLocalizations().fanboxTabMusic!, 'value': 'music'},
  ];
  int selectedTab = 0;

  Widget headerView() {
    String dateRelease =
        DateFormat('MMMM yyyy', IGroove.localeSubject.value.languageCode)
            .format(DateTime.fromMillisecondsSinceEpoch(
                (int.parse(fanBox.releaseDateTimestamp!.toString()) * 1000)));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    height: 180,
                    width: 180,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: fanBox.coverUrl ?? '',
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
              ],
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 105,
                      child: Text(
                        fanBox.title!,
                        maxLines: 3,
                        style: TextStyle(
                            fontSize: 20,
                            letterSpacing: 0,
                            height: 20 / 20,
                            fontWeight: FontWeight.w600,
                            color: IGrooveTheme.colors.white,
                            decoration: TextDecoration.none),
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      fanBox.artists!,
                      style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 0,
                        height: 17 / 14,
                        fontWeight: FontWeight.w500,
                        color: IGrooveTheme.colors.white!,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      dateRelease,
                      style: TextStyle(
                        fontSize: 12,
                        letterSpacing: 0,
                        height: 15 / 12,
                        fontWeight: FontWeight.w500,
                        color: IGrooveTheme.colors.white!.withOpacity(0.75),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () async {
                    if (PlayerStateManager.playerState == "PLAYING") {
                      playerStateManager.pausePlayPlayer();
                      //MyAudioHandler.pausePlayPlayer();
                    } else {
                      if (PlayerStateManager
                          .mediaPlayerData.albumtracks!.isNotEmpty) {
                        print("Tap");
                        playerStateManager.pausePlayPlayer();
                        //MyAudioHandler.pausePlayPlayer();
                      } else {
                        print("Pat");
                        // await MyAudioHandler.audioPlayer.stop();
                        PlayerStateManager.updateMediaPlayerData(
                            newMediaPlayerData: MediaPlayerData(
                                activateStreaming: true,
                                albumtracks: releasesList[0].tracks!,
                                trackPosition: 0,
                                albumList: releasesList,
                                albumPosition: 0));
                        PlayerStateManager.setShowSmallPlayer(true);
                        playerStateManager.pausePlayPlayer();
                      }
                    }
                  },
                  child: PlayerStateManager.playerState == "PLAYING"
                      ? SvgPicture.asset(
                          IGrooveAssets.svgbigPauseButtonYellowIcon,
                          width: 50,
                          height: 50,
                        )
                      : SvgPicture.asset(
                          IGrooveAssets.svgbigPlayButtonYellowIcon,
                          width: 50,
                          height: 50,
                        ),
                ),
              ],
            ),
          ]),
    );
  }

  Widget fanBoxOverview() {
    if (isLoading) {
      return loadingWidget();
    }

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          headerView(),
          const SizedBox(height: 30),
          DefaultTabController(
            length: tabs.length,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(
                              AppKeys.navigatorKey.currentState!.context)
                          .size
                          .width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TabBar(
                          indicatorPadding: const EdgeInsets.only(
                              right: 25, top: 0, bottom: 0),
                          labelPadding: const EdgeInsets.only(
                              right: 25, top: 0, bottom: 0),
                          unselectedLabelStyle: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                          unselectedLabelColor:
                              IGrooveTheme.colors.white!.withOpacity(0.6),
                          labelStyle: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                          labelColor: IGrooveTheme.colors.white,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorWeight: 2,
                          indicatorColor: Theme.of(context).primaryColor,
                          indicator: UnderlineTabIndicator(
                            borderSide: BorderSide(
                              color: IGrooveTheme.colors.primary!,
                              width: 2,
                            ),
                            insets:
                                const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                          ),
                          isScrollable: true,
                          onTap: (int index) => setState(() {
                            filters['label'] = tabs[index]['value'];
                            selectedTab = index;
                          }),
                          tabs: tabs.map((Map<String, String> e) {
                            return Tab(
                                child: Row(
                              children: [
                                Text(e["name"]!),
                              ],
                            ));
                          }).toList(),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          width: MediaQuery.of(AppKeys
                                      .navigatorKey.currentState!.context)
                                  .size
                                  .width -
                              40,
                          height: 1,
                          color: IGrooveTheme.colors.white!.withOpacity(0.1),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          selectedTab == 0
              ? AlbumPage(
                  parameters: FanBoxPageParameters(fanBox: fanBox),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
