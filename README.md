# Description:
The app has an audio player implemented inside the “MediaPlayerService” class using
the plugin AudioPlayer (https://pub.dev/packages/audioplayers/). The MediaPlayerService
handles already the basic functions like play, pause, skip track, previous track, repeat
and jump to next album if exist. The player has two states, one is minimised and the other
state is fullscreen. The fullscreen player is opened when you click on the minimised one.

## Task:
The task is to integrate background audio to the “MediaPlayerService” class so that the
music can be listen even when the app is in the background. Of course the basic functions
should be also available from outside the player like play, pause, skip track, previous
track and for sure the track informations and cover. Plugin can be replaced but the basic
functionality from the "MediaPlayerService" should still work.