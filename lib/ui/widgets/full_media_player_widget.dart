// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:igroove_fan_box_one/constants/assets.dart';
import 'package:igroove_fan_box_one/core/services/audio_handler.dart';
import 'package:igroove_fan_box_one/core/services/media_player_service.dart';
import 'package:igroove_fan_box_one/management/helper.dart';
import 'package:igroove_fan_box_one/model/assets_model.dart';
import 'package:igroove_fan_box_one/ui/shared/themes.dart';
import 'package:igroove_fan_box_one/ui/widgets/comment_reply_box_widget.dart';
import 'package:igroove_fan_box_one/ui/widgets/comment_show_widget.dart';
import 'package:igroove_fan_box_one/ui/widgets/loading_overlay.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FullMediaPlayerWidgetParameters {
  int? assetPosition;
  AssetModel? video;
  Duration? durationPlayed;

  FullMediaPlayerWidgetParameters({
    this.assetPosition,
    this.video,
    this.durationPlayed,
  });
}

class FullMediaPlayerWidget extends StatefulWidget {
  final FullMediaPlayerWidgetParameters? parameters;
  const FullMediaPlayerWidget({
    Key? key,
    this.parameters,
  }) : super(key: key);

  @override
  _FullMediaPlayerWidgetState createState() => _FullMediaPlayerWidgetState();
}

class _FullMediaPlayerWidgetState extends State<FullMediaPlayerWidget> {
  bool isInAsyncCall = false;
  bool isLoading = false;
  bool isPlaying = false;
  bool isLoadingMore = false;
  int currentPage = 1;
  GlobalKey<CommentShowWidgetState> commentWidgetKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  bool isLimitReached = false;

  onLimitReached() {
    setState(() {
      isLimitReached = true;
    });
  }

  resetLimitReached() => setState(() => isLimitReached = false);

  resetPageNumber() => setState(() => currentPage = 1);

  onLoadComplete() {
    print('Executing load complete');
    setState(() {
      isLoadingMore = false;
    });
  }

  @override
  void initState() {
    print("INITSTATE MediaPlayer Max");
    super.initState();

    if (widget.parameters?.video != null) {
      MyAudioHandler.audioPlayerReset();
      MyAudioHandler.setShowSmallPlayer(false);
    }

    MyAudioHandler.streamControllerPlayerStateUpdate.stream
        .listen((newPlayerState) {
      if (mounted) {
        setState(() {});
      }
    });

    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = 200.0;

      if (maxScroll - currentScroll <= delta) {
        if (!isLimitReached) {
          print('LOAD MORE');
          if (!commentWidgetKey.currentState!.isLoading) {
            setState(() {
              currentPage += 1;
            });
            commentWidgetKey.currentState!.getComments();
          } else {
            setState(() {
              isLoadingMore = true;
            });
          }
        }
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: CommentReplyWidget(
        parameters: CommentReplyWidgetParameters(
          assetID: widget.parameters?.video != null
              ? widget.parameters!.video!.id!
              : MyAudioHandler
                  .mediaPlayerData
                  .albumtracks![MyAudioHandler.mediaPlayerData.trackPosition!]
                  .id!,
          activateFanQuestions: false,
        ),
      ),
      body: body(),
      // backgroundColor: Colors.transparent,
      backgroundColor: IGrooveTheme.colors.black2,
    );
  }

  Widget body() {
    if (isInAsyncCall) {
      return const Center(child: IGrooveProgressIndicator());
    }

    return Container(
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(
      //     begin: Alignment.topCenter,
      //     end: Alignment.bottomCenter,
      //     stops: [
      //       0.0,
      //       0.5,
      //       0.5,
      //       1.0,
      //     ],
      //     colors: [
      //       IGrooveTheme.colors.goldDark!,
      //       IGrooveTheme.colors.goldDark!,
      //       IGrooveTheme.colors.black2!,
      //       IGrooveTheme.colors.black2!,
      //     ],
      //   ),
      // ),
      //decoration: BoxDecoration(color: IGrooveTheme.colors.black2),
      child: Column(
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(color: IGrooveTheme.colors.goldDark),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        width: 18,
                        height: 9,
                        child: SvgPicture.asset(
                          IGrooveAssets.svgArrowDownIcon,
                          width: 18,
                          height: 9,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  )
                ]),
          ),
          Container(
            child: Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const ClampingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            IGrooveTheme.colors.goldDark!,
                            IGrooveTheme.colors.black2!,
                          ],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          if (widget.parameters?.video == null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Container(
                                height: 180,
                                width: 180,
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
                                  errorWidget: (BuildContext context,
                                          String url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (widget.parameters?.video != null)
                                const SizedBox(width: 20),
                              if (widget.parameters?.video != null)
                                GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () async {
                                      if (isPhoneVerificationOpen()) {
                                        return;
                                      }

                                      setState(() {
                                        if (!widget.parameters!.video!
                                            .authUserLiked!) {
                                          widget.parameters!.video!.statistics!
                                              .likes = widget.parameters!.video!
                                                  .statistics!.likes! +
                                              1;
                                        } else {
                                          widget.parameters!.video!.statistics!
                                              .likes = widget.parameters!.video!
                                                  .statistics!.likes! -
                                              1;
                                        }

                                        widget.parameters!.video!
                                                .authUserLiked =
                                            !widget.parameters!.video!
                                                .authUserLiked!;
                                      });

                                      await setAssetLike(
                                          assetID:
                                              widget.parameters!.video!.id!);
                                      widget.parameters!.video =
                                          await getUpdatedAsset(
                                              assetID: widget
                                                  .parameters!.video!.id!);

                                      await Future.delayed(
                                          const Duration(milliseconds: 100));
                                      if (mounted) {
                                        setState(() {});
                                      }
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 6.0),
                                      child: SvgPicture.asset(
                                        widget.parameters!.video!.authUserLiked!
                                            ? IGrooveAssets.svglikeFilledIcon
                                            : IGrooveAssets.svgLikeOpenIcon,
                                        width: 22,
                                        height: 22,
                                        color: widget.parameters!.video!
                                                .authUserLiked!
                                            ? IGrooveTheme.colors.primary!
                                            : IGrooveTheme.colors.white,
                                      ),
                                    )),
                              if (widget.parameters?.video != null)
                                const Spacer(),
                              Column(
                                children: [
                                  const SizedBox(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width -
                                          (widget.parameters?.video != null
                                              ? 120
                                              : 30),
                                      child: Text(
                                        widget.parameters?.video != null
                                            ? widget.parameters!.video!.title!
                                            : MyAudioHandler
                                                        .mediaPlayerData
                                                        .albumtracks![
                                                            MyAudioHandler
                                                                .mediaPlayerData
                                                                .trackPosition!]
                                                        .isNewsFeedItem ==
                                                    1
                                                ? MyAudioHandler
                                                    .mediaPlayerData
                                                    .albumtracks![MyAudioHandler
                                                        .mediaPlayerData
                                                        .trackPosition!]
                                                    .title!
                                                : MyAudioHandler
                                                        .mediaPlayerData
                                                        .albumtracks![
                                                            MyAudioHandler
                                                                .mediaPlayerData
                                                                .trackPosition!]
                                                        .order!
                                                        .toString() +
                                                    ". " +
                                                    MyAudioHandler
                                                        .mediaPlayerData
                                                        .albumtracks![
                                                            MyAudioHandler
                                                                .mediaPlayerData
                                                                .trackPosition!]
                                                        .title!,
                                        textAlign: TextAlign.center,
                                        //maxLines: 20,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                            fontSize: 20,
                                            letterSpacing: 0,
                                            height: 24 / 20,
                                            fontWeight: FontWeight.w600,
                                            color: IGrooveTheme.colors.white,
                                            decoration: TextDecoration.none),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 7),
                                  Text(
                                    widget.parameters?.video != null
                                        ? widget.parameters!.video!.artist!
                                        : MyAudioHandler
                                            .mediaPlayerData
                                            .albumtracks![MyAudioHandler
                                                .mediaPlayerData.trackPosition!]
                                            .artist!,
                                    style: TextStyle(
                                        fontSize: 14,
                                        letterSpacing: 0,
                                        height: 17 / 14,
                                        fontWeight: FontWeight.w500,
                                        color: IGrooveTheme.colors.white!
                                            .withOpacity(0.75),
                                        decoration: TextDecoration.none),
                                  ),
                                ],
                              ),
                              if (widget.parameters?.video != null)
                                const Spacer(),
                              if (widget.parameters?.video != null)
                                const SizedBox(
                                  width: 44,
                                )
                            ],
                          ),
                          if (widget.parameters?.video == null)
                            const SizedBox(height: 30),
                          if (widget.parameters?.video == null)
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: StreamBuilder<DurationState>(
                                initialData: MyAudioHandler.durationState,
                                stream: MyAudioHandler
                                    .streamControllerDuration.stream,
                                builder: (context, snapshot) {
                                  final durationState = snapshot.data;
                                  final progress =
                                      durationState?.progress ?? Duration.zero;
                                  final buffered =
                                      durationState?.buffered ?? Duration.zero;
                                  final total =
                                      durationState?.total ?? Duration.zero;
                                  return ProgressBar(
                                    progress: progress,
                                    buffered: buffered,
                                    total: total,
                                    barHeight: 3,
                                    onSeek: (duration) {
                                      setState(() {
                                        MyAudioHandler.mediaDuration
                                            .lastPosition = duration;
                                      });
                                      MyAudioHandler.audioPlayerSeek(
                                          durationSeek: duration);
                                    },
                                    thumbCanPaintOutsideBar: false,
                                    thumbRadius: 7.5,
                                    thumbGlowRadius: 20,
                                    progressBarColor: IGrooveTheme.colors.white,
                                    bufferedBarColor: IGrooveTheme.colors.white!
                                        .withOpacity(0.25),
                                    baseBarColor: IGrooveTheme.colors.white!
                                        .withOpacity(0.25),
                                    thumbColor: IGrooveTheme.colors.white,
                                    timeLabelPadding: 11,
                                    timeLabelTextStyle: TextStyle(
                                      fontSize: 11,
                                      color: IGrooveTheme.colors.white!
                                          .withOpacity(0.75),
                                      fontWeight: FontWeight.w500,
                                      height: 13 / 11,
                                    ),
                                  );
                                },
                              ),
                            ),
                          if (widget.parameters?.video == null)
                            const SizedBox(height: 10),
                          if (widget.parameters?.video == null)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(width: 20),
                                GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () async {
                                      if (isPhoneVerificationOpen()) {
                                        return;
                                      }

                                      setState(() {
                                        if (!MyAudioHandler
                                            .mediaPlayerData
                                            .albumtracks![MyAudioHandler
                                                .mediaPlayerData.trackPosition!]
                                            .authUserLiked!) {
                                          MyAudioHandler
                                              .mediaPlayerData
                                              .albumtracks![MyAudioHandler
                                                  .mediaPlayerData
                                                  .trackPosition!]
                                              .statistics!
                                              .likes = MyAudioHandler
                                                  .mediaPlayerData
                                                  .albumtracks![MyAudioHandler
                                                      .mediaPlayerData
                                                      .trackPosition!]
                                                  .statistics!
                                                  .likes! +
                                              1;
                                        } else {
                                          MyAudioHandler
                                              .mediaPlayerData
                                              .albumtracks![MyAudioHandler
                                                  .mediaPlayerData
                                                  .trackPosition!]
                                              .statistics!
                                              .likes = MyAudioHandler
                                                  .mediaPlayerData
                                                  .albumtracks![MyAudioHandler
                                                      .mediaPlayerData
                                                      .trackPosition!]
                                                  .statistics!
                                                  .likes! -
                                              1;
                                        }

                                        MyAudioHandler
                                                .mediaPlayerData
                                                .albumtracks![
                                                    MyAudioHandler.mediaPlayerData
                                                        .trackPosition!]
                                                .authUserLiked =
                                            !MyAudioHandler
                                                .mediaPlayerData
                                                .albumtracks![MyAudioHandler
                                                    .mediaPlayerData
                                                    .trackPosition!]
                                                .authUserLiked!;
                                      });

                                      await setAssetLike(
                                          assetID: MyAudioHandler
                                              .mediaPlayerData
                                              .albumtracks![MyAudioHandler
                                                  .mediaPlayerData
                                                  .trackPosition!]
                                              .id!);
                                      MyAudioHandler
                                                  .mediaPlayerData.albumtracks![
                                              MyAudioHandler.mediaPlayerData
                                                  .trackPosition!] =
                                          await getUpdatedAsset(
                                              assetID: MyAudioHandler
                                                  .mediaPlayerData
                                                  .albumtracks![MyAudioHandler
                                                      .mediaPlayerData
                                                      .trackPosition!]
                                                  .id!);

                                      await Future.delayed(
                                          const Duration(milliseconds: 100));
                                      if (mounted) {
                                        setState(() {});
                                      }
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 6.0),
                                      child: SvgPicture.asset(
                                        MyAudioHandler
                                                .mediaPlayerData
                                                .albumtracks![MyAudioHandler
                                                    .mediaPlayerData
                                                    .trackPosition!]
                                                .authUserLiked!
                                            ? IGrooveAssets.svglikeFilledIcon
                                            : IGrooveAssets.svgLikeOpenIcon,
                                        width: 22,
                                        height: 22,
                                        color: MyAudioHandler
                                                .mediaPlayerData
                                                .albumtracks![MyAudioHandler
                                                    .mediaPlayerData
                                                    .trackPosition!]
                                                .authUserLiked!
                                            ? IGrooveTheme.colors.primary!
                                            : IGrooveTheme.colors.white,
                                      ),
                                    )),
                                const Spacer(),
                                GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () async {
                                      if (MyAudioHandler
                                              .mediaPlayerData.trackPosition! !=
                                          0) {
                                        MyAudioHandler.updateMediaPlayerData(
                                            newMediaPlayerData: MyAudioHandler
                                                .mediaPlayerData
                                                .copyWith(
                                                    trackPosition: MyAudioHandler
                                                            .mediaPlayerData
                                                            .trackPosition! -
                                                        1));
                                      } else if (MyAudioHandler
                                              .mediaPlayerData.albumPosition! >
                                          0) {
                                        MyAudioHandler.updateMediaPlayerData(
                                            newMediaPlayerData: MyAudioHandler
                                                .mediaPlayerData
                                                .copyWith(
                                          albumtracks: MyAudioHandler
                                              .mediaPlayerData
                                              .albumList![MyAudioHandler
                                                      .mediaPlayerData
                                                      .albumPosition! -
                                                  1]
                                              .tracks,
                                          trackPosition: MyAudioHandler
                                                  .mediaPlayerData
                                                  .albumList![MyAudioHandler
                                                          .mediaPlayerData
                                                          .albumPosition! -
                                                      1]
                                                  .tracks!
                                                  .length -
                                              1,
                                          albumPosition: MyAudioHandler
                                                  .mediaPlayerData
                                                  .albumPosition! -
                                              1,
                                        ));
                                      }
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 6.0),
                                      child: SvgPicture.asset(
                                        IGrooveAssets.svgBackwardIcon,
                                        width: 35,
                                        height: 21,
                                        color: MyAudioHandler.mediaPlayerData
                                                        .trackPosition! !=
                                                    0 ||
                                                MyAudioHandler.mediaPlayerData
                                                        .albumPosition! >
                                                    0
                                            ? IGrooveTheme.colors.white!
                                                .withOpacity(1)
                                            : IGrooveTheme.colors.white!
                                                .withOpacity(0.5),
                                      ),
                                    )),
                                const SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () async {
                                    MyAudioHandler().play();
                                    await Future.delayed(
                                        const Duration(milliseconds: 100));
                                    if (mounted) {
                                      setState(() {});
                                    }
                                  },
                                  child: MyAudioHandler.playerState != "PLAYING"
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 6.0),
                                          child: SvgPicture.asset(
                                            IGrooveAssets.svgPlayIcon,
                                            width: 28,
                                            height: 33,
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 6.0),
                                          child: SvgPicture.asset(
                                            IGrooveAssets.svgPauseIcon,
                                            width: 28,
                                            height: 33,
                                          ),
                                        ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () async {
                                      if (MyAudioHandler
                                              .mediaPlayerData.trackPosition! <
                                          MyAudioHandler.mediaPlayerData
                                                  .albumtracks!.length -
                                              1) {
                                        MyAudioHandler.updateMediaPlayerData(
                                            newMediaPlayerData: MyAudioHandler
                                                .mediaPlayerData
                                                .copyWith(
                                                    trackPosition: MyAudioHandler
                                                            .mediaPlayerData
                                                            .trackPosition! +
                                                        1));
                                      } else if (MyAudioHandler
                                              .mediaPlayerData.albumPosition! <
                                          MyAudioHandler.mediaPlayerData
                                                  .albumList!.length -
                                              1) {
                                        MyAudioHandler.updateMediaPlayerData(
                                            newMediaPlayerData: MyAudioHandler
                                                .mediaPlayerData
                                                .copyWith(
                                          albumtracks: MyAudioHandler
                                              .mediaPlayerData
                                              .albumList![MyAudioHandler
                                                      .mediaPlayerData
                                                      .albumPosition! +
                                                  1]
                                              .tracks,
                                          trackPosition: 0,
                                          albumPosition: MyAudioHandler
                                                  .mediaPlayerData
                                                  .albumPosition! +
                                              1,
                                        ));
                                      }
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 6.0),
                                      child: SvgPicture.asset(
                                        IGrooveAssets.svgForwardIcon,
                                        width: 35,
                                        height: 21,
                                        color: MyAudioHandler.mediaPlayerData
                                                        .trackPosition! <
                                                    MyAudioHandler
                                                            .mediaPlayerData
                                                            .albumtracks!
                                                            .length -
                                                        1 ||
                                                MyAudioHandler.mediaPlayerData
                                                        .albumPosition! <
                                                    MyAudioHandler
                                                            .mediaPlayerData
                                                            .albumList!
                                                            .length -
                                                        1
                                            ? IGrooveTheme.colors.white!
                                                .withOpacity(1)
                                            : IGrooveTheme.colors.white!
                                                .withOpacity(0.5),
                                      ),
                                    )),
                                const Spacer(),
                                GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () async {
                                      MyAudioHandler.repeatActivated =
                                          !MyAudioHandler.repeatActivated;
                                      await Future.delayed(
                                          const Duration(milliseconds: 100));
                                      if (mounted) {
                                        setState(() {});
                                      }
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 6.0),
                                      child: SvgPicture.asset(
                                        IGrooveAssets.svgRepeatIcon,
                                        width: 19,
                                        height: 22,
                                        color: MyAudioHandler.repeatActivated
                                            ? IGrooveTheme.colors.primary
                                            : IGrooveTheme.colors.white!
                                                .withOpacity(1),
                                      ),
                                    )),
                                const SizedBox(
                                  width: 20,
                                )
                              ],
                            ),
                          SizedBox(
                            height: widget.parameters?.video == null ? 15 : 15,
                          ),
                        ],
                      ),
                    ),
                    CommentShowWidget(
                      key: commentWidgetKey,
                      parameters: CommentShowWidgetParameters(
                        onLimitReached: onLimitReached,
                        resetLimitReached: resetLimitReached,
                        onLoadComplete: onLoadComplete,
                        resetPageNumber: resetPageNumber,
                        assetID: widget.parameters?.video != null
                            ? widget.parameters!.video!.id!
                            : MyAudioHandler
                                .mediaPlayerData
                                .albumtracks![MyAudioHandler
                                    .mediaPlayerData.trackPosition!]
                                .id!,
                        activateFanQuestions: false,
                        pageNumber: currentPage,
                      ),
                    ),
                    isLoadingMore ? loadingWidget() : const SizedBox(),
                    Container(
                      height: 150,
                      color: IGrooveTheme.colors.black2!,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
