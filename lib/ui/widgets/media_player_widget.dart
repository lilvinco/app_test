import 'package:audio_service/audio_service.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:igroove_fan_box_one/base/base.dart';
import 'package:igroove_fan_box_one/constants/assets.dart';
import 'package:igroove_fan_box_one/core/services/audio_handler.dart';
import 'package:igroove_fan_box_one/core/services/comment_service.dart';
import 'package:igroove_fan_box_one/core/services/media_player_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:igroove_fan_box_one/ui/pages/home/tabs/fanbox/fanbox.dart';

class MediaPlayerWidget extends StatefulWidget {
  const MediaPlayerWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MediaPlayerWidgetState();
  }
}

class _MediaPlayerWidgetState extends State<MediaPlayerWidget> {
  bool isLoading = false;
  double yPositionWidget = 0;

  @override
  void initState() {
    print("INITSTATE MediaPlayer");

    MyAudioHandler.streamControllerMediaPlayerData.stream
        .listen((newMediaPlayerData) {
      print("New MediaPlayerData received (small)");
      if (mounted) {
        setState(() {});
      }
      MyAudioHandler.updateHappened();
    });

    MyAudioHandler.streamControllerPlayerStateUpdate.stream
        .listen((newPlayerState) {
      if (mounted) {
        setState(() {});
      }
    });

    MyAudioHandler.streamControllerWidgetYPosition.stream.listen((newPosition) {
      yPositionWidget = newPosition;
      print("Switch position to => ${yPositionWidget.toString()}");
      if (mounted) {
        setState(() {});
      }
    });

    MyAudioHandler.streamControllerPlayerStatusSwitch.stream
        .listen((playerStatus) {
      print("PlayerStatus => ${playerStatus.toString()}");
      audioHandler.play();
      if (mounted) {
        setState(() {});
      }
    });

    audioPlayer.onAudioPositionChanged.listen((Duration p) {
      MyAudioHandler.streamControllerDuration.add(DurationState(
          buffered: MyAudioHandler.mediaDuration.maxDuration,
          progress: MyAudioHandler.mediaDuration.currentPosition,
          total: MyAudioHandler.mediaDuration.maxDuration));

      MyAudioHandler.setDurationState(DurationState(
          buffered: MyAudioHandler.mediaDuration.maxDuration,
          progress: MyAudioHandler.mediaDuration.currentPosition,
          total: MyAudioHandler.mediaDuration.maxDuration));
      if (mounted) {
        setState(() => MyAudioHandler.mediaDuration.currentPosition = p);
      }
    });

    audioPlayer.onPlayerStateChanged.listen((PlayerState s) async {
      MyAudioHandler.setPlayerState(s.name);

      if (s.name == PlayerState.PLAYING.name) {
        MyAudioHandler.mediaDuration.lastPosition =
            MyAudioHandler.mediaDuration.currentPosition;
      }

      if (s.name == PlayerState.PAUSED.name) {
        //checkViewTime();
        MyAudioHandler.mediaDuration.lastPosition =
            MyAudioHandler.mediaDuration.currentPosition;
      }
      if (s.name == PlayerState.COMPLETED.name) {
        print("Track completed");
        //MyAudioHandler.checkViewTime();
        MyAudioHandler.mediaDuration.lastPosition =
            MyAudioHandler.mediaDuration.currentPosition;

        if (!CommentService.commentFieldHasFocus) {
          // Comment field has no focus so track can be skipped

          if (MyAudioHandler.repeatActivated) {
            // Repeat is activated so play same track again

            MyAudioHandler.updateMediaPlayerData(
                newMediaPlayerData: MyAudioHandler.mediaPlayerData);
          } else {
            if (MyAudioHandler.mediaPlayerData.trackPosition! <
                MyAudioHandler.mediaPlayerData.albumtracks!.length - 1) {
              // Next track available so play it

              MyAudioHandler.updateMediaPlayerData(
                  newMediaPlayerData: MyAudioHandler.mediaPlayerData.copyWith(
                      trackPosition:
                          MyAudioHandler.mediaPlayerData.trackPosition! + 1));
              audioHandler.play();
            } else {
              //Check if next release is available

              if (MyAudioHandler.mediaPlayerData.albumList!.length >
                  (MyAudioHandler.mediaPlayerData.albumPosition! + 1)) {
                MyAudioHandler.updateMediaPlayerData(
                    newMediaPlayerData: MyAudioHandler.mediaPlayerData.copyWith(
                        albumPosition:
                            MyAudioHandler.mediaPlayerData.albumPosition! + 1,
                        albumtracks: MyAudioHandler
                            .mediaPlayerData
                            .albumList![
                                MyAudioHandler.mediaPlayerData.albumPosition! +
                                    1]
                            .tracks!,
                        trackPosition: 0));
              } else {
                // Next release and next track not available

                await audioHandler.stop();
              }
            }
          }
        } else {
          // Comment field has focus so not skipping track

          await audioHandler.stop();
        }
      }
    });

    audioPlayer.onPlayerError.listen((msg) {
      print('audioPlayer error : $msg');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (MyAudioHandler.mediaPlayerData.albumtracks!.isEmpty) {
      return const SizedBox();
    }

    return Positioned(
        left: 0, right: 0, bottom: yPositionWidget, child: audioElements());
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget audioElements() {
    return Visibility(
      visible: MyAudioHandler.showSmallPlayer,
      child: GestureDetector(
        onTap: () async {
          print(mounted);
          if (mounted) {
            setState(() {
              MyAudioHandler.setShowSmallPlayer(false);
            });

            await Navigator.pushNamed(
                AppKeys.navigatorKey.currentState!.context,
                AppRoutes.fullMediaPlayerWidget);

            setState(() {
              MyAudioHandler.setShowSmallPlayer(true);
            });
          }
        },
        behavior: HitTestBehavior.opaque,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: IGrooveTheme.colors.gold,
                ),
                height: 69,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Container(
                              height: 40,
                              width: 40,
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: MyAudioHandler
                                        .mediaPlayerData
                                        .albumList![MyAudioHandler
                                            .mediaPlayerData.albumPosition!]
                                        .coverUrl ??
                                    '',
                                placeholder:
                                    (BuildContext context, String url) =>
                                        Center(
                                            child: CircularProgressIndicator(
                                  backgroundColor: IGrooveTheme.colors.white4,
                                  valueColor: AlwaysStoppedAnimation<Color?>(
                                      IGrooveTheme.colors.grey12),
                                )),
                                errorWidget:
                                    (BuildContext context, String url, error) =>
                                        const Icon(Icons.error),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 180,
                                padding: const EdgeInsets.all(0.0),
                                child: Text(
                                  MyAudioHandler
                                      .mediaPlayerData
                                      .albumtracks![MyAudioHandler
                                          .mediaPlayerData.trackPosition!]
                                      .title!,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16,
                                    letterSpacing: 0,
                                    height: 19 / 16,
                                    fontWeight: FontWeight.w500,
                                    color: IGrooveTheme.colors.white,
                                    decoration: TextDecoration.none,
                                    fontFamily: 'Graphik',
                                  ),
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                MyAudioHandler
                                    .mediaPlayerData
                                    .albumtracks![MyAudioHandler
                                        .mediaPlayerData.trackPosition!]
                                    .artist!,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 11,
                                  letterSpacing: 0,
                                  height: 16 / 13,
                                  fontWeight: FontWeight.w500,
                                  color: IGrooveTheme.colors.white!
                                      .withOpacity(0.75),
                                  decoration: TextDecoration.none,
                                  fontFamily: 'Graphik',
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () async {
                                  audioHandler.play();
                                },
                                child: MyAudioHandler.playerState != "PLAYING"
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 6.0),
                                        child: SvgPicture.asset(
                                          IGrooveAssets.svgPlayIcon,
                                          width: 16,
                                          height: 20,
                                        ),
                                      )
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 6.0),
                                        child: SvgPicture.asset(
                                          IGrooveAssets.svgPauseIcon,
                                          width: 16,
                                          height: 20,
                                        ),
                                      ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () async {
                                  MyAudioHandler.audioPlayerReset();
                                  MyAudioHandler.setShowSmallPlayer(false);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 6.0, right: 5),
                                  child: SvgPicture.asset(
                                    IGrooveAssets.svgERemoveIcon,
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: StreamBuilder<DurationState>(
                        initialData: MyAudioHandler.durationState,
                        stream: MyAudioHandler.streamControllerDuration.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            print('Duration Error:: ${snapshot.error}');
                          }
                          final durationState = snapshot.data;
                          final progress =
                              durationState?.progress ?? Duration.zero;
                          final buffered =
                              durationState?.buffered ?? Duration.zero;
                          final total = durationState?.total ?? Duration.zero;
                          return ProgressBar(
                            progress: progress,
                            buffered: buffered,
                            total: total,
                            barHeight: 3,
                            onSeek: (duration) {
                              setState(() {
                                MyAudioHandler.mediaDuration.lastPosition =
                                    duration;
                              });
                              MyAudioHandler.audioPlayerSeek(
                                  durationSeek: duration);
                            },
                            thumbCanPaintOutsideBar: false,
                            thumbRadius: 0,
                            thumbGlowRadius: 0,
                            progressBarColor: IGrooveTheme.colors.white,
                            bufferedBarColor:
                                IGrooveTheme.colors.white!.withOpacity(0.25),
                            baseBarColor:
                                IGrooveTheme.colors.white!.withOpacity(0.25),
                            thumbColor: IGrooveTheme.colors.transparent,
                            timeLabelPadding: 5,
                            timeLabelTextStyle: TextStyle(
                              fontSize: 0,
                              color: IGrooveTheme.colors.transparent,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
