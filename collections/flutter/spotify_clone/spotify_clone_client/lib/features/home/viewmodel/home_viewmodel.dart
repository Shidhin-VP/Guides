import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone_client/core/providers/current_user_notifier.dart';
import 'package:spotify_clone_client/features/home/model/repositories/home_repository.dart';
import 'package:spotify_clone_client/features/home/model/song_model.dart';

part 'home_viewmodel.g.dart';

@riverpod
Future<List<SongModel>> getAllSong(Ref ref) async {
  String token = ref.watch(currentUserProvider)!.token!;
  final res = await ref.watch(homeRepositoryProvider).listSongs(token);
  return switch (res) {
    Left(value: final l) => throw l.message,
    Right(value: final r) => r,
  };
}

@riverpod
class HomeViewModel extends _$HomeViewModel {
  late HomeRepository _homeRepository;

  @override
  AsyncValue<SongModel>? build() {
    _homeRepository = ref.watch(homeRepositoryProvider);
    return null;
  }

  Future<void>? uploadSong(
    File songFileName,
    File thumbnailFileName,
    String songName,
    String artistName,
    String hexCode,
  ) async {
    state = AsyncLoading();
    String token = ref.read(currentUserProvider)!.token.toString();
    final res = await _homeRepository.uploadSongs(
      songFileName.path,
      thumbnailFileName.path,
      songName,
      artistName,
      hexCode,
      token,
    );
    final resultValue = switch (res) {
      Left(value: final l) => state = AsyncValue.error(
        l.message,
        StackTrace.current,
      ),
      Right(value: final r) => state = AsyncValue.data(r),
    };
  }
}
