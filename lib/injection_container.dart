import 'package:get_it/get_it.dart';
import 'package:igroove_fan_box_one/core/services/audio_handler.dart';
import 'package:igroove_fan_box_one/page_notifier.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerSingleton<MyAudioHandler>(await initAudioService());
  // sl.registerLazySingleton<PlaylistRepository>(() => DemoPlaylist());

  // page state
  sl.registerLazySingleton<PlayerStateManager>(() => PlayerStateManager());
}
