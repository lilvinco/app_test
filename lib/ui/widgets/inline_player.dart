import 'package:better_player/better_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:igroove_fan_box_one/base/base.dart';
import 'package:igroove_fan_box_one/core/services/audio_handler.dart';
import 'package:igroove_fan_box_one/core/services/media_player_service.dart';
import 'package:igroove_fan_box_one/model/assets_model.dart';
import 'package:igroove_fan_box_one/ui/pages/home/tabs/fanbox/fanbox.dart';
import 'package:igroove_fan_box_one/ui/widgets/full_media_player_widget.dart';
import 'package:visibility_detector/visibility_detector.dart';

class InlinePlayer extends StatefulWidget {
  final String url;
  final String thumbnail;
  final bool autoPlay;
  final bool autoClose;
  final AssetModel element;

  const InlinePlayer({
    Key? key,
    required this.url,
    required this.thumbnail,
    required this.autoPlay,
    required this.autoClose,
    required this.element,
  }) : super(key: key);

  @override
  InlinePlayerState createState() => InlinePlayerState();
}

class InlinePlayerState extends State<InlinePlayer> {
  BetterPlayerController? _controller;
  BetterPlayerConfiguration? _configuration;
  BetterPlayerDataSource? _dataSource;
  BetterPlayerControlsConfiguration? _controlsConfig;
  double playFraction = 0.6;
  bool? _isDisposing;
  Duration durationPlayed = Duration.zero;
  @override
  initState() {
    _initPlayer();
    super.initState();
  }

  updateDuration(Duration duration) => durationPlayed = duration;

  _initPlayer() async {
    setState(() {
      _isDisposing = false;
    });
    _dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.url,
    );
    _controlsConfig = const BetterPlayerControlsConfiguration(
      enableMute: false,
      enableFullscreen: false,
      enableOverflowMenu: false,
      enablePlayPause: true,
      enableProgressBar: false,
      enableProgressText: false,
      controlBarColor: Colors.transparent,
      enableSkips: false,
    );
    // double ratioOfVideo = widget.element.width! / widget.element.height!;

    if (widget.element.width! / widget.element.height! <= 1) {
      // print(
      //     "ratio=> ${ratioOfVideo!} => ${widget.element.width} / ${widget.element.height}");
      _configuration = BetterPlayerConfiguration(
          aspectRatio:
              widget.element.width != null && widget.element.height != null
                  ? widget.element.width! / widget.element.height! < 0.57
                      ? 0.75
                      : widget.element.width! / widget.element.height!
                  : 16 / 9,
          looping: true,
          fit: BoxFit.cover,
          controlsConfiguration: _controlsConfig!,
          eventListener: (BetterPlayerEvent event) {
            // Get current playback position
            if (event.betterPlayerEventType == BetterPlayerEventType.progress) {
              // debugPrint('Progress has been made');
              // debugPrint('Current position: ${event.parameters}');
              updateDuration(event.parameters!['progress']);
            }
          });
    } else {
      _configuration = BetterPlayerConfiguration(
          looping: true,
          fit: BoxFit.fitWidth,
          controlsConfiguration: _controlsConfig!,
          eventListener: (BetterPlayerEvent event) {
            // Get current playback position
            if (event.betterPlayerEventType == BetterPlayerEventType.progress) {
              // debugPrint('Progress has been made');
              // debugPrint('Current position: ${event.parameters}');
              updateDuration(event.parameters!['progress']);
            }
          });
    }

    _controller = BetterPlayerController(
      _configuration!,
      betterPlayerDataSource: _dataSource,
    );
    // _controller!.setControlsEnabled(false);
  }

  @override
  deactivate() {
    if (MyAudioHandler.showSmallPlayer == true) {
     // MediaPlayerService.audioPlayerResume();
      audioPlayer.resume();
    }
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
        key: UniqueKey(),
        child: mounted
            ? BetterPlayerMultipleGestureDetector(
                onDoubleTap: () async {
                  print("onDoubleTap Hit!");
                  await Navigator.pushNamed(
                    AppKeys.navigatorKey.currentState!.context,
                    AppRoutes.fullMediaPlayerWidget,
                    arguments: FullMediaPlayerWidgetParameters(
                      assetPosition: 0,
                      video: widget.element,
                      durationPlayed: durationPlayed,
                    ),
                  );
                },
                child: BetterPlayer(controller: _controller!),
              )
            : CachedNetworkImage(
                imageUrl: widget.thumbnail,
                fit: BoxFit.fitWidth,
                placeholder: (BuildContext context, String url) => Center(
                    child: CircularProgressIndicator(
                  backgroundColor: IGrooveTheme.colors.white4,
                  valueColor: AlwaysStoppedAnimation<Color?>(
                      IGrooveTheme.colors.grey12),
                )),
                errorWidget: (BuildContext context, String url, error) =>
                    const Icon(Icons.error),
              ),
        onVisibilityChanged: (info) async {
          bool? isPlaying = _controller!.isPlaying();
          bool? initialized = _controller!.isVideoInitialized();

          if (info.visibleFraction >= playFraction) {
            if (widget.autoPlay &&
                initialized! &&
                !isPlaying! &&
                !_isDisposing!) {
              audioHandler.play();
              await _controller!.play();
            }
          } else {
            if (widget.autoClose &&
                initialized! &&
                isPlaying! &&
                !_isDisposing!) {
              await _controller!.pause();
            }
          }
        });
  }
}
