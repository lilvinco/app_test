import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:audio_service/audio_service.dart';
import 'package:igroove_fan_box_one/core/services/audio_handler.dart';
import 'package:igroove_fan_box_one/core/services/comment_service.dart';
import 'package:igroove_fan_box_one/core/services/user_service.dart';
import 'package:igroove_fan_box_one/injection_container.dart';
import 'package:igroove_fan_box_one/management/helper.dart';

class PlayerStateManager {
  // Listeners: Updates going to the UI
  final currentSongTitleNotifier = ValueNotifier<String>('');
  final playlistNotifier = ValueNotifier<List<String>>([]);
  final isFirstSongNotifier = ValueNotifier<bool>(true);
  final isLastSongNotifier = ValueNotifier<bool>(true);
  final isShuffleModeEnabledNotifier = ValueNotifier<bool>(false);

  // Listeners: Updates going to the UI
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

  static setYPositionOfWidget(double yPosition) {
    streamControllerWidgetYPosition.add(yPosition);
    streamControllerPlayerStateUpdate.add("");
  }

  static setShowSmallPlayer(bool showPlayer) {
    showSmallPlayer = showPlayer;
    streamControllerPlayerStateUpdate.add("");
  }

  static updateMediaPlayerData({required MediaPlayerData newMediaPlayerData}) {
    mediaPlayerData = newMediaPlayerData;

    CommentService().updateShowCommentWidget();
    streamControllerMediaPlayerData.add(mediaPlayerData);
  }

  static audioPlayerStop() async {
    PlayerStateManager().stop();
    streamControllerPlayerStateUpdate.add("");
  }

  audioPlayerSeek({required Duration durationSeek}) async {
    //await audioPlayer.seek(durationSeek);

    await audioHandler.seek(durationSeek);
    streamControllerPlayerStateUpdate.add("");
  }

  updateHappened() async {
    audioPlayerStop();
    if (mediaPlayerData.albumtracks!.isNotEmpty) {
      final List<MediaItem> items = List.generate(
          mediaPlayerData.albumList?.length ?? 0,
          (index) => MediaItem(
                id: mediaPlayerData.albumtracks![index].streamingUrl ?? '',
                title: mediaPlayerData.albumtracks![index].title ?? '',
                artist: mediaPlayerData.albumtracks![index].artist,
                album: mediaPlayerData.albumList![index].title,
                extras: {
                  'url': mediaPlayerData.albumtracks![index].streamingUrl
                },
              ));
      audioHandler.addQueueItems(items);
      audioHandler.queue.add(items);
      await setupAudioFile();
    }
    streamControllerPlayerStateUpdate.add("");
  }

  static setupAudioFile() async {
    //await _audioPlayer.stop();

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

    await PlayerStateManager().audioPlayerSetUrl(fileUrl: fileURL);
    await playMusic();
  }

  Future audioPlayerSetUrl({required String fileUrl}) async {
    // await audioPlayer.setUrl(fileUrl);

    if (Platform.isIOS) {
      Duration? duration = await audioHandler.getDuration();
      print("Im here with: ${duration?.inMilliseconds}");
      setDuration(duration: duration?.inMilliseconds ?? 0);
    }
    if (Platform.isAndroid) {
      await Future.delayed(const Duration(milliseconds: 500));
      audioHandler.getDurationStream().listen((duration) {
        setDuration(duration: duration.inMilliseconds);
      });
    }
    streamControllerPlayerStateUpdate.add("");
  }

  static setDurationState(DurationState newDurationState) {
    durationState = newDurationState;
  }

  static playMusic() async {
    streamControllerPlayerStateUpdate.add("");
  }

  static audioPlayerReset() async {
    audioPlayerStop();
    mediaPlayerData = MediaPlayerData();
    durationState = const DurationState();
    mediaDuration = MediaDuration();
    streamControllerPlayerStateUpdate.add("");
    print("AudioPlayerReseted");
  }

  final audioHandler = sl<MyAudioHandler>();

  void init() async {
    _listenToChangesInPlaylist();
    _listenToPlaybackState();
    _listenToCurrentPosition();
    _listenToBufferedPosition();
    _listenToTotalDuration();
    _listenToChangesInSong();
  }

  void _listenToChangesInPlaylist() {
    audioHandler.queue.listen((playlist) {
      if (playlist.isEmpty) {
        playlistNotifier.value = [];
        currentSongTitleNotifier.value = '';
      } else {
        final newList = playlist.map((item) => item.title).toList();
        playlistNotifier.value = newList;
      }
      _updateSkipButtons();
    });
  }

  void _listenToPlaybackState() {
    audioHandler.playbackState.listen((playbackState) {
      final isPlaying = playbackState.playing;
      final processingState = playbackState.processingState;
      if (processingState == AudioProcessingState.loading ||
          processingState == AudioProcessingState.buffering) {
        // playButtonNotifier.value = ButtonState.loading;

        //TODO: notify ui listeners, show loading
      } else if (!isPlaying) {
        streamControllerPlayerStatusSwitch
            .add(playerState != "PLAYING" ? true : false);
        streamControllerPlayerStateUpdate.add("");
      } else if (processingState != AudioProcessingState.completed) {
        streamControllerPlayerStatusSwitch
            .add(playerState != "PLAYING" ? true : false);
        streamControllerPlayerStateUpdate.add("");
      } else {
        audioHandler.seek(Duration.zero);
        audioHandler.pause();
      }
    });
  }

  void _listenToCurrentPosition() {
    AudioService.position.listen((position) {
      final oldState = durationState;
      durationState = DurationState(
        progress: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
      /*final oldState = streamControllerDuration.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );*/
      //TODO: notify ui listeners, show position
      PlayerStateManager.streamControllerDuration.add(durationState);
    });
  }

  void _listenToBufferedPosition() {
    audioHandler.playbackState.listen((playbackState) {
      final oldState = durationState;
      durationState = DurationState(
        progress: oldState.progress,
        buffered: playbackState.bufferedPosition,
        total: oldState.total,
      );
      // final oldState = progressNotifier.value;
      // progressNotifier.value = ProgressBarState(
      //   current: oldState.current,
      //   buffered: playbackState.bufferedPosition,
      //   total: oldState.total,
      // );
      //TODO: notify ui listeners, show buffered position

      PlayerStateManager.streamControllerDuration.add(durationState);
    });
  }

  void _listenToTotalDuration() {
    audioHandler.mediaItem.listen((mediaItem) {
      print("Atinka: ${mediaItem?.duration}");
      final oldState = durationState;
      durationState = DurationState(
        progress: oldState.progress,
        buffered: oldState.buffered,
        total: mediaItem?.duration ?? Duration.zero,
      );
      //TODO: notify ui listeners, show total duration

      PlayerStateManager.mediaDuration.maxDuration = mediaItem?.duration;
      PlayerStateManager.streamControllerDuration.add(durationState);
    });
  }

  void _listenToChangesInSong() {
    audioHandler.mediaItem.listen((mediaItem) {
      currentSongTitleNotifier.value = mediaItem?.title ?? '';
      _updateSkipButtons();
    });
  }

  void _updateSkipButtons() {
    final mediaItem = audioHandler.mediaItem.value;
    final playlist = audioHandler.queue.value;
    if (playlist.length < 2 || mediaItem == null) {
      isFirstSongNotifier.value = true;
      isLastSongNotifier.value = true;
    } else {
      isFirstSongNotifier.value = playlist.first == mediaItem;
      isLastSongNotifier.value = playlist.last == mediaItem;
    }
  }

  void pausePlayPlayer() async {
    if (PlayerStateManager.playerState == "PLAYING") {
      await pause();
      PlayerStateManager.playerState = "PAUSED";
    } else {
      PlayerStateManager.mediaDuration.maxDuration =
          audioHandler.mediaItem.value?.duration;
      PlayerStateManager.playerState = "PLAYING";
      await play();
    }
    streamControllerPlayerStateUpdate.add("");
  }

  static setDuration({required int duration}) {
    PlayerStateManager.streamControllerDuration.add(
      DurationState(
        buffered: Duration.zero,
        progress: Duration.zero,
        total: Duration(milliseconds: duration),
      ),
    );
    PlayerStateManager.mediaDuration.maxDuration =
        Duration(milliseconds: duration);
  }

  play() async => await audioHandler.play();
  pause() async => await audioHandler.pause();

  void seek(Duration position) => audioHandler.seek(position);

  void previous() => audioHandler.skipToPrevious();
  void next() => audioHandler.skipToNext();

  void repeat() {
    //TODO: remove repeat

    // repeatButtonNotifier.nextState();
    // final repeatMode = repeatButtonNotifier.value;
    // switch (repeatMode) {
    //   case RepeatState.off:
    //     _audioHandler.setRepeatMode(AudioServiceRepeatMode.none);
    //     break;
    //   case RepeatState.repeatSong:
    //     _audioHandler.setRepeatMode(AudioServiceRepeatMode.one);
    //     break;
    //   case RepeatState.repeatPlaylist:
    //     _audioHandler.setRepeatMode(AudioServiceRepeatMode.all);
    //     break;
    // }
  }

  void shuffle() {
    final enable = !isShuffleModeEnabledNotifier.value;
    isShuffleModeEnabledNotifier.value = enable;
    if (enable) {
      audioHandler.setShuffleMode(AudioServiceShuffleMode.all);
    } else {
      audioHandler.setShuffleMode(AudioServiceShuffleMode.none);
    }
  }

  Future<void> add(song) async {
    final mediaItem = MediaItem(
      id: song['id'] ?? '',
      album: song['album'] ?? '',
      title: song['title'] ?? '',
      extras: {'url': song['url']},
    );
    audioHandler.addQueueItem(mediaItem);
  }

  void remove() {
    final lastIndex = audioHandler.queue.value.length - 1;
    if (lastIndex < 0) return;
    audioHandler.removeQueueItemAt(lastIndex);
  }

  void dispose() {
    audioHandler.customAction('dispose');
  }

  void stop() {
    PlayerStateManager.playerState = "COMPLETED";
    audioHandler.stop();
  }
}
