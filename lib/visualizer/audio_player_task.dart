import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

void audioPlayerTaskEntrypoint() {
  AudioServiceBackground.run(() => AudioPlayerTask());
}

class AudioPlayerTask extends BackgroundAudioTask {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Future<void> onStart(Map<String, dynamic>? params) async {
    AudioServiceBackground.setState(
      controls: [
        MediaControl.pause,
        MediaControl.stop,
      ],
      playing: true,
    );
    await _audioPlayer.setAsset(params!['id']);
    _audioPlayer.play();
  }

  @override
  Future<void> onStop() async {
    await _audioPlayer.stop();
    await _audioPlayer.dispose();
    await super.onStop();
  }
}