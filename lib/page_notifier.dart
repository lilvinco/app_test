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
  //final progressNotifier = ProgressNotifier();
  //final repeatButtonNotifier = RepeatButtonNotifier();
  final isFirstSongNotifier = ValueNotifier<bool>(true);
  //final playButtonNotifier = PlayButtonNotifier();
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
    // await audioPlayer.stop();
    streamControllerPlayerStateUpdate.add("");
  }

  audioPlayerSeek({required Duration durationSeek}) async {
    //await audioPlayer.seek(durationSeek);

    await _audioHandler.seek(durationSeek);
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
      _audioHandler.addQueueItems(items);
      _audioHandler.queue.add(items);
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

    await audioPlayerSetUrl(fileUrl: fileURL);
    await playMusic();
  }

  static Future audioPlayerSetUrl({required String fileUrl}) async {
    // await audioPlayer.setUrl(fileUrl);

    if (Platform.isIOS) {
      // int duration = await audioPlayer.getDuration();
      // setDuration(duration: duration);
    }
    if (Platform.isAndroid) {
      await Future.delayed(const Duration(milliseconds: 500));
      //   audioPlayer.onDurationChanged.listen((duration) {
      //     setDuration(duration: duration.inMilliseconds);
      //   });
    }
    streamControllerPlayerStateUpdate.add("");
  }

  static playMusic() async {
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

  final _audioHandler = sl<MyAudioHandler>();

  // Events: Calls coming from the UI
  void init() async {
    //await _loadPlaylist();
    _listenToChangesInPlaylist();
    _listenToPlaybackState();
    _listenToCurrentPosition();
    _listenToBufferedPosition();
    _listenToTotalDuration();
    _listenToChangesInSong();
  }

  /* void _listenToChangesInYPosition() {
  PlayerStateManager.streamControllerWidgetYPosition.stream.listen((newPosition) {
  yPositionWidget = newPosition;
  print("Switch position to => ${yPositionWidget.toString()}");
  if (mounted) {
  setState(() {});
  }
  });}
*/

/*  Future<void> _loadPlaylist() async {
    final mediaItems = playlist
        .map((song) => MediaItem(
              id: song['id'] ?? '',
              album: song['album'] ?? '',
              title: song['title'] ?? '',
              extras: {'url': song['url']},
            ))
        .toList();
    _audioHandler.addQueueItems(mediaItems);
  }*/

  void _listenToChangesInPlaylist() {
    _audioHandler.queue.listen((playlist) {
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
    _audioHandler.playbackState.listen((playbackState) {
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
        _audioHandler.seek(Duration.zero);
        _audioHandler.pause();
      }
    });
  }

  void _listenToCurrentPosition() {
    AudioService.position.listen((position) {
      /*final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );*/
      //TODO: notify ui listeners, show position
    });
  }

  void _listenToBufferedPosition() {
    _audioHandler.playbackState.listen((playbackState) {
      // final oldState = progressNotifier.value;
      // progressNotifier.value = ProgressBarState(
      //   current: oldState.current,
      //   buffered: playbackState.bufferedPosition,
      //   total: oldState.total,
      // );
      //TODO: notify ui listeners, show buffered position
    });
  }

  void _listenToTotalDuration() {
    _audioHandler.mediaItem.listen((mediaItem) {
      // final oldState = progressNotifier.value;
      // progressNotifier.value = ProgressBarState(
      //   current: oldState.current,
      //   buffered: oldState.buffered,
      //   total: mediaItem?.duration ?? Duration.zero,
      // );
      //TODO: notify ui listeners, show total duration
    });
  }

  void _listenToChangesInSong() {
    _audioHandler.mediaItem.listen((mediaItem) {
      currentSongTitleNotifier.value = mediaItem?.title ?? '';
      _updateSkipButtons();
    });
  }

  void _updateSkipButtons() {
    final mediaItem = _audioHandler.mediaItem.value;
    final playlist = _audioHandler.queue.value;
    if (playlist.length < 2 || mediaItem == null) {
      isFirstSongNotifier.value = true;
      isLastSongNotifier.value = true;
    } else {
      isFirstSongNotifier.value = playlist.first == mediaItem;
      isLastSongNotifier.value = playlist.last == mediaItem;
    }
  }

  void play() => _audioHandler.play();
  void pause() => _audioHandler.pause();

  void seek(Duration position) => _audioHandler.seek(position);

  void previous() => _audioHandler.skipToPrevious();
  void next() => _audioHandler.skipToNext();

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
      _audioHandler.setShuffleMode(AudioServiceShuffleMode.all);
    } else {
      _audioHandler.setShuffleMode(AudioServiceShuffleMode.none);
    }
  }

  Future<void> add(song) async {
    //final songRepository = getIt<PlaylistRepository>();
    //final song = await songRepository.fetchAnotherSong();
    final mediaItem = MediaItem(
      id: song['id'] ?? '',
      album: song['album'] ?? '',
      title: song['title'] ?? '',
      extras: {'url': song['url']},
    );
    _audioHandler.addQueueItem(mediaItem);
  }

  void remove() {
    final lastIndex = _audioHandler.queue.value.length - 1;
    if (lastIndex < 0) return;
    _audioHandler.removeQueueItemAt(lastIndex);
  }

  void dispose() {
    _audioHandler.customAction('dispose');
  }

  void stop() {
    _audioHandler.stop();
  }
}
