import 'dart:async';
import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:audio_service/audio_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:igroove_fan_box_one/base/base.dart';
import 'package:igroove_fan_box_one/core/services/comment_service.dart';
import 'package:igroove_fan_box_one/core/services/user_service.dart';
import 'package:igroove_fan_box_one/management/helper.dart';
import 'package:igroove_fan_box_one/model/assets_model.dart';
import 'package:igroove_fan_box_one/model/releases_model.dart';
import 'package:igroove_fan_box_one/ui/pages/home/tabs/fanbox/fanbox.dart';
import 'package:provider/provider.dart';

final audioPlayer = AudioPlayer();

class MyAudioHandler extends BaseAudioHandler {
  static final MyAudioHandler _audioHandler = MyAudioHandler._internal();
  static StreamController<double> streamControllerWidgetYPosition =
      StreamController.broadcast();
  static StreamController<bool> streamControllerPlayerStatusSwitch =
      StreamController.broadcast();
  static StreamController<String> streamControllerPlayerStateUpdate =
      StreamController.broadcast();

  // New design
  static DigitalFanBoxes? fanBox;
  static StreamController<DurationState> streamControllerDuration =
      StreamController.broadcast();
  static StreamController<MediaPlayerData> streamControllerMediaPlayerData =
      StreamController.broadcast();
  static String playerState = "COMPLETED";
  static bool showSmallPlayer = false;
  static bool repeatActivated = false;
  static CommentService commentService = CommentService();
  static MediaPlayerData mediaPlayerData = MediaPlayerData();
  static DurationState durationState = const DurationState();
  static MediaDuration mediaDuration = MediaDuration();

  static StreamController<int> streamControllerHomePage =
      StreamController.broadcast();

  factory MyAudioHandler() {
    return _audioHandler;
  }

  MyAudioHandler._internal();

  pausePlayPlayer() {
    streamControllerPlayerStatusSwitch
        .add(playerState != "PLAYING" ? true : false);
    streamControllerPlayerStateUpdate.add("");
  }

  static setYPositionOfWidget(double yPosition) {
    streamControllerWidgetYPosition.add(yPosition);
    streamControllerPlayerStateUpdate.add("");
  }

  static audioPlayerStop() async {
    await audioPlayer.stop();
    streamControllerPlayerStateUpdate.add("");
  }

  static audioPlayerSeek({required Duration durationSeek}) async {
    //await audioPlayer.seek(durationSeek);

    await audioHandler.seek(durationSeek);
    streamControllerPlayerStateUpdate.add("");
  }

  static audioPlayerPause() async {
    await audioPlayer.pause();
    streamControllerPlayerStateUpdate.add("");
  }

  static audioPlayerResume() async {
    await audioPlayer.resume();
    streamControllerPlayerStateUpdate.add("");
  }

  static audioPlayerGetDuration() async {
    //await audioPlayer.getDuration();=
    streamControllerPlayerStateUpdate.add("");
  }

  static audioPlayerReset() async {
    //await audioPlayer.stop();
    //await audioPlayer.release();

    audioPlayerStop();
    mediaPlayerData = MediaPlayerData();
    durationState = const DurationState();
    mediaDuration = MediaDuration();
    streamControllerPlayerStateUpdate.add("");
    print("AudioPlayerReseted");
  }

  static setDuration({required int duration}) {
    streamControllerDuration.add(
      DurationState(
        buffered: Duration.zero,
        progress: Duration.zero,
        total: Duration(milliseconds: duration),
      ),
    );
    mediaDuration.maxDuration = Duration(milliseconds: duration);
  }

  static updateMediaPlayerData({required MediaPlayerData newMediaPlayerData}) {
    mediaPlayerData = newMediaPlayerData;

    CommentService().updateShowCommentWidget();
    streamControllerMediaPlayerData.add(mediaPlayerData);
  }

  static setPlayerState(String state) {
    playerState = state;
    streamControllerPlayerStateUpdate.add("");
  }

  static setShowSmallPlayer(bool showPlayer) {
    showSmallPlayer = showPlayer;
    streamControllerPlayerStateUpdate.add("");
  }

  static setDurationState(DurationState newDurationState) {
    durationState = newDurationState;
  }

  static updateHappened() async {
    audioPlayerStop();
    if (mediaPlayerData.albumtracks!.isNotEmpty) {
      final List<MediaItem> items = List.generate(
          mediaPlayerData.albumList?.length ?? 0,
          (index) => MediaItem(
                id: mediaPlayerData.albumtracks![index].streamingUrl ?? '',
                title: mediaPlayerData.albumtracks![index].title ?? '',
                artist: mediaPlayerData.albumtracks![index].artist,
                album: mediaPlayerData.albumList![index].title,
              ));
      _audioHandler.addQueueItems(items);
      _audioHandler.queue.add(items);
      await setupAudioFile();
    }
    streamControllerPlayerStateUpdate.add("");
  }

  static Future audioPlayerSetUrl({required String fileUrl}) async {
    await audioPlayer.setUrl(fileUrl);

    if (Platform.isIOS) {
      //int duration = await audioPlayer.getDuration();
      int duration = await audioPlayer.getDuration();
      setDuration(duration: duration);
    }
    if (Platform.isAndroid) {
      await Future.delayed(const Duration(milliseconds: 500));
      audioPlayer.onDurationChanged.listen((duration) {
        setDuration(duration: duration.inMilliseconds);
      });
    }
    streamControllerPlayerStateUpdate.add("");
  }

  static setupAudioFile() async {
    //await audioPlayer.stop();

    audioPlayerStop();

    print("Small Player Activated Streaming=> " +
        mediaPlayerData.activateStreaming.toString() +
        " => " +
        mediaPlayerData
            .albumtracks![mediaPlayerData.trackPosition!].streamingUrl!);

    String fileURL = mediaPlayerData
            .albumtracks![mediaPlayerData.trackPosition!].streamingUrl! +
        getUrlParameters();

    String filePath = "";

    if (await isFileExistAndAvailable(
            filename: mediaPlayerData
                .albumtracks![mediaPlayerData.trackPosition!].filename!) ||
        mediaPlayerData.activateStreaming == true) {
      filePath = await createFilePath(
          filename: mediaPlayerData
              .albumtracks![mediaPlayerData.trackPosition!].filename!);
    }

    if (!mediaPlayerData.activateStreaming!) {
      fileURL = filePath;
    }

    await audioPlayerSetUrl(fileUrl: fileURL);
    await playMusic();
  }

  static playMusic() async {
    if (playerState == "PLAYING") {
      await audioPlayerPause();
    } else {
      // await audioPlayerGetDuration();
      await audioPlayerResume();
    }
  }

  static checkViewTime() {
    mediaDuration.totalPlayedDuration = mediaDuration.totalPlayedDuration! +
        (mediaDuration.currentPosition!.inSeconds -
            mediaDuration.lastPosition!.inSeconds);
    print("Total view time => " +
        mediaDuration.totalPlayedDuration.toString() +
        "s");
    if (mediaDuration.totalPlayedDuration! > 60) {
      mediaDuration.totalPlayedDuration = 0;

      _countView();
    }
  }

  static _countView() async {
    UserService userService =
        Provider.of(AppKeys.navigatorKey.currentState!.context, listen: false);
    await userService.addViewCountToAsset(
        assetID:
            mediaPlayerData.albumtracks![mediaPlayerData.trackPosition!].id);
  }
  /*Future<void> _loadEmptyPlaylist() async {
    try {
     // await audioPlayer.setAudioSource(_playlist);
    } catch (e) {
      print("Error: $e");
    }
  }

  void _notifyAudioHandlerAboutPlaybackEvents() {
    audioPlayer.playbackEventStream.listen((PlaybackEvent event) {
      final playing = audioPlayer.playing;
      playbackState.add(playbackState.value.copyWith(
        controls: [
          MediaControl.skipToPrevious,
          if (playing) MediaControl.pause else MediaControl.play,
          MediaControl.stop,
          MediaControl.skipToNext,
        ],
        systemActions: const {
          MediaAction.seek,
        },
        androidCompactActionIndices: const [0, 1, 3],
        processingState: const {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.loading: AudioProcessingState.loading,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[audioPlayer.processingState]!,
        repeatMode: const {
          LoopMode.off: AudioServiceRepeatMode.none,
          LoopMode.one: AudioServiceRepeatMode.one,
          LoopMode.all: AudioServiceRepeatMode.all,
        }[audioPlayer.loopMode]!,
        shuffleMode: (audioPlayer.shuffleModeEnabled)
            ? AudioServiceShuffleMode.all
            : AudioServiceShuffleMode.none,
        playing: playing,
        updatePosition: audioPlayer.position,
        bufferedPosition: audioPlayer.bufferedPosition,
        speed: audioPlayer.speed,
        queueIndex: event.currentIndex,
      ));
    });
  }

  void _listenForDurationChanges() {
    audioPlayer.durationStream.listen((duration) {
      var index = audioPlayer.currentIndex;
      final newQueue = queue.value;
      if (index == null || newQueue.isEmpty) return;
      if (audioPlayer.shuffleModeEnabled) {
        index = audioPlayer.shuffleIndices![index];
      }
      final oldMediaItem = newQueue[index];
      final newMediaItem = oldMediaItem.copyWith(duration: duration);
      newQueue[index] = newMediaItem;
      queue.add(newQueue);
      mediaItem.add(newMediaItem);
    });
  }

  void _listenForCurrentSongIndexChanges() {
    audioPlayer.currentIndexStream.listen((index) {
      final playlist = queue.value;
      if (index == null || playlist.isEmpty) return;
      if (audioPlayer.shuffleModeEnabled) {
        index = audioPlayer.shuffleIndices![index];
      }
      mediaItem.add(playlist[index]);
    });
  }

  void _listenForSequenceStateChanges() {
    audioPlayer.sequenceStateStream.listen((SequenceState? sequenceState) {
      final sequence = sequenceState?.effectiveSequence;
      if (sequence == null || sequence.isEmpty) return;
      final items = sequence.map((source) => source.tag as MediaItem);
      queue.add(items.toList());
    });
  }*/

  /* UriAudioSource _createAudioSource(MediaItem mediaItem) {
    return AudioSource.uri(
      Uri.parse(mediaItem.extras!['url']),
      tag: mediaItem,
    );
  }*/

  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) async {
    // // manage Just Audio
    // final audioSource = mediaItems.map(_createAudioSource);
    // _playlist.addAll(audioSource.toList());
    //
    // // notify system
    // final newQueue = queue.value..addAll(mediaItems);
    // queue.add(newQueue);
  }

  @override
  Future<void> addQueueItem(MediaItem mediaItem) async {
    // // manage Just Audio
    // final audioSource = _createAudioSource(mediaItem);
    // _playlist.add(audioSource);
    //
    // // notify system
    // final newQueue = queue.value..add(mediaItem);
    // queue.add(newQueue);
  }

  @override
  Future<void> removeQueueItemAt(int index) async {
    // // manage Just Audio
    // _playlist.removeAt(index);
    //
    // // notify system
    // final newQueue = queue.value..removeAt(index);
    // queue.add(newQueue);
  }

  @override
  Future<void> play() => playMusic();

  @override
  Future<void> pause() => audioPlayer.pause();

  @override
  Future<void> seek(Duration position) => audioPlayer.seek(position);

  @override
  Future<void> skipToQueueItem(int index) async {
    // if (index < 0 || index >= queue.value.length) return;
    // if (audioPlayer.shuffleModeEnabled) {
    //   index = audioPlayer.shuffleIndices![index];
    // }
    // audioPlayer.seek(Duration.zero, index: index);
  }

  @override
  Future<void> skipToNext() async {} //=> audioPlayer.seekToNext();

  @override
  Future<void> skipToPrevious() async {} //=> audioPlayer.seekToPrevious();

  @override
  Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {
    // switch (repeatMode) {
    //   case AudioServiceRepeatMode.none:
    //     audioPlayer.setLoopMode(LoopMode.off);
    //     break;
    //   case AudioServiceRepeatMode.one:
    //     audioPlayer.setLoopMode(LoopMode.one);
    //     break;
    //   case AudioServiceRepeatMode.group:
    //   case AudioServiceRepeatMode.all:
    //     audioPlayer.setLoopMode(LoopMode.all);
    //     break;
    // }
  }

  @override
  Future<void> setShuffleMode(AudioServiceShuffleMode shuffleMode) async {
    // if (shuffleMode == AudioServiceShuffleMode.none) {
    //   audioPlayer.setShuffleModeEnabled(false);
    // } else {
    //   await audioPlayer.shuffle();
    //   audioPlayer.setShuffleModeEnabled(true);
    // }
  }

  @override
  Future customAction(String name, [Map<String, dynamic>? extras]) async {
    if (name == 'dispose') {
      await audioPlayer.dispose();
      super.stop();
    }
  }

  @override
  Future<void> stop() async {
    audioPlayerStop();
    return super.stop();
  }

  @override
  Future<Function> playFromUri(Uri uri, [Map<String, dynamic>? extras]) async {
    return () => null;
  }

  @override
  Future<Function> prepareFromUri(Uri uri,
      [Map<String, dynamic>? extras]) async {
    return () => null;
  }
}

class DurationState {
  const DurationState({this.progress, this.buffered, this.total});
  final Duration? progress;
  final Duration? buffered;
  final Duration? total;
}

class MediaDuration {
  Duration? currentPosition;
  Duration? maxDuration;
  Duration? lastPosition;
  int? totalPlayedDuration;
  Duration? currentPlayedDuration;

  MediaDuration(
      {this.currentPosition = Duration.zero,
      this.maxDuration = Duration.zero,
      this.lastPosition = Duration.zero,
      this.totalPlayedDuration = 0,
      this.currentPlayedDuration = Duration.zero});
}

class MediaPlayerData {
  final List<Releases>? albumList;
  final int? albumPosition;
  final List<AssetModel>? albumtracks;
  final int? trackPosition;
  final bool? activateStreaming;

  MediaPlayerData({
    this.albumList = const [],
    this.albumPosition,
    this.albumtracks = const [],
    this.trackPosition,
    this.activateStreaming,
  });

  MediaPlayerData copyWith({
    List<Releases>? albumList,
    int? albumPosition,
    List<AssetModel>? albumtracks,
    int? trackPosition,
    bool? activateStreaming,
  }) =>
      MediaPlayerData(
        albumList: albumList ?? this.albumList,
        albumPosition: albumPosition ?? this.albumPosition,
        albumtracks: albumtracks ?? this.albumtracks,
        trackPosition: trackPosition ?? this.trackPosition,
        activateStreaming: activateStreaming ?? this.activateStreaming,
      );

  // ToJSON
  Map<String, dynamic> toJson() => {
        'albumList': albumList!.first.toJson(),
        'albumPosition': albumPosition.toString(),
        'albumtracks': albumtracks,
        'trackPosition': trackPosition,
        'activateStreaming': activateStreaming,
      };
}
