import 'package:just_audio/just_audio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone_client/features/home/model/repositories/home_local_repository.dart';
import 'package:spotify_clone_client/features/home/model/song_model.dart';

part 'current_song_notifier.g.dart';

@riverpod
class CurrentSongNotifier extends _$CurrentSongNotifier {
  AudioPlayer? audioPlayer;
  bool isPlaying = false;
  late HomeLocalRepository _homeLocalRepository;
  @override
  AsyncValue<SongModel>? build() {
    _homeLocalRepository = ref.watch(homeLocalRepositoryProvider);
    return null;
  }

  Future<void> updateSong(SongModel song) async {
    try {
      await audioPlayer?.stop();
      audioPlayer = AudioPlayer();
      final audioSource = AudioSource.uri(Uri.parse(song.songURL));
      await audioPlayer!.setAudioSource(audioSource);
      audioPlayer!.playerStateStream.listen((playerState) {
        if (playerState.processingState == ProcessingState.completed) {
          audioPlayer!.seek(Duration.zero);
          audioPlayer!.pause();
          isPlaying = false;
          state = AsyncData(state!.value!.copyWith(color: state!.value!.color));
        }
      });
      _homeLocalRepository.uploadLocalSong(song);
      audioPlayer!.play();
      isPlaying = true;
      state = AsyncData(song);
    } catch (e) {
      print("Error Playing: ${e.toString()}");
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }

  void togglePlay() {
    if (isPlaying) {
      audioPlayer?.pause();
    } else {
      audioPlayer?.play();
    }
    isPlaying = !isPlaying;
    state = AsyncData(state!.value!.copyWith(color: state?.value!.color));
  }

  void seekSong(double value) {
    audioPlayer!.seek(
      Duration(
        milliseconds: (value * audioPlayer!.duration!.inMilliseconds).toInt(),
      ),
    );
  }
}
